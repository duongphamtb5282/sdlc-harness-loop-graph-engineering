#!/usr/bin/env bash
# ═══════════════════════════════════════════════════════════════
# verify-showcase.sh — keep the showcase repository self-consistent
#
# Checks: README integrity (sections + every linked deliverable
# exists), portfolio completeness (deliverables, skills, demo
# projects), repository hygiene (no stray junk, no configuration
# files, no embedded git repos).
#
# Usage: ./scripts/verify-showcase.sh
# Exit:  0 = all checks green · 1 = failures
# ═══════════════════════════════════════════════════════════════

set -uo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"
FAILURES=0
WARNINGS=0

echo "━━━ Showcase Repository Verification ━━━━━━━━━━━━━━━━━━━"
echo ""

# ── 1. README presence + core sections ───────────────────────
echo "[1/4] README integrity..."
if [ -f README.md ]; then
  echo "  ✅ README.md present"
else
  echo "  ❌ README.md missing"
  FAILURES=$((FAILURES+1))
fi
for section in "Architecture" "Spec-Driven Development" "Commands" "Showcase Deliverables" "Contact"; do
  if grep -q "$section" README.md 2>/dev/null; then
    echo "  ✅ section: $section"
  else
    echo "  ⚠️  section missing: $section"
    WARNINGS=$((WARNINGS+1))
  fi
done

# ── 2. Every deliverable linked from the README exists ───────
echo ""
echo "[2/4] Linked deliverables..."
LINKS=$(grep -oE '\[[^]]+\]\((documents|skills|demo-projects)/[^)]+\)' README.md | sed -E 's/.*\(([^)]+)\)/\1/' | sort -u)
MISSING=0
for link in $LINKS; do
  if [ -f "$link" ]; then
    echo "  ✅ $link"
  else
    echo "  ❌ $link (broken link)"
    MISSING=1
  fi
done
[ -n "$LINKS" ] || echo "  ⚠️  no deliverable links found in README"
[ $MISSING -eq 0 ] || FAILURES=$((FAILURES+1))

# ── 3. Portfolio completeness (required sample set) ──────────
echo ""
echo "[3/4] Portfolio set..."
REQUIRED=(
  "documents/generated/proposals/Clinic-portal-proposal.html"
  "documents/generated/architecture/architect.drawio"
)
for f in "${REQUIRED[@]}"; do
  if [ -f "$f" ]; then
    echo "  ✅ $f"
  else
    echo "  ❌ $f (missing from portfolio)"
    FAILURES=$((FAILURES+1))
  fi
done
echo ""
echo "  — capability skills —"
REQUIRED_SKILLS=(
  "ai-native-product-engineering"
  "fraud-risk-systems"
  "ecommerce-personalization"
  "fintech-payments"
  "data-platforms-analytics"
  "mobile-cross-platform"
  "cloud-architecture-migration"
  "security-hardening"
)
for name in "${REQUIRED_SKILLS[@]}"; do
  f="skills/$name/SKILL.md"
  if [ -f "$f" ]; then
    echo "  ✅ $f"
  else
    echo "  ❌ $f (missing from skills)"
    FAILURES=$((FAILURES+1))
  fi
done
echo ""
echo "  — demo projects —"
REQUIRED_DEMOS=(
  "restaurant-loyalty-app"
  "insurance-claims-assistant"
  "ecommerce-search-personalization"
  "nextjs-saas-dashboard"
  "flutter-booking-app"
)
for name in "${REQUIRED_DEMOS[@]}"; do
  f="demo-projects/$name/README.md"
  if [ -f "$f" ]; then
    echo "  ✅ $f"
  else
    echo "  ❌ $f (missing from demo-projects)"
    FAILURES=$((FAILURES+1))
  fi
done

# ── 4. Hygiene — no junk, no config, no embedded repos ───────
echo ""
echo "[4/4] Hygiene..."
DS=$(find . -name ".DS_Store" | wc -l | tr -d ' ')
if [ "$DS" -eq 0 ]; then
  echo "  ✅ no .DS_Store junk"
else
  echo "  ⚠️  $DS .DS_Store file(s) — remove them"
  WARNINGS=$((WARNINGS+1))
fi
CFG=$(find . -name "*.yaml" -o -name "*.yml" -o -name ".mcp.json" | wc -l | tr -d ' ')
if [ "$CFG" -eq 0 ]; then
  echo "  ✅ no configuration files shipped"
else
  echo "  ⚠️  $CFG configuration file(s) present — showcase ships documents only"
  WARNINGS=$((WARNINGS+1))
fi
if [ -d .git ]; then
  echo "  ⚠️  .git present — showcase has no history by design"
  WARNINGS=$((WARNINGS+1))
else
  echo "  ✅ no git history"
fi
if [ -d .claude-flow ]; then
  echo "  ⚠️  .claude-flow present — harness runtime data, remove before sharing"
  WARNINGS=$((WARNINGS+1))
else
  echo "  ✅ no harness runtime data"
fi
GITS=$(find . -name ".git" -type d 2>/dev/null | wc -l | tr -d ' ')
if [ "$GITS" -eq 0 ]; then
  echo "  ✅ no embedded git repositories"
else
  echo "  ⚠️  $GITS embedded git repo(s) found"
  WARNINGS=$((WARNINGS+1))
fi

echo ""
echo "━━━ Result: $FAILURES failure(s), $WARNINGS warning(s) ━━━"
exit $FAILURES
