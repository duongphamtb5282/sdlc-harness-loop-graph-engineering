#!/usr/bin/env bash
# ═══════════════════════════════════════════════════════════════
# sitemap.sh — inventory of the showcase repository
#
# Lists every sample deliverable, capability skill, and demo
# project with size, so the showcase's contents are visible at a
# glance.
#
# Usage: ./scripts/sitemap.sh
# ═══════════════════════════════════════════════════════════════

set -uo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

echo "━━━ Showcase Deliverables ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

for dir in proposals architecture infrastructure costs; do
  path="documents/generated/$dir"
  [ -d "$path" ] || continue
  echo "── $dir ──"
  for f in "$path"/*; do
    [ -f "$f" ] || continue
    size=$(du -h "$f" | cut -f1)
    printf "  %8s  %s\n" "$size" "${f#$path/}"
  done
  echo ""
done

echo "── skills ──"
for f in skills/*/SKILL.md; do
  [ -f "$f" ] || continue
  size=$(du -h "$f" | cut -f1)
  printf "  %8s  %s\n" "$size" "${f#skills/}"
done
echo ""

echo "── demo-projects ──"
for f in demo-projects/*/*; do
  [ -f "$f" ] || continue
  size=$(du -h "$f" | cut -f1)
  printf "  %8s  %s\n" "$size" "${f#demo-projects/}"
done
echo ""

TOTAL=$(du -sh documents 2>/dev/null | cut -f1)
echo "── totals ──"
echo "  documents/: $TOTAL"
COUNT=$(find documents skills demo-projects -type f 2>/dev/null | wc -l | tr -d ' ')
echo "  files: $COUNT"
echo ""
echo "━━━ ${PWD##*/} — $COUNT deliverable file(s) ━━━"
