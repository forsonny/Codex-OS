# Codex-OS — Execute Tasks (Spec Workflow)

> **Purpose**: Implement all tasks defined in a spec’s `tasks.md` safely and iteratively, producing working software, tests, and docs.  
> **Audience**: Codex CLI (non-interactive) or developers following Codex-OS manually.
>
> **Inputs**
> - Spec folder: `.codex-os/specs/<YYYY-MM-DD-kebab-title>/`
>   - `srd.md` — PRD / problem / goals
>   - `tech-spec.md` — architecture, data, APIs, risks
>   - `tasks.md` — numbered, testable tasks with acceptance criteria
> - Product context: `.codex-os/product/{mission.md, roadmap.md, decisions.md, stack.md}`
> - Standards: `.codex-os/standards/{tech-stack.md, code-style.md, best-practices.md, code-style/<lang>.md}`

---

## 1) Read & Align

1. Open the spec folder and read, in order:
   - `srd.md` → users, goals, success metrics.
   - `tech-spec.md` → architecture boundaries, data models, interfaces, risks.
   - `tasks.md` → the work plan; confirm numbering and dependencies.
2. Skim product docs for constraints:
   - `stack.md` (framework/tooling), `decisions.md` (ADRs), `roadmap.md` (sequence).
3. Load standards:
   - Code style, testing policy, security practices, language-specific guides.
4. Record any assumptions or missing details directly in the spec (append an **Open Questions** section) and propose answers before implementation.

---

## 2) Plan the Sequence

- Build a quick dependency map from `tasks.md` (what must happen before what).  
- Prefer vertical slices that deliver a thin end‑to‑end path early (feature flag if needed).  
- Identify “risky” tasks (migrations, auth, external APIs). Mark them for extra review.

**Deliverable**: a short **Execution Plan** appended to `tech-spec.md` or added as `plan.md` in the spec folder:
- Order of tasks
- Branching strategy
- Test strategy (what is unit/e2e; fixtures; seed data)
- Rollback strategy for risky changes

---

## 3) Create a Working Branch

```bash
git checkout -b spec/<date>-<name>
```

- Keep this branch for the duration of the spec.  
- Each task will be implemented in a short‑lived feature branch branching off this spec branch.

---

## 4) For Each Task (from `tasks.md`)

> Repeat this loop per task `T<n>` until all are complete.

### 4.1 Prepare
- Create branch: `git checkout -b feat/T<n>-<slug>`
- Re‑read the task block: scope, acceptance criteria, changed files, test plan.
- Confirm dependencies are met; if not, update plan or unblock.

### 4.2 Implement Minimal Changes
- Create/modify code **only as much as necessary** to meet acceptance criteria.
- Write unit tests alongside code; include e2e tests where specified.
- Keep changes small and isolated; prefer new modules over risky rewrites.

### 4.3 Quality Gate
- Lint/format: run formatter and linters (as defined in standards).
- Run test suite (unit + e2e if applicable); ensure green locally.
- Update docs if user‑facing behavior or interfaces changed.

### 4.4 Commit
Use small, descriptive commits. Final squashed commit for the task should follow:

```
<scope>: implement T<n> — <short description> (spec <YYYY-MM-DD-name>)

Why:
- <reasoning>

Changes:
- <major files or modules>

Tests:
- <what tests cover the change>
```

### 4.5 PR & Review
- Open a PR to the spec branch: `feat/T<n>-<slug> -> spec/<date>-<name>`
- Link the task in `tasks.md` and lines in the spec if relevant.
- Attach test output or screenshots if UI/API visible.
- Address feedback quickly; avoid scope creep in this PR.

### 4.6 Merge & Update
- Merge after approvals and green CI.
- Update `tasks.md`:
  - Mark the task **[x] done**
  - Add a one‑line summary, PR link, and commit hash.
- If the implementation caused a decision change, add an ADR entry to `product/decisions.md`.

---

## 5) Checkpoints & Releases

- After key milestones (e.g., after tasks T1–T3), run **Analyze Product** workflow and update `product/analysis.md`.
- When the spec’s MVP path is complete:
  - Bump version and update `CHANGELOG.md`.
  - Ensure `.env.example` reflects new config.
  - Produce deployment notes (migrations, feature flags, backfills).

---

## 6) Definition of Done

**Per Task DoD**
- [ ] Acceptance criteria in `tasks.md` satisfied
- [ ] Lint/format clean
- [ ] Unit tests updated/added and passing
- [ ] E2E/API tests added where applicable
- [ ] Docs updated (README, `docs/`, or inline)
- [ ] Task checkbox ticked in `tasks.md` with PR link & commit hash

**Per Spec DoD**
- [ ] All mandatory tasks checked in `tasks.md`
- [ ] `tech-spec.md` reflects final architecture (update diagrams if any)
- [ ] `product/decisions.md` updated with relevant ADRs
- [ ] CI green on main branch; release notes prepared

---

## 7) Safety & Risk Controls

- Never run destructive commands (drop tables, force‑push, mass delete) without an explicit, written plan and approval.
- For migrations:
  - Apply forward‑only migrations with reversible steps where possible.
  - Use feature flags for behavior switches; test both paths.
- For secrets/config:
  - Never commit secrets. Use `.env` + secret manager; keep `.env.example` updated.
- For external APIs:
  - Mock in tests; implement retries, timeouts, circuit breakers per standards.
- Log assumptions and unexpected trade‑offs in the spec.

---

## 8) Optional: CLI Helpers (Codex‑OS)

If your repo includes wrappers, you can drive this workflow non‑interactively:

```bash
# Execute all tasks for a given spec:
bin/co-exec-tasks .codex-os/specs/<YYYY-MM-DD-kebab-title>

# Execute a single task by ID:
bin/co-exec-task .codex-os/specs/<YYYY-MM-DD-kebab-title> T<n>
```

Make sure your project’s `AGENTS.md` points the assistant to `.codex-os/` guidance and standards.

---

## 9) Task Block Template (for `tasks.md`)

```md
### T<n>: <task title>
**Depends on:** T<a>, T<b>  
**Changed files/modules:** <list or TBD>  
**Acceptance criteria:**
- [ ] <criterion 1>
- [ ] <criterion 2>

**Test plan:**
- Unit: <areas/classes>
- Integration/E2E: <flows/endpoints>

**Notes/assumptions:** <optional>
```
