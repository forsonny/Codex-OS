# Codex-OS Code Style
_Version 1.0 • Last updated: 2025-08-23_

This document defines **formatting rules, naming conventions, and preferences** used across Codex‑OS projects.
For language‑specific details, see the per‑language guides alongside this file (e.g., `code-style/python.md`, `code-style/typescript.md`, `code-style/markdown.md`).

---

## 1) Tooling & Auto‑format
**Always rely on autoformat + lint to enforce style.**

- **EditorConfig**: enforce UTF‑8, LF line endings, final newline.
- **Prettier** (JS/TS/Markdown/YAML/JSON):
  - print width **100**
  - semi **true**
  - singleQuote **true** (JSON excluded)
  - trailingComma **all**
  - arrowParens **always**
- **ESLint** (TS): `typescript-eslint`, `unicorn`, `import`, `jsx-a11y`. Error on unused vars, `any`, implicit `any`, and shadowing.
- **Black** (Python): line length **88**; pair with **ruff** (lint) and **isort** (imports).
- **Markdownlint**: keep headings incremental, no trailing spaces, wrap at ~100 where practical.
- **Git hooks**: run format + lint + tests on `pre-commit` where feasible.

> If formatter and linter disagree, **formatter wins**; linter rules must be compatible with the formatter config.

---

## 2) Whitespace & Formatting (cross‑language)
- **Indentation**: 2 spaces (TS/JS/JSON/YAML/MD), 4 spaces (Python). No tabs.
- **Line length**: 100 (general), 88 (Python via Black). Break long expressions early.
- **Final newline**: required. No trailing whitespace.
- **Braces/blocks**: K&R style. Always use braces—even for single‑line `if`/loops.
- **Blank lines**: one blank line between top‑level declarations; group logically.
- **Ordering**: constants → types/interfaces → functions → classes → exports (or main entry).

---

## 3) Naming Conventions
### General
- **Classes / Types**: `PascalCase`
- **Functions / Variables**: `camelCase`
- **Constants (immutable, module‑level)**: `UPPER_SNAKE_CASE`
- **Private members**: leading underscore `_internal`
- **Booleans**: prefix with is/has/should/can (e.g., `isActive`, `hasAccess`)
- **Enums**: `PascalCase` type, `UPPER_SNAKE_CASE` members
- **Acronyms**: treat as words (`HttpServer`, not `HTTPServer`)

### Files & directories
- **TS/JS**: `kebab-case.ts` files; **React components** in `PascalCase.tsx` (one component per file).
- **Python**: modules `snake_case.py`, packages `snake_case`.
- **Specs/docs**: folders `YYYY-MM-DD-kebab-title`; Markdown files `kebab-case.md`.

### Tests
- **TS/JS**: `*.test.ts` / `*.spec.ts` next to code or under `tests/` mirroring structure.
- **Python**: `tests/` with files `test_<module>.py`.

---

## 4) Imports & Exports
- **No default exports** in TS—prefer named exports.
- Sort imports in blocks: **stdlib → third‑party → internal**; within blocks, alphabetize.
- Avoid deep relative paths; use tsconfig `paths`/Python packages for absolute imports.
- Side‑effect imports must be isolated and commented with intent.

---

## 5) Functions & APIs
- Prefer **pure functions**; minimize shared mutable state.
- **Single responsibility** per function; aim for ≤ 30–40 lines where reasonable.
- Use **early returns** to reduce nesting.
- Input validation at boundaries; return **typed results** (TS: avoid `any`; Python: use type hints).
- Document non‑obvious behavior with doc comments.

---

## 6) Classes & Data
- Keep classes small and cohesive; prefer composition over inheritance.
- Make fields **private** where possible; expose minimal public surface.
- Use **immutable data** by default; clone or copy when in doubt.
- TS: define interfaces for data shapes; Python: use `dataclasses` / `pydantic` as appropriate.

---

## 7) Error Handling & Logging
- **Never swallow errors**. Either handle or rethrow with context.
- TS: throw `Error` (or subclasses). Preserve stack. Use `try/catch` only where you can add value.
- Python: raise specific exceptions; include actionable messages.
- Logging: use structured logging utilities; **no `print`/`console.log`** in production code. Guard debug logs behind flags.

---

## 8) Comments & Documentation
- Write **self‑documenting code**; comment **why**, not what.
- TS: use TSDoc/JSDoc for exported symbols.
- Python: use **Google‑style** docstrings with type hints.
- Keep README and `docs/` updated; add ADRs in `docs/ADRs/` for significant decisions.

---

## 9) Testing Conventions
- **Test pyramid**: unit > integration > e2e.
- AAA (Arrange‑Act‑Assert) or Given/When/Then; one behavior per test.
- Deterministic tests—avoid real network/time; use fakes/mocks.
- Name tests descriptively: `should_doX_when_Y`.
- Enforce coverage thresholds appropriate to the project; fail CI on uncovered new lines when feasible.

---

## 10) Security & Reliability Defaults
- Validate and sanitize all external input.
- Prefer safe APIs (parameterized SQL, prepared statements).
- Handle time, I/O, and network with timeouts and retries where appropriate.
- Secrets via env vars or secret managers—**never** commit secrets.
- Avoid `any`/untyped data crossing trust boundaries.

---

## 11) Language Notes (brief)
### TypeScript / JavaScript
- Strict mode on; `noImplicitAny`, `strictNullChecks` enabled.
- Use `unknown` instead of `any`; narrow with type guards.
- Prefer `const`; use `let` only when reassignment is needed. Never `var`.
- Use nullish coalescing `??` and optional chaining `?.` appropriately.
- React:
  - Functional components with hooks; prefix hooks with `use*`.
  - Props interfaces named `SomethingProps`.
  - Avoid default exports; one component per file.

### Python
- Target **3.11+** where possible.
- Type hints everywhere; enable static checking (mypy/ruff).
- Use f‑strings; context managers for resources.
- Package layout: `src/` with a top‑level package; no relative imports beyond one level.
- Avoid mutable default args; prefer `None` + initialization.

### Markdown
- Use ATX `#` headings; start at H1 once per file.
- Wrap lines near 100 chars; fenced code blocks with language tags.
- Lists: hyphen `-` preferred; consistent indentation.

---

## 12) Examples
### TypeScript
```ts
// user-service.ts
export interface CreateUserInput {
  email: string;
  displayName: string;
}

export class UserService {
  constructor(private readonly repo: UserRepository) {}

  async createUser(input: CreateUserInput): Promise<User> {
    if (!isValidEmail(input.email)) throw new Error("Invalid email");
    const exists = await this.repo.findByEmail(input.email);
    if (exists) throw new Error("User already exists");

    const user = await this.repo.insert({ ...input, createdAt: new Date() });
    return user;
  }
}
```

### Python
```python
from __future__ import annotations
from dataclasses import dataclass
from typing import Optional

@dataclass(frozen=True)
class User:
    email: str
    display_name: str
    created_at: float

def create_user(repo: "UserRepo", email: str, display_name: str) -> User:
    """Create a user if the email is valid and unused.

    Args:
        repo: Persistence gateway.
        email: Unique email.
        display_name: Public name.

    Raises:
        ValueError: If email invalid or already exists.
    """
    if not is_valid_email(email):
        raise ValueError("Invalid email")

    if repo.find_by_email(email) is not None:
        raise ValueError("User already exists")

    return repo.insert(email=email, display_name=display_name)
```

---

## 13) Preferences Recap (TL;DR)
- Prettier/Black on save; ESLint/Ruff clean.
- 100/88 col width; 2/4 spaces.
- `camelCase` for code, `PascalCase` for types/classes, `UPPER_SNAKE_CASE` for constants.
- Named exports (no default) in TS; typed APIs; avoid `any`.
- Small, pure, testable functions; early returns; no deep nesting.
- Clear errors, structured logs, zero secret leakage.
