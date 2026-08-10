# E-commerce Search & Personalization — Architecture Brief (sample)

*Architecture-stage artifact. Illustrative sample, not a real engagement.*

## Design at a glance

```
Storefront ──► Search Service ──► Index (catalog data, near real-time)
    │                │
    │                └──► Query pipeline: normalize → match → rank → personalize
    │
    └─────────► Recommendation Rail (read-model, refreshed nightly)
                    ▲
                    └── Events: views, adds-to-cart, purchases (from storefront)
```

- **Search Service** — owns the index, the query pipeline, and relevance tuning. The storefront talks only to this service; search stays replaceable.
- **Recommendation Rail** — a denormalized read-model built from purchase events. It is *not* a service with an API — the storefront reads it directly. Cheap to build, fast to render.
- **Experiment Framework** — allocation and metrics collection are infrastructure; each experiment is a config change, not a deploy.

## Key decisions

| Decision | Choice | Why |
|----------|--------|-----|
| Index refresh | Incremental (event-fed), full re-index nightly | Cost review showed full re-index 3× nightly cost of incremental; incremental keeps the index fresh during the day |
| Personalization source | Purchase events only (MVP) | Browsing events added later; purchase signals convert best |
| Recommendation rail | Read-model, not a service | No API boundary needed; avoids latency and operational cost |
| Experiment metric | Search-to-purchase conversion | Defined at discovery; relevance alone is not a business metric |

## Deferred

- Browsing-event personalization (needs event volume validation first)
- Multi-currency ranking signals
- Semantic (embedding-based) search — revisit when catalog exceeds 1M SKUs
