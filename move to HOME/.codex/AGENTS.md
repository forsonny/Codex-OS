# Codex-OS — Global Guidance

> This file provides my **global coding operating system**.  
> When a project contains a local `.codex-os/` folder and/or a project `AGENTS.md`,
> **prefer the project-local guidance** over anything here.

---

## 0) Purpose & Scope

- Translate product intent (PRDs/specs) into working software using consistent workflows, standards, and documentation.
- Be safe-by-default: explain plans, make small changes, add tests, and avoid destructive actions without approval.

**You must:**
1. Read the relevant guidance files (global defaults here, project-specific ones if present).
2. Follow the workflows and standards below.
3. Keep artifacts organized under `.codex-os/` (project) or `~/.codex-os/` (global).

---

## 1) Where to Read Things

### Prefer project-local if present
- **Product:** `.codex-os/product/{mission.md, roadmap.md, decisions.md, stack.md}`
- **Standards:** `.codex-os/standards/{tech-stack.md, code-style.md, best-practices.md}`  
  Language guides in `.codex-os/standards/code-style/` (e.g., `python.md`, `typescript.md`, `markdown.md`).
- **Specs:** `.codex-os/specs/<YYYY-MM-DD-kebab-title>/{srd.md, tech-spec.md, tasks.md}`
- **Workflows:** `.codex-os/instructions/core/*.md`

### If the project lacks those, fall back to my global defaults
- `~/.codex-os/product/...`
- `~/.codex-os/standards/...`
- `~/.codex-os/instructions/core/...`

---

## 2) Core Workflows (what to do)

> Each workflow corresponds to a Markdown playbook. Always read the referenced file first.

- **Plan product** → `*/instructions/core/plan-product.md`  
  Outcome: updated `product/` docs (mission, roadmap, decisions, stack).
- **Create spec** → `*/instructions/core/create-spec.md`  
  Outcome: new spec folder with `srd.md`, `tech-spec.md`, `tasks.md`.
- **Execute tasks (spec)** → `*/instructions/core/execute-tasks.md`  
  Outcome: implement all tasks in `tasks.md` with code, tests, docs.
- **Execute single task** → `*/instructions/core/execute-task.md`  
  Outcome: implement one task minimally to green tests.
- **Analyze product/codebase** → `*/instructions/core/analyze-product.md`  
  Outcome: `product/analysis.md` with architecture summary, risks, hotspots.

`*` = Prefer `.codex-os/...` in the project; else use `~/.codex-os/...`.

---

## 3) Standards (how to do it)

Before coding, read:
- `*/standards/tech-stack.md` — supported languages, frameworks, tooling.
- `*/standards/code-style.md` — formatting, linting, naming, comments.
- `*/standards/best-practices.md` — testing strategy, error handling, security footguns.
- Language specifics in `*/standards/code-style/<lang>.md`.

**Non-negotiables:**
- Lint/format clean.
- Tests for non-trivial logic.
- Document decisions in `product/decisions.md` (ADR-style).
- Small, descriptive commits that reference the spec/task IDs.

---

## 4) Spec Structure (what to build)

Inside each spec folder:
- `srd.md` — problem/PRD, users, goals, non-goals, success metrics.
- `tech-spec.md` — architecture, data models, APIs, boundaries, risks.
- `tasks.md` — numbered, testable tasks with acceptance criteria.

**Rules:**
- Keep each task atomic (fits in a small PR).
- Each task states changed files and test plan.
- Update the spec as reality evolves (don’t let it rot).

---

## 5) Blank Repo Bootstrapping (from only a PRD)

When only a PRD exists:
1. Place PRD at `project/.codex-os/specs/<date>-<name>/srd.md`.  
   If missing, use the global path under `~/.codex-os/specs/...`.
2. Propose/confirm the stack (see `product/stack.md` or add it).
3. Scaffold the project:
   - README, license, `.editorconfig`, `.gitignore`
   - Package/manifest (`package.json` or `pyproject.toml`), `src/`, `tests/`
   - CI workflow, Dockerfile/compose, `.env.example`
4. Generate initial modules per `tasks.md`; write tests; keep commits small.

---

## 6) Safety & Change Control

- **Never** delete or rewrite large sections without a plan/summary.
- Seek approval before running risky commands, migrations, or destructive ops.
- Prefer incremental migrations with rollbacks.
- Surface any ambiguities; if assumptions are required, record them in the spec.

---

## 7) Commit & PR Guidance

- One logical change per commit.  
- Message: `<area>: <what/why> (spec <id> / task <n>)`
- PR description links spec lines and includes test evidence (logs, screenshots).
- Update `product/decisions.md` when architecture or policy changes.

---

## 8) Common Prompts / Invocations

> If using helper scripts, these map to the workflows above (names may vary per repo).

- **Plan**: “Read product docs and update roadmap/mission/decisions/stack per the workflow.”
- **Create spec**: “Create a new spec from this PRD title; write `srd.md`, `tech-spec.md`, `tasks.md`.”
- **Execute tasks**: “Implement all tasks from `<spec>/tasks.md` with tests and docs.”
- **Execute task**: “Implement task `<ID>` minimally to green tests; small commit.”
- **Analyze**: “Produce `product/analysis.md` with architecture, hotspots, risks, and recommendations.”

---

## 9) Directory Conventions (project)

.codex-os/
├─ product/
│  ├─ mission.md
│  ├─ roadmap.md
│  ├─ decisions.md
│  └─ stack.md
├─ standards/
│  ├─ tech-stack.md
│  ├─ code-style.md          # top-level rules that apply to all languages
│  ├─ best-practices.md
│  └─ style-guides/          # per-language guides
│     ├─ python.md
│     ├─ typescript.md
│     └─ markdown.md
├─ instructions/
│  └─ core/
│     ├─ plan-product.md
│     ├─ create-spec.md
│     ├─ execute-tasks.md
│     ├─ execute-task.md
│     └─ analyze-product.md
└─ specs/
   └─ YYYY-MM-DD-kebab-title/
      ├─ srd.md
      ├─ tech-spec.md
      └─ tasks.md

---

## 10) Tone & Collaboration Defaults

- Be clear, concise, and actionable.
- Explain reasoning when choices aren’t obvious.
- Default to secure and accessible implementations.
- Prefer boring, maintainable tech over novel tech unless the spec requires it.

---

**End of Codex-OS Global Guidance**
