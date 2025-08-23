# Codex-OS — Plan Product Workflow

> Purpose: Turn a raw PRD (or idea) into a clear, prioritized plan and updated product docs that the coding loop can execute immediately.

---

## Scope & When To Use
Use this workflow when a project is **new**, the PRD just landed, or product direction has shifted and you need to realign roadmap, decisions, and stack.

**You will produce:**
- Updated product docs in `.codex-os/product/`
  - `mission.md` (vision, audience, value)
  - `roadmap.md` (milestones, timeline, scope)
  - `decisions.md` (key choices as ADRs)
  - `stack.md` (languages, frameworks, infra, CI/CD)
- Optionally, a seed spec folder in `.codex-os/specs/<date>-<kebab-title>/` with `srd.md` and a starter `tasks.md` if the PRD is ready.

---

## Inputs (read these first)
- The PRD or source document (drop at `.codex-os/specs/srd.md`).
- Any existing files in `.codex-os/product/` and `.codex-os/standards/`.
- Constraints: deadlines, compliance, budget, team capacity, target platforms.

---

## Definition of Ready (DoR)
Before you proceed to execution, make sure you have:

- [ ] Clear problem statement and success criteria
- [ ] Target users & primary use-cases
- [ ] Out-of-scope list
- [ ] MVP cut and phase plan
- [ ] Risks & mitigations documented
- [ ] A minimally opinionated stack agreed (or proposal ready for decision)

If any box is unchecked, record the assumptions and continue; add a task to validate them.

---

## Step-by-Step Procedure

### 1) Absorb & Frame
1. Read the PRD (`srd.md`). Extract:
   - Problem, goals, non-goals
   - Users/personas & jobs-to-be-done
   - Success metrics / KPIs
2. Write a concise **Problem One-Liner** and **Outcome One-Liner** in `mission.md`.

### 2) Shape the Solution Space
1. Sketch scope as a phased plan: **MVP → v1 → v1.x**.
2. Identify “must-have vs nice-to-have” using MoSCoW or RICE (note method in `decisions.md`).

### 3) Choose or Propose a Stack
1. Check `.codex-os/standards/tech-stack.md`. If absent or insufficient, propose in `stack.md`:
   - Language/runtime, web framework, DB, queue/cache, auth, hosting
   - Testing, lint/format, CI/CD, container strategy
2. Record trade-offs as ADR entries in `decisions.md`.

### 4) Risks & Unknowns
1. List **Top N Risks** (e.g., data model uncertainty, integration limits, latency SLOs).
2. Add small validating tasks (spikes) to the upcoming spec’s `tasks.md`.

### 5) Roadmap & Milestones
1. Turn phases into milestones in `roadmap.md` with dates/owners.
2. For the next milestone, ensure acceptance criteria are testable.

### 6) Prepare for Execution
1. If the PRD is ready, create `.codex-os/specs/<date>-<kebab-title>/`:
   - Copy the PRD into `srd.md`
   - Draft `tech-spec.md` outline
   - Draft `tasks.md` starting with scaffolding, data model, first endpoints/UI, tests
2. Link the spec from `roadmap.md`.

### 7) Commit & Announce
1. Commit changes with message: `product: plan update (spec <id>)`.
2. Share the plan summary (Problem, Outcome, MVP, Risks, First tasks).

---

## Artifacts & Templates

### `product/mission.md` (template)
```md
# Mission
**Problem**: <one-liner>  
**Outcome**: <what success looks like, one-liner>  
**Audience**: <primary users/personas>  
**Value**: <why this matters>  
**Scope (MVP)**: <short bullets>  
**Non-Goals**: <bullets>  
**Metrics**: <KPI list + targets>
```

### `product/roadmap.md` (template)
```md
# Roadmap
> Method: <MoSCoW | RICE | custom>

## Milestones
| ID | Name             | Target Date | Owner  | Scope Summary | Links                  |
|----|------------------|-------------|--------|---------------|------------------------|
| M0 | Planning         | YYYY-MM-DD  | <you>  | PRD triage    | spec:<id> (if any)     |
| M1 | MVP              | YYYY-MM-DD  | <lead> | must-haves    | spec:<id>              |
| M2 | v1 foundation    | YYYY-MM-DD  | <lead> | perf/hardening| issues:#, spec:<id>    |

## Phases
- **MVP**: <bullets>
- **v1**: <bullets>
- **v1.x**: <bullets>

## Dependencies & Blockers
- <list>
```

### `product/decisions.md` (ADR-style template)
```md
# Decisions (ADRs)
## ADR-YYYYMMDD-<slug>
**Context**: <what forces/constraints led to this>  
**Decision**: <the choice>  
**Consequences**: <trade-offs, follow-ups>  
**Status**: Proposed | Accepted | Rejected
```

### `product/stack.md` (template)
```md
# Stack
## Application
- Language/Runtime: <e.g., TypeScript / Node 20>
- Framework: <e.g., Fastify / Next.js / FastAPI>
- UI: <e.g., React / Tailwind>
- APIs: <REST | GraphQL | gRPC>

## Data & Infra
- DB: <Postgres version>, Migrations: <tool>, ORM: <tool>
- Cache/Queue: <Redis/Rabbit/etc>
- Auth: <JWT/OAuth/OIDC/provider>
- Observability: <logs/metrics/traces toolkit>
- Hosting: <platform/region/SLA>

## DevEx
- Package manager: <pnpm/pip/poetry>
- Lint/Format: <eslint/prettier/ruff/black>
- Tests: <frameworks and coverage target>
- CI/CD: <runner + pipeline link>
- Containers: <Dockerfile + compose or nix>
```

### Seed Spec (optional) — `.codex-os/specs/<date>-<kebab-title>/tasks.md`
```md
# Tasks
1. **Scaffold project**
   - Create README, manifest, src/, tests/, CI, Dockerfile, .editorconfig, .gitignore
   - Add lint/format/test config; add initial CI job
   - _Acceptance_: repo boots locally; CI green on empty suite

2. **Domain model sketch**
   - Define core entities & relationships; write migrations
   - _Acceptance_: migrations run; models lint clean; unit tests pass

3. **First API/UI slice**
   - Implement smallest viable vertical feature from PRD
   - _Acceptance_: e2e test covers happy path; docs updated

4. **Risk spike: <topic>**
   - Run a time-boxed experiment; document findings in `decisions.md`
   - _Acceptance_: recommendation merged into plan; follow-up tasks filed
```

---

## Quality, Safety & Collaboration
- Prefer small, reversible steps; avoid big-bang changes.
- Record assumptions in the spec; close the loop later with facts.
- Add tests for non-trivial logic; keep CI green.
- Accessibility, security, and performance are first-class; add checks early.

---

## Invocation Snippets (for CLI wrappers)

**Planning (non-destructive):**
```
Read .codex-os/instructions/core/plan-product.md.
Read existing product docs in .codex-os/product/.
Update roadmap/mission/decisions/stack as needed.
Keep changes consistent with project standards in .codex-os/standards/.
```

**Seed spec from PRD:**
```
Create a new spec in .codex-os/specs/<date>-<kebab-title>/ based on srd.md.
Draft tech-spec.md and tasks.md per this workflow.
Link the spec from product/roadmap.md.
```
