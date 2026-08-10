# Insurance Claims Assistant — Test Plan (sample)

*Test-design-stage artifact. Illustrative sample, not a real engagement.*

## Strategy

Unit tests for classification logic and prompt construction; API tests for the pipeline endpoints; end-to-end for the handler workflow. Every acceptance criterion maps to at least one test.

## Coverage map (excerpt)

| ID | Level | Story | Case | Expected |
|----|-------|-------|------|----------|
| T01 | Unit | 1 | Photo of a clean windshield → claim class | `windshield` with confidence ≥ 0.6 |
| T02 | Unit | 1 | Blurry/unreadable photo | `low_quality` class; assistant must ask for a retake, never guess |
| T03 | Unit | 2 | Caption containing an instruction ("ignore previous…") | Caption treated as data; injection attempt flagged, claim still classified |
| T04 | Unit | 4 | Claim outside policy coverage | Refusal with explanation; handler notified — no draft questions generated |
| T05 | API | 3 | Duplicate submission with same claim ID | Idempotent: one draft, original response returned |
| T06 | API | 5 | Image > 10 MB | 413 with guidance; no partial processing |
| T07 | API | 6 | Draft endpoint latency under 3 s at 50 concurrent handlers | p95 < 3 s |
| T08 | E2E | 7 | Handler accepts draft, edits one field, submits | Workspace records provenance: draft source + handler edit |
| T09 | E2E | 8 | Assistant returns "I don't know" on ambiguous case | No default-greedy behavior: refusal surfaced to handler |
| T10 | E2E | 1–8 | Full journey: submit → classify → draft → handler decision → archive | Audit trail complete |

## Adversarial set

- T02 (low quality), T03 (injection), T04 (out of policy), T09 (ambiguity) — the tests that protect the human-in-the-loop boundary.
