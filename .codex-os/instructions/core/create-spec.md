# Codex-OS — Core Workflow: Create Spec

> Goal: turn a PRD (product requirements) into an actionable, reviewable **spec package** with
> - a user-facing requirements doc (`srd.md`),
> - a detailed technical plan (`tech-spec.md`),
> - and a prioritized task list with acceptance criteria (`tasks.md`).

- **Applies when:** starting any new feature/product or re-architecting major components.
- **Outputs live at:** `.codex-os/specs/YYYY-MM-DD-<kebab-title>/`.
- **Source of truth order:** project-local `.codex-os/` → global `~/.codex-os/`.

---

## 0) Quickstart

If you use the helper wrapper:

```bash
bin/co-create-spec "Short feature title"
```

Or directly with Codex CLI:

```bash
codex exec --ask-for-approval "
Create a new spec for: <Short feature title>.
Follow .codex-os/instructions/core/create-spec.md.
Create: srd.md, tech-spec.md, tasks.md in a dated folder under .codex-os/specs/.
"
```

---

## 1) Inputs

- **PRD / SRD material** (problem, users, goals, non‑goals, metrics)
- **Product docs**: `.codex-os/product/{mission.md, roadmap.md, decisions.md, stack.md}`
- **Standards**: `.codex-os/standards/{tech-stack.md, code-style.md, best-practices.md}`
- Any compliance/regulatory constraints (security, privacy, data residency)
- Prior decisions/ADRs that affect scope

---

## 2) Output Structure

Create a new folder:

```
.codex-os/specs/YYYY-MM-DD-<kebab-title>/
  srd.md         # product/requirements, clarified
  tech-spec.md   # technical solution, risks, alternatives
  tasks.md       # prioritized, testable work items
  assets/        # optional: diagrams, mockups
  api/           # optional: openapi.yaml, grpc.proto
  models/        # optional: schema.sql, prisma/ entities, ERD images
```

**Spec ID:** `YYYYMMDD-<kebab-title>` (embed at top of each file).

**Owners:** 1 DRI + backup. List stakeholders for review/signoff.

---

## 3) Naming & Metadata

- **Folder name:** `YYYY-MM-DD-<kebab-title>` (e.g., `2025-08-23-user-profiles`)
- **Front-matter (each file):**
  ```yaml
  ---
  spec_id: 20250823-user-profiles
  title: User Profiles
  owners: [@alice, @bob]
  status: draft
  updated: 2025-08-23
  links:
    prd: ../srd.md
    decisions: ../../product/decisions.md
  ---
  ```

---

## 4) Step-by-Step

### Step A — Frame the SRD (from PRD)
1. Copy the PRD into `srd.md` using the template in Appendix A.
2. Clarify **users, jobs-to-be-done, scope, non-goals, success metrics**.
3. Call out **assumptions** and **open questions** explicitly.
4. Confirm **NFRs**: performance budgets, availability targets, a11y, i18n, observability.

### Step B — Author the Tech Spec
1. Choose/reference the stack (`product/stack.md`), documenting constraints.
2. Draft architecture (C4-style): context → container → component.
3. Define data model + migrations; include an ERD or table schema.
4. Define APIs with example requests/responses; include OpenAPI if applicable.
5. Address security & privacy: authZ/authN, data classification, secrets, PII flows.
6. Production hygiene: logging, metrics, tracing, alerting, SLOs and dashboards.
7. Risks & alternatives: at least one alternative with trade-offs, and a rollback plan.

### Step C — Derive Tasks
1. Break down into **atomic, testable tasks**; each should fit a small PR.
2. For each task include: ID, title, rationale, changed files, test plan, acceptance criteria, estimate.
3. Order by **critical path**. Tag tasks by type (feature, infra, docs, tests, migration).
4. Include **checkpoints** that produce user-visible value early.

### Step D — Review & Sign-off
- Run the **Quality Gate** (Section 5) checklist.
- Stakeholder review: product, tech lead, security, data, QA.
- Capture decisions in `product/decisions.md` (ADR entries).
- Update file headers `status: approved` when signed off.

---

## 5) Quality Gate (must pass before execution)

- ✅ Scope is explicit; **non-goals** are listed.
- ✅ NFRs defined with numeric targets (perf, availability, latency, budgets).
- ✅ Data model reviewed; migrations and rollback paths documented.
- ✅ Security & privacy reviewed; secrets, PII handling, threat sketch included.
- ✅ Observability plan: logs, metrics, traces, alerts, runbooks.
- ✅ Test strategy: unit, integration, e2e; test data & fixtures plan.
- ✅ Operational readiness: CI, lint/format, codeowners, preview envs.
- ✅ Risks and **alternatives** documented.
- ✅ Acceptance criteria for each task; pass/fail is objective.
- ✅ Estimation ranges for tasks and a milestone outline.
- ✅ Dependencies and external teams identified.

---

## 6) Definition of Done (for the spec)

- Spec files complete and linked (`srd.md`, `tech-spec.md`, `tasks.md`).
- All checklists in Section 5 are satisfied or explicitly waived with sign-off.
- Owners + reviewers assigned; ADRs updated where relevant.
- Tasks are prioritized and “ready” (independent, testable, ACs clear).

---

## 7) Handover to Execution

- Create the tracking issue/epic referencing the spec ID.
- Use `bin/co-exec-tasks <spec-dir>` (or your workflow) to start implementation.
- Keep the spec live: update tasks, risks, and decisions as the plan evolves.

---

# Appendix A — `srd.md` Template

```md
---
spec_id: <id>
title: <short title>
owners: [<github handles>]
status: draft
updated: <YYYY-MM-DD>
---

## Summary
One-paragraph description, user and business value.

## Users & Jobs
- Primary users and their jobs-to-be-done.
- Personas, contexts, constraints.

## Goals
- G1 ...
- G2 ...
- Success metrics: <KPI, target, measurement source>

## Non-Goals
- NG1 ...
- NG2 ...

## Scope
In-scope features, flows, and boundaries.

## User Experience
Links to mockups/flows (assets/). Accessibility and i18n notes.

## Assumptions
- A1 ...
- A2 ...

## Open Questions
- Q1 ...
- Q2 ...
```

---

# Appendix B — `tech-spec.md` Template

```md
---
spec_id: <id>
title: <short title> — Technical Spec
owners: [<github handles>]
status: draft
updated: <YYYY-MM-DD>
---

## Architecture Overview
- Context and constraints
- High-level diagram (assets/)

## Components
- <service/module>: responsibilities, interfaces, failure modes

## Data Model
- Entities and relationships (models/)
- Migrations and rollback

## APIs
- REST/GraphQL/gRPC endpoints
- Example requests/responses
- OpenAPI (api/openapi.yaml)

## Security & Privacy
- AuthN/AuthZ model
- Secrets, key rotation
- PII handling, data retention

## Observability & SRE
- Logs/metrics/traces
- Alerts and SLOs
- Dashboards and runbooks

## Performance & NFRs
- Latency/throughput budgets
- Availability targets
- Resource limits

## Risks & Alternatives
- R1 (mitigation)
- Alternative A vs B (trade-offs)

## Deployment
- Environments, CI/CD, feature flags
- Rollback strategy
```

---

# Appendix C — `tasks.md` Template

```md
---
spec_id: <id>
title: <short title> — Task Plan
owners: [<github handles>]
status: draft
updated: <YYYY-MM-DD>
---

## Legend
Type: feat | infra | tests | docs | migration
Estimate: S (≤2h), M (≤1d), L (≤3d), XL (>3d)

## Tasks (prioritized)
1. [ID-001] <title> (Type: feat, Est: M)
   - Rationale: why this task exists
   - Changes: list of files/dirs expected
   - Test Plan: unit/integration/e2e bullets
   - Acceptance Criteria:
     - [ ] AC1 objective
     - [ ] AC2 objective
2. [ID-002] <title> (Type: tests, Est: S)
   - ...

## Milestones
- M1: <name> — tasks [ID-001 .. ID-00N], goal & success criteria
- M2: <name> — ...

## Out of Scope / Parking Lot
- P1 ...
- P2 ...
```
