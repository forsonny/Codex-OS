# Codex-OS Best Practices
> Your development philosophy: how we plan, build, test, review, and ship software—safely and fast.

This document defines the _non‑negotiables_ for day‑to‑day engineering. Project‑local rules in `.codex-os/standards/` may extend this, but must not weaken safety or quality.

---

## 1) Principles
- **Small, reversible steps.** Bias to incremental changes with a clear rollback.
- **Tests prove behavior.** Production code without tests is a liability.
- **Write it down.** Decisions belong in ADRs, specs, and commit messages.
- **Security by default.** Least privilege, safe defaults, zero‑trust assumptions.
- **Performance and accessibility are features.** Treat them as requirements.
- **Automation over heroics.** Codify repeatable tasks in scripts/CI.
- **Measure, then optimize.** Observe with logs/metrics/traces before tuning.

---

## 2) Definition of Done (DoD)
A change is “done” when:
1. **Task acceptance criteria** are satisfied and linked in the PR.
2. **Automated tests** (unit+integration+lint+typecheck) pass in CI.
3. **Docs updated** (README, usage, and any relevant spec/ADR).
4. **Security checks** (SAST/deps/secret scan) pass.
5. **Observability** added or updated if new behavior needs visibility.
6. **Rollout plan** exists (feature flag, migration plan, or changelog).
7. **Reviewer sign‑off** obtained; PR describes _what_ and _why_.

---

## 3) Branching & Commits
### 3.1 Branching
- Default: **trunk‑based** with short‑lived feature branches.
- Name: `feat/<scope>-<short-title>` or `fix/<scope>-<short-title>`.
- Keep branches under ~3 days; split if growing large.

### 3.2 Commit Style (Conventional Commits)
Use present tense, imperative mood; keep subject ≤ 72 chars.
```
<type>(<scope>): <subject>

<body - why, not just what. Wrap at 72.>

<footer - BREAKING CHANGE:, closes #123, spec/task IDs>
```
Types: `feat`, `fix`, `chore`, `docs`, `test`, `refactor`, `perf`, `build`, `ci`, `revert`.

### 3.3 Commit Hygiene
- **One logical change per commit.** Keep diffs reviewable (<200 LOC when possible).
- **Commit early, commit often** _with passing tests_. If not green, use WIP branches or draft PRs.
- Reference spec/task IDs in body (e.g., `Spec: 2025-08-22-profile; Task: T3`).

---

## 4) Testing Strategy
### 4.1 Testing Pyramid
- **Unit** (fast, isolated, majority of tests).
- **Integration** (exercise boundaries: DB, queue, external API; use local containers/mocks).
- **E2E/contract** (critical user journeys; run nightly or on release candidates).

### 4.2 Rules
- New behavior requires **failing test first** (TDD when practical).
- **Deterministic tests**: no real network; fixed seeds for randomness; freeze time when needed.
- Prefer **test names as specs**: `it_returns_403_when_token_missing`.
- Use **fixtures/builders** to avoid brittle tests; avoid deep assert chains.
- For flaky tests: `@flaky` is **not** a fix—stabilize or quarantine then fix.

### 4.3 Coverage
- Target thresholds defined per repo; use coverage as a **signal**, not a goal.
- Critical modules must be **behavior‑covered** regardless of numeric coverage.

---

## 5) Code Review
- **Reviewer checklist:**
  - Correctness: tests reflect behavior; negative cases covered.
  - Simplicity: can this be smaller or clearer?
  - Security: input validation, authz, secrets handling, SSRF/RCE risk?
  - Reliability: timeouts, retries, idempotency for external calls.
  - Observability: logs at boundaries, metrics for SLOs, trace spans.
  - Docs: PR explains why; ADR/spec updated if architecture changed.
- **Author responsibilities:**
  - Provide context (spec links, screenshots/logs).
  - Call out risky areas and how to roll back.
  - Be responsive; if review stalls, slice the change.

---

## 6) Documentation
- Keep **README** runnable (setup, start, test in ≤ 5 minutes).
- **ADRs** for significant decisions under `docs/ADRs/NNNN-*.md`.
- **Inline docs**: explain _why_ (link to spec/issue) more than _what_.
- Update **API docs** (OpenAPI/GraphQL schema) with code changes.

---

## 7) CI/CD
- CI must run: lint, typecheck, unit, integration (as feasible), security scans, build.
- All mainline merges must be **green**.
- Use **preview environments** for feature branches where practical.
- Releases are **automated**; version via Conventional Commits + semantic‑release or equivalent.
- Add **smoke tests** post‑deploy; gate rollout with health checks/SLOs.

---

## 8) Security
- Never commit secrets. Use a secrets manager; load via env/CI.
- Validate and sanitize all inputs; prefer allow‑lists.
- Use parameterized queries/ORM to avoid injection.
- Enforce **authn/authz** at boundaries; default deny.
- Set **timeouts** and **size limits** on all I/O.
- Keep dependencies updated; monitor CVEs; have a rapid patch path.
- Log **security‑relevant events** (auth changes, permission denials) with privacy in mind.

---

## 9) Observability
- **Structured logging** at INFO for high‑level events; DEBUG for diagnosis (off by default in prod).
- **Metrics** for throughput, latency, errors; define SLOs where user‑facing.
- **Tracing** across service boundaries; propagate correlation IDs.
- Include log/metric names in runbooks; avoid cardinality explosions.

---

## 10) Data & Migrations
- Backwards‑compatible, **two‑step** migrations: write‑compat, then read‑switch, then cleanup.
- Migrations are **idempotent** and **rehearsed** in staging with prod‑like data volume.
- Include **rollback plan** and **data backfills** as needed.
- For PII, define **retention** and **minimization**; document data flows.

---

## 11) Config & Flags
- **12‑factor** config via environment; no env‑specific code paths.
- **Feature flags** for risky changes; default off; remove once settled.
- **Kill switches** for new dependencies and experiments.

---

## 12) Performance & Reliability
- Establish **budgets** (e.g., p95 latency, memory, cold start).
- Avoid N+1 queries; paginate and index appropriately.
- Use timeouts, retries with jitter, and circuit breakers for outbound calls.
- Prefer **idempotent** operations for at‑least‑once delivery systems.

---

## 13) Accessibility & i18n
- Follow WCAG AA where applicable.
- Keyboard navigation and focus states are first‑class.
- Externalized copy; avoid hard‑coded strings for translatable UIs.

---

## 14) Tooling & Reproducibility
- **Pinned toolchains** via lockfiles and containerized dev (Dev Container/Docker).
- `make`/`just`/`npm scripts` for common tasks: setup, test, lint, run.
- One‑command local bootstrap: `make dev` or `just dev`.

---

## 15) Ownership & On‑Call
- Every module/service has an **owner** and a **runbook**.
- Incidents: blameless postmortems with action items and owners.
- Track **error budgets**; slow feature velocity when burning too fast.

---

## 16) Style & Readability
- Prefer **clear names** over comments; when non‑obvious, document the why.
- Avoid deep nesting; extract pure functions.
- Refactor opportunistically with tests; avoid drive‑by churn.

---

## 17) Pull Request Template (copy into `.github/PULL_REQUEST_TEMPLATE.md`)
```md
## What
Summary of the change.

## Why
Link to spec/task/issue. Describe the problem and the chosen approach.

## How
Key implementation notes, trade‑offs, and alternatives considered.

## Tests
- [ ] Unit
- [ ] Integration
- [ ] E2E (if applicable)
- [ ] Screenshots/logs attached
- [ ] Observability added/updated

## Rollout
Flag/migration plan, rollback steps.

## Risks
Known risks and mitigations.
```

---

## 18) ADR Template (copy into `docs/ADRs/0001-record.md`)
```md
# ADR NNNN: <Title>
Date: YYYY‑MM‑DD
Status: Proposed | Accepted | Superseded by ADR NNNN

## Context
What problem are we solving, constraints, and forces?

## Decision
What we chose and why (succinct).

## Consequences
Positive, negative, and follow‑ups.

## Alternatives Considered
Bulleted list with pros/cons.
```

---

## 19) Checklists
### New Service
- [ ] README with setup/run/test
- [ ] Health endpoint + smoke tests
- [ ] CI pipeline configured
- [ ] Observability baseline (logs/metrics/traces)

### Risky Change
- [ ] Feature flag / kill switch
- [ ] Migration rehearsed + rollback
- [ ] Runbook updated
- [ ] On‑call informed (if production‑facing)

---

_Amend this document with PRs; major shifts require an ADR._
