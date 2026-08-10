# Restaurant Loyalty App — Sample Project

> **Illustrative sample.** This is a small showcase project that demonstrates how the delivery pipeline produces artifacts at mini-scale. It is not a real engagement.

A loyalty program for a local restaurant chain: customers earn points on orders, staff redeem points at the counter, and management sees loyalty metrics per location.

## The engagement at a glance

| Stage | What the pipeline produced |
|-------|---------------------------|
| **Discovery** | Idea brief: 3 customer segments, 2 staff roles, success metric (repeat-visit rate +15%) |
| **Specification** | 9 user stories with acceptance criteria; MVP scoped to ordering, earning, and redemption |
| **Architecture** | Two-service design (customer app + staff POS widget) on a single backend; points ledger with idempotent earning — a double-tap can never credit twice |
| **Test design** | 12 test cases: 6 unit, 3 API, 3 end-to-end covering the earn → redeem → settle journey |
| **Review** | 3 findings, all resolved before handoff — the ledger idempotency surfaced as a critical fix during review |

## Why this shape

The project was deliberately small: one ledger invariant (idempotent points), one staff workflow (redemption), one management view (metrics). Every stage still ran — that's the point of a disciplined pipeline: it doesn't shrink the process for small projects, it shrinks the *scope*.

## The mini artifacts

- [`requirements-brief.md`](requirements-brief.md) — what the pipeline wrote at specification stage: objectives, stories, acceptance criteria

See the full pipeline description in the [main README](../../README.md).
