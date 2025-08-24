# Codex-OS — Global Tech Stack Defaults (Bun + Your Defaults)

> Opinionated defaults for greenfield projects. Prefer boring, well-supported tech. Override per-project in `.codex-os/product/stack.md`.

---

## 1) Language & Runtime

* **TypeScript** on **Bun 1.x** (package manager, runner, bundler, test).
* **Python 3.12+** — data workflows where Py libs shine.
* **Shell (bash)** — ops scripts; keep portable.

**Package managers**

* **Bun** (primary) — `bun install`, `bun run`, `bunx` (use `--frozen-lockfile` in CI)
* **uv** (Python) → fallback `pip + venv`
* **pre-commit** for multi-lang hooks

---

## 2) Application Presets

### A) Full-stack Web (Default)

* **Framework**: **Next.js 14+ (App Router, RSC)**
* **UI/UX**: **Tailwind CSS + shadcn/ui**, **dark mode** first-class
* **Auth & Billing**: **Clerk**
* **Database / State**: **Convex** (primary)
  *Optional relational adjunct:* Postgres for analytics/reporting.
* **AI**: **AI SDK** ([https://ai-sdk.dev/](https://ai-sdk.dev/)) for model/runtime wiring
* **API shape**: REST (route handlers), `OpenAPI` (generated or zod-openapi); tRPC optional
* **File storage**: S3-compatible (MinIO locally)

**Background jobs & schedulers**

* Platform crons (Vercel Cron or Cloudflare Cron Triggers); lightweight jobs via Route Handlers/Workers; Redis/queues only when needed.

### B) Service-only (API) Minimal

* **Next.js (route handlers)** + Convex (or Postgres) + OpenAPI

### C) CLI / Tooling

* TS on Bun (+ Commander/oclif) or Python + Typer/Rich.

---

## 3) Quality Gates & Tooling

### Formatting & Linting

* **TS**: eslint (+ `eslint-config-next` where relevant) + **Prettier**
* **Py**: **ruff** (lint+fmt), **black** (optional), **isort**
* **Markdown**: markdownlint-cli2

### Types & Static Analysis

* **TS**: `tsc --noEmit` (strict), `ts-reset` optional
* **Py**: **mypy** (tighten gradually)

### Tests

* **Unit (TS)**: `bun test` (supports `--coverage`)
* **Unit (Py)**: `pytest`
* **E2E**: **Playwright** (run via `bunx playwright …`)
* **Coverage targets**: start 70%, raise with risk

### Security

* **JS/TS**: `bun audit` (fallback: `npm/pnpm audit`)
* **Py**: `pip-audit`
* **Static**: Bandit (Py), eslint security plugins (TS)
* **Containers**: Trivy
* **Secrets**: git-secrets or gitleaks (pre-commit)

### Observability

* **Logging**: pino (TS) / structlog (Py); JSON logs in prod
* **Tracing/Metrics**: OpenTelemetry (OTLP)
* **Errors**: Sentry (client+server) or OTEL collector → backend

---

## 4) DevEx & Build

* **Task runner**: **Justfile** (preferred) or Makefile
* **Env**: `.env` + direnv (never commit secrets)
* **Containers**: Docker; `docker-compose` for local stacks
* **CI/CD**: GitHub Actions (lint, test, build, image, deploy). Use `oven-sh/setup-bun@v2` + `bun install --frozen-lockfile`.
* **Docs**: Docusaurus (TS) or MkDocs-Material
* **API docs**: publish OpenAPI to `/docs`
* **Codegen**: OpenAPI → SDKs; or tRPC where it fits

---

## 5) Database & Migrations

* **Primary app state**: **Convex**

  * Functions in `/convex`; schema/types colocated.
  * No traditional SQL migrations; treat functions as versioned change points.
* **Relational sidecar (optional)**: **PostgreSQL 15+**

  * Migrations: **Prisma Migrate** (TS) or **Alembic** (Py)
  * Use UUID PKs; `created_at/updated_at`; views/materialized views for reporting.

---

## 6) Project Layouts

### Next.js + Convex (monorepo)

```
/apps/web              # Next.js app (App Router)
/convex/               # Convex functions, schema, server code
/packages/ui           # shared UI (shadcn/ui wrappers)
/packages/config       # eslint, tsconfig, prettier, tailwind presets
/packages/types        # shared zod schemas & types
```

### Python + FastAPI (when needed)

```
/src/app/__init__.py
/src/app/api/routers.py
/src/app/models/*.py
/src/app/services/*.py
/src/app/db/{base.py,session.py}
/tests/{unit,e2e}
```

---

## 7) Runtime & Deployment

* **Local/dev**: Bun runner; Next dev server; Convex dev (`bunx convex dev`)
* **Hosting (default)**: **Vercel** for simplicity & DX
* **Hosting (when you need more)**: **Cloudflare Pages + Workers**

  * Next on Pages/Workers for global edge, Cron Triggers, Queues, KV/D1/R2 as needed
* **Containers** (when not serverless):

  * **TS (Bun)**: `FROM oven/bun:1-alpine`, non-root
  * **Python**: `python:3.12-slim`, non-root
* **12-factor**: config via env vars; mount secrets at runtime
* **Health**: `/healthz` (liveness) & `/readyz` (readiness)
* **Migrations**: run before app starts (idempotent)
* **Scale**: stateless; sessions via signed cookies or platform store

---

## 8) Versioning, Releases, and Commits

* **SemVer** for packages; tag images with `git sha` + semver
* **Conventional Commits** + **commitlint**
* **Changesets** (monorepo) or **semantic-release** (single repo)
* **Changelog** auto-generated

---

## 9) Defaults by Use-Case

* **Internal Admin Tools**: Next.js (App Router) + shadcn/tailwind (dark-first), **Clerk**, **Convex**, tRPC optional
* **Public API**: Next.js route handlers (REST/OpenAPI) + **Clerk** (tokens) + Convex or Postgres; rate-limit via platform middleware/edge
* **AI-powered Products**: **AI SDK** + Next.js server actions/route handlers; stream responses (SSE) to UI; persist convos/state in Convex
* **Data Tasks**: Python + Pydantic + Polars/Pandas; add orchestration only if needed

---

## 10) When to Deviate

Deviate only with a note in `product/decisions.md`:

* Regulatory needs
* Vendor lock-in concerns
* Team expertise profile
* Proven performance constraints (via profiling)

---

## 11) Starter “Justfile” (Bun + Next + Convex)

```make
default: lint test

lint:
	bunx eslint . && bunx prettier -c . || true
	ruff check . || true

test:
	bun test --coverage
	pytest -q || true

dev:
	# Next app + Convex dev server
	bunx concurrently -n next,convex -c auto \
		"bun run --cwd apps/web dev" \
		"bunx convex dev"

build:
	bun run --cwd apps/web build

typecheck:
	bunx tsc --noEmit
```

---

## 12) Minimal Service Checklist

* [ ] Lint + format clean
* [ ] Unit tests (`bun test --coverage`) + a Playwright smoke test
* [ ] OpenAPI published (route handlers or generator)
* [ ] Clerk wired (auth flows + protected routes) and billing enabled
* [ ] Convex wired (schema + first query/mutation + RLS/permissions model)
* [ ] Health endpoints wired
* [ ] Dockerfile + compose (if not serverless)
* [ ] CI (lint/test/build) green (`setup-bun`, `bun install --frozen-lockfile`)
* [ ] Error tracking & tracing configured
* [ ] Baseline dashboards/alerts
* [ ] Dark mode verified (UI tokens, theming, SEO/meta colors)
