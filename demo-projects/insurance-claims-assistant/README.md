# Insurance Claims Assistant — Sample Project

> **Illustrative sample.** This is a small showcase project that demonstrates how the delivery pipeline produces artifacts at mini-scale. It is not a real engagement.

An AI assistant that helps claims handlers triage auto-insurance claims: it reads the submitted photos and description, classifies the claim type, and drafts the first eligibility questions for the handler — never makes a decision alone.

## The engagement at a glance

| Stage | What the pipeline produced |
|-------|---------------------------|
| **Discovery** | Idea brief with a hard constraint: the assistant *assists*, the handler *decides* — human-in-the-loop is a requirement, not a feature |
| **Specification** | 8 user stories; acceptance criteria written around refusal behavior ("I don't know" must be a valid answer) |
| **Architecture** | Three-tier design: intake service → classification pipeline → handler workspace; every AI output carries confidence and a source trace |
| **Test design** | 15 test cases including the adversarial ones: blurry photos, unrelated images, out-of-policy claims |
| **Review** | Security lens flagged prompt-injection via photo captions; mitigated before sign-off |

## Why this shape

Small scope, sharp edges: the interesting engineering is in the guardrails — what the assistant is *not* allowed to do. The sample shows how the pipeline captures non-functional requirements like refusal behavior and makes them testable.

## The mini artifacts

- [`test-plan.md`](test-plan.md) — what the pipeline wrote at test-design stage: cases mapped to stories, including the adversarial set

See the full pipeline description in the [main README](../../README.md).
