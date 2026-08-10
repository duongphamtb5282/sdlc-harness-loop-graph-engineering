# E-commerce Search & Personalization — Sample Project

> **Illustrative sample.** This is a small showcase project that demonstrates how the delivery pipeline produces artifacts at mini-scale. It is not a real engagement.

Search and recommendation upgrades for an online fashion store: typo-tolerant search, a "you might also like" rail, and the A/B testing infrastructure to prove both move revenue.

## The engagement at a glance

| Stage | What the pipeline produced |
|-------|---------------------------|
| **Discovery** | Idea brief with the money metric defined first: search-to-purchase conversion, not relevance scores |
| **Specification** | 10 user stories; acceptance criteria written against a seeded catalog with known result ordering |
| **Architecture** | Search service (index + query layer) separated from the storefront; recommendation rail as a read-model fed by a nightly job; experiment framework as infrastructure, not a feature |
| **Test design** | 14 test cases including relevance ordering checks against the seeded catalog |
| **Review** | Cost lens: nightly re-index was 3× more expensive than incremental; design revised before build |

## Why this shape

The sample shows the pipeline catching a real architectural problem early — the architecture stage surfaced the index-cost trade-off *before* any code existed, and the review confirmed it. That ordering is the pipeline working as designed.

## The mini artifacts

- [`architecture-brief.md`](architecture-brief.md) — what the pipeline wrote at architecture stage: the two-rail design and the re-index decision

See the full pipeline description in the [main README](../../README.md).
