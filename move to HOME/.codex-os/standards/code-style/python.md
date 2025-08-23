# Codex-OS Code Style — Python
_Version 1.0 • Targets Python 3.11+_

## Tooling
- **Formatter**: Black (line length 88)
- **Linter**: Ruff (includes isort import sorting)
- **Type checker**: mypy (strict-ish)
- **Test**: pytest (with coverage)
- **Env**: `src/` layout; `pyproject.toml` for config

### Recommended `pyproject.toml`
```toml
[build-system]
requires = ["setuptools>=68", "wheel"]
build-backend = "setuptools.build_meta"

[tool.black]
line-length = 88
target-version = ["py311"]

[tool.ruff]
line-length = 100
target-version = "py311"
select = ["E","F","W","I","N","UP","S","B","A","C4","SIM","PL"]
ignore = ["ANN101","ANN102"]  # allow missing self/cls annotations
fix = true

[tool.ruff.lint.isort]
known-first-party = ["yourpkg"]
combine-as-imports = true

[tool.mypy]
python_version = "3.11"
strict = true
warn_unreachable = true
warn_return_any = true
disallow_any_generics = true
check_untyped_defs = true
no_implicit_optional = true
exclude = ["tests/fixtures/"]
```

## Formatting
- 4-space indentation; 88-col target enforced by Black.
- One import per module line; group as stdlib / third-party / first-party; sorted by Ruff (isort).
- Final newline required; no trailing spaces.

## Naming
- Modules/packages: `snake_case`
- Variables/functions: `snake_case`
- Classes/Exceptions: `PascalCase`
- Constants: `UPPER_SNAKE_CASE`
- Private: `_internal` (single underscore)
- Booleans: `is_active`, `has_access`

## Types & Docs
- Use type hints everywhere, including return types.
- Google-style docstrings; keep the **why** in comments, not the what.
- Prefer `TypedDict`/`dataclass`/`pydantic` for structured data.

## Imports
- Absolute imports using the `src/` package layout.
- Relative imports only one level deep when necessary.

## Errors & Logging
- Raise specific exceptions with actionable messages.
- Use `logging` or `structlog`; avoid `print` in libraries.
- Wrap external calls with timeouts and retries where appropriate.

## Testing
- `pytest` with AAA (Arrange-Act-Assert).
- One behavior per test; descriptive names: `test_should_do_x_when_y`.
- Avoid real network/time; use fakes/mocks; freeze time where needed.

## Example
```python
from __future__ import annotations
from dataclasses import dataclass
from typing import Protocol

class UserRepo(Protocol):
    def find_by_email(self, email: str) -> "User | None": ...
    def insert(self, user: "User") -> "User": ...

@dataclass(frozen=True)
class User:
    email: str
    display_name: str

def create_user(repo: UserRepo, email: str, display_name: str) -> User:
    """Create a user if the email is valid and not already used.

    Args:
        repo: Persistence gateway.
        email: Unique email address.
        display_name: Public-facing name.

    Raises:
        ValueError: If the email is invalid or already exists.
    """
    if "@" not in email:
        raise ValueError("Invalid email")

    if repo.find_by_email(email) is not None:
        raise ValueError("User already exists")

    return repo.insert(User(email=email, display_name=display_name))
```
