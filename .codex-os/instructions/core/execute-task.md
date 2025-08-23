# Codex-OS — Execute Single Task
_Last updated: 2025-08-23_

## Purpose
Implement **one** task from a spec with the smallest, safest change that satisfies its acceptance criteria (ACs), keeps tests green, and maintains project standards.

> Prefer project-local guidance under `.codex-os/` over any global defaults.

---

## Inputs
- **Spec directory:** e.g., `.codex-os/specs/2025-08-22-new-app`
- **Task ID:** a stable identifier from `tasks.md` (e.g., `T-003`)
- **Related files:** referenced in the task’s “Changed files” section
- **Standards:** `.codex-os/standards/{tech-stack.md, code-style.md, best-practices.md}`

Optional helpers:
- CLI wrapper: `bin/co-exec-task <SPEC_DIR> <TASK_ID>`
- Direct: `codex exec "Execute task <TASK_ID> from <SPEC_DIR>/tasks.md …"`

---

## Quick checklist (tick as you go)
- [ ] Locate task `<TASK_ID>` in `<SPEC_DIR>/tasks.md` and read its ACs
- [ ] Confirm technical approach aligns with `tech-spec.md`
- [ ] Create/adjust tests to express ACs (failing first, if practical)
- [ ] Implement **minimal** change to satisfy ACs
- [ ] Run lint/format; fix style issues
- [ ] Run tests locally; ensure green
- [ ] Update docs/comments as needed; note decisions
- [ ] Commit with conventional message referencing spec & task
- [ ] Open PR with summary, evidence, and risk notes
- [ ] Mark the task as **Done** in `tasks.md` with a link to the PR/commit

---

## Step-by-step

### 1) Understand the task
1. Open `<SPEC_DIR>/tasks.md`; find the block for `<TASK_ID>`.
2. Read `<SPEC_DIR>/tech-spec.md` for architecture, boundaries, and risks.
3. Clarify any ambiguity **in the spec** (append “Assumptions” if you must).

> If the implementation contradicts the tech spec, either adjust the design (record an ADR in `product/decisions.md`) or propose a scope cut that still meets ACs.

### 2) Branch & environment
- Create a short-lived branch:  
  `git checkout -b feat/<area>-<task-id>`
- Ensure you can run the project & tests locally (see README).

### 3) Tests first (where feasible)
- Add or update tests that encode the ACs (unit first; add e2e if ACs span boundaries).
- Keep tests small and deterministic (no real network without test doubles).

### 4) Minimal implementation
- Implement the simplest solution to pass the new tests.
- Keep changes tightly scoped to files listed by the task; refactor only as needed.
- Feature flag risky paths if user-visible behavior changes.

### 5) Quality gates
- Lint & format: `npm run lint && npm run format` or `ruff/black`, etc.
- Static checks/type checks if configured (e.g., `tsc`, `mypy`).
- Security scan where available (e.g., `npm audit`, `pip-audit`)—note findings.

### 6) Docs & bookkeeping
- Update in-code docs/comments for public APIs you touched.
- If you made a notable design choice, add an ADR entry in `product/decisions.md`.
- If telemetry/metrics is part of ACs, wire them now.

### 7) Commit
Use a small, descriptive commit that references the spec and task.

**Template:**
```
<area>: <succinct change>
    
Implements <TASK_ID> from <SPEC_DIR>/tasks.md.
References: <link to spec line or PRD if helpful>.

Notes:
- <risk/assumption of interest>
- <follow-up if any>
```

### 8) Pull Request
Include a PR body that reviewers can verify quickly.

**PR template:**
```
## Summary
Implements <TASK_ID> from <SPEC_DIR>/tasks.md

## What changed
- <bullet of code changes>

## Acceptance Criteria mapping
- [x] AC1: <evidence or test name/link>
- [x] AC2: <evidence or screenshot/log>
- [x] AC3: <…>

## Tests
- <unit files/run logs>
- <e2e/manual steps if any>

## Risks / Mitigations
- <risk> → <mitigation/flag>
- Rollback: <how to revert safely>

## Docs
- Updated: <files/sections>
```

### 9) Post-merge
- Mark task `<TASK_ID>` **Done** in `tasks.md`, linking the PR or commit.
- If scope changed, reflect it in `tech-spec.md` and `srd.md` (when relevant).

---

## Definition of Done (DoD)
A task is **Done** when:
1. All ACs are met and mapped to tests/evidence.
2. Linting, static checks, and tests are green.
3. Docs updated (inline + any relevant `product/*` files).
4. Small, reviewable commit(s) merged to main.
5. Task status updated in `tasks.md` with links.

---

## Safety rails
- Favor additive changes; avoid destructive migrations.
- Protect new behavior with feature flags where appropriate.
- For data migrations: plan, test on a copy, include rollback steps.
- Never commit secrets; use `.env` and secret managers.

---

## Snippets

### Task block (in `tasks.md`)
```
### <TASK_ID> — <title>
**Status:** Todo | In-Progress | Done (link: <PR/commit>)

**Summary**
<one-paragraph goal>

**Acceptance Criteria**
- [ ] AC1 …
- [ ] AC2 …

**Changed files**
- path/to/file1
- path/to/file2

**Test plan**
- Unit: <files>
- E2E: <steps or script>
```

### Risk log (optional per task)
```
- <date>: <risk> — impact <H/M/L>, likelihood <H/M/L>, mitigation <…>
```

---

## CLI helpers (optional)
- **Execute one task with Codex CLI**
  ```bash
  bin/co-exec-task <SPEC_DIR> <TASK_ID>
  ```
  or
  ```bash
  codex exec "Execute task <TASK_ID> from <SPEC_DIR>/tasks.md following .codex-os/instructions/core/execute-task.md. Make the minimal changes to pass tests and commit."
  ```

---

## References
- Project standards: `.codex-os/standards/*`
- Spec: `<SPEC_DIR>/{srd.md, tech-spec.md, tasks.md}`
- Decisions (ADRs): `.codex-os/product/decisions.md`
