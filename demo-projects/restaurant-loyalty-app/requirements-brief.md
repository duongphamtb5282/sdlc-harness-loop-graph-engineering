# Restaurant Loyalty App — Requirements Brief (sample)

*Specification-stage artifact. Illustrative sample, not a real engagement.*

## Objectives

1. Increase repeat visits at the 4 restaurant locations by 15% within 6 months.
2. Give staff a redemption flow that takes under 10 seconds at the counter.
3. Provide management a weekly loyalty report per location.

## Scope (MVP)

| In scope | Out of scope |
|----------|--------------|
| Points earning on in-store orders | Points on delivery-app orders |
| Redemption at the counter (staff-operated) | Customer self-redemption |
| Per-location loyalty reporting | Multi-brand loyalty |
| Ledger with idempotent point credits | Points expiry / tiered status |

## User stories

1. As a customer, I earn 1 point per $1 spent so that repeat visits accumulate value.
2. As a customer, I can see my point balance so that I know what I've earned.
3. As staff, I can redeem points for a discount so that the transaction completes in one step.
4. As staff, I can look up a customer by phone number so that redemption is fast.
5. As management, I can view weekly loyalty metrics per location so that I can evaluate the program.
6. As a customer, I get a receipt that shows the points earned so that the program feels transparent.
7. As staff, a double-tap can never credit points twice so that the ledger stays honest.
8. As management, I can export a monthly loyalty report so that accounting can verify program cost.
9. As staff, I can reverse a mistaken redemption so that errors are correctable.

## Acceptance criteria (excerpts)

- **Story 7 (idempotency):** submitting the same order webhook twice credits points exactly once; a retry with the same order ID returns the original result.
- **Story 5 (reporting):** the weekly report is available within 30 minutes of the Monday cutoff and matches the ledger to the cent.

## Success metrics & baselines

| Metric | Baseline | Target |
|--------|----------|--------|
| Repeat-visit rate | 38% | ≥ 53% |
| Redemption time | — | ≤ 10 s |
| Ledger discrepancy | — | 0 (reconciled weekly) |
