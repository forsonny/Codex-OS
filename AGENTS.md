# Codex-OS — Project Guidance

## Custom Commands

The following custom commands trigger specific Codex-OS workflows. When these commands are encountered, the corresponding workflow file MUST be read and its instructions executed precisely as documented. **This is a mandatory directive that applies to all commands without exception.** The costom commands are: /co-plan, /co-exec-tasks, /co-exec-task [TASK_ID], /co-create-spec [spec details], /co-analyze.

### Command Reference

/co-plan

* Follow the workflow in `.codex-os/instructions/core/plan-product.md`.
* Review existing product docs in `.codex-os/product/`.
* Update `roadmap/`, `mission/`, `decisions/`, and `stack/` as needed. Create missing files if necessary.
* Ensure all updates comply with project standards in `.codex-os/standards/`.

/co-exec-tasks

* Execute the tasks in `${SPEC_DIR}/tasks.md` following `.codex-os/instructions/core/execute-tasks.md`.
* Implement changes incrementally with tests and small commits.

/co-exec-task [TASK_ID]

* Execute the specific task `${TASK_ID}` from `${SPEC_DIR}/tasks.md` using `.codex-os/instructions/core/execute-task.md`.
* Make only the minimal changes required to pass tests, then commit.

/co-create-spec [spec details]

* Create a new spec for `${SPEC_TITLE}` using `.codex-os/instructions/core/create-spec.md`.
* Create a dated folder in `.codex-os/specs/` (name in kebab-case).
* Include `srd.md`, `tech-spec.md`, and `tasks.md`.
* Ensure alignment with `.codex-os/standards/` and `.codex-os/product/` context.

/co-analyze

* Run product analysis using `.codex-os/instructions/core/analyze-product.md`.
* Summarize architecture, hotspots, and risks in `.codex-os/product/analysis.md`.


## Product context
- Mission: `.codex-os/product/mission.md`
- Roadmap: `.codex-os/product/roadmap.md`
- Decisions: `.codex-os/product/decisions.md`
- Stack: `.codex-os/product/stack.md`

## Standards
- `.codex-os/standards/tech-stack.md`
- `.codex-os/standards/code-style.md`
- `.codex-os/standards/best-practices.md`
- Language/style guides under `.codex-os/standards/code-style/`

## Specs
- `.codex-os/specs/` (each spec has `srd.md`, `tech-spec.md`, `tasks.md`)

## Workflows
- **Plan product** → `.codex-os/instructions/core/plan-product.md`
- **Create spec** → `.codex-os/instructions/core/create-spec.md`
- **Execute tasks** → `.codex-os/instructions/core/execute-tasks.md`
- **Execute single task** → `.codex-os/instructions/core/execute-task.md`
- **Analyze product** → `.codex-os/instructions/core/analyze-product.md`

**Commit policy:** small, descriptive commits referencing spec/task IDs.
