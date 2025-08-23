# Codex-OS — Global Tech Stack Defaults
> Opinionated defaults for greenfield projects. Prefer boring, well-supported tech. Override per-project in `.codex-os/product/stack.md`.

---

## 1) Language & Runtime
- **TypeScript** (Node.js **LTS**; prefer pnpm) — primary for full‑stack web.
- **Python 3.12+** — data workflows, services where Python libs shine.
- **Shell (bash)** — ops scripts; keep portable (no bashisms when possible).

**Package managers**
- **pnpm** (JS/TS), fallback: npm
- **uv** (Python) for fast, reproducible envs; fallback: `pip + venv`
- **pre-commit** for multi-language hooks

---

## 2) Application Presets

### A) Full‑stack Web (Default)
- **Frontend**: React 18 + **Next.js 14+ (App Router, RSC)**  
  UI: Tailwind CSS, shadcn/ui, Radix Primitives
- **Backend**: **FastAPI** (Python) *or* **NestJS** (TS). Choose one:
  - **TS path**: NestJS + Prisma + Zod (shared models); pino logging
  - **Py path**: FastAPI + SQLAlchemy + Pydantic; structlog logging
- **Database**: **PostgreSQL 15+**
- **Cache / Queues**: **Redis 7+** (keys, pub/sub, streams; rate limits)
- **ORM / DB toolkit**:
  - TS: **Prisma** (preferred) or Drizzle
  - Py: **SQLAlchemy 2.x** + Alembic migrations
- **API**: REST first, **OpenAPI 3.1**; optional GraphQL via Apollo/Envelop
- **Auth**: **Auth.js** (NextAuth) on TS path; **Auth0**/**OIDC** on both paths
- **File storage**: S3‑compatible (AWS S3, MinIO during dev)
- **Background jobs**:
  - TS: BullMQ or simple ECS/Cloud Run cron
  - Py: RQ or Celery (only when needed; prefer simpler first)

### B) Service‑only (API) Minimal
- FastAPI *or* NestJS (no frontend), Postgres, Redis, OpenAPI.

### C) CLI / Tooling
- Python + Typer/Rich *or* Node + Commander/oclif.

---

## 3) Quality Gates & Tooling

### Formatting & Linting
- **TypeScript**: eslint + @typescript-eslint, **Prettier** (opinionated config)
- **Python**: **ruff** (lint + format), **black** (if project prefers), **isort**
- **Markdown**: markdownlint-cli2; prose rules kept light

### Types & Static Analysis
- **TS**: `tsc --noEmit` (strict), **ts-reset** optional
- **Python**: **mypy** (strict-ish, gradually tightened)

### Tests
- **Unit**: Vitest (TS), **pytest** (Py)
- **E2E**: **Playwright**
- **Coverage targets**: start at 70%, climb with risk

### Security
- Dependency scanning: `npm audit`, `pnpm audit`, `pip-audit`
- Static checks: Bandit (Py), eslint security plugins (TS)
- Containers: **Trivy**
- Secrets: git-secrets or gitleaks (pre-commit hook)

### Observability
- **Logging**: pino (TS) / structlog (Py); JSON logs in prod
- **Tracing/Metrics**: **OpenTelemetry** SDK; OTLP exporter
- **Error tracking**: Sentry (server & client) or OpenTelemetry collector → backend

---

## 4) DevEx & Build

- **Task runner**: **Justfile** (preferred) or Makefile
- **Env**: `.env` + direnv (never commit secrets)
- **Containers**: Docker, **docker-compose** for local stacks
- **CI/CD**: GitHub Actions (workflows: lint, test, build, image, deploy)
- **Docs**: Docusaurus (TS) or MkDocs‑Material (Py/neutral)
- **API docs**: OpenAPI via FastAPI/NestJS generator published to `/docs`
- **Codegen**: OpenAPI → client SDKs (or tRPC on TS path, case-by-case)

---

## 5) Database & Migrations

- **PostgreSQL** default; use UUID primary keys; `created_at/updated_at` columns
- Migrations:
  - TS: Prisma Migrate
  - Py: Alembic (autogenerate + review)
- Seed data & fixtures maintained alongside migrations
- Use views/materialized views for reporting; avoid complex DB logic in app

---

## 6) Project Layouts

### TS + Next.js + NestJS (monorepo option)
```
/apps/web          # Next.js app
/apps/api          # NestJS service
/packages/ui       # shared UI (shadcn/ui wrappers)
/packages/config   # eslint, tsconfig, prettier presets
/packages/types    # shared zod schemas & types
```

### Python + FastAPI
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

- **Containers**: Build minimal images
  - Python: `python:3.12-slim` + uv/venv; run as non‑root
  - Node: `node:20-alpine` (LTS) + pnpm; run as non‑root
- **12‑factor**: config via env vars; mount secrets at runtime
- **Health**: `/healthz` (liveness), `/readyz` (readiness)
- **Migrations**: run on startup job (idempotent) before app
- **Horizontal scaling**: stateless app; sessions via signed cookies or Redis

---

## 8) Versioning, Releases, and Commits

- **SemVer** for packages; tag Docker images with `git sha` + semver
- **Conventional Commits** + **commitlint**
- **Changesets** (monorepo) or semantic‑release (single repo)
- **Changelog** auto-generated

---

## 9) Defaults by Use‑Case

- **Internal Admin Tools**: TS + Next.js (App Router) + tRPC; DB Postgres; Auth via internal SSO/OIDC
- **Public API**: FastAPI + Postgres; strict OpenAPI; API keys + OAuth; rate limiting via Redis
- **Data Tasks**: Python + Pydantic + Polars/Pandas; Airflow/Prefect only if needed

---

## 10) When to Deviate
Deviate only with a written note in `product/decisions.md`:
- Regulatory requirements
- Vendor lock‑in concerns
- Team expertise profile
- Performance constraints demonstrated by profiling

---

## 11) Starter “Justfile” (excerpt)
```
default: lint test

lint: 
	eslint . && prettier -c . || true
	ruff check . || true

test:
	pnpm -C apps/web test
	pnpm -C apps/api test
	pytest -q || true

dev:
	pnpm -C apps/web dev & pnpm -C apps/api start:dev
```

---

## 12) Minimal Service Checklist
- [ ] Lint + format clean
- [ ] Unit tests + a Playwright smoke test
- [ ] OpenAPI published
- [ ] Health endpoints wired
- [ ] Dockerfile + compose
- [ ] CI (lint/test/build) green
- [ ] Error tracking & tracing configured
- [ ] Baseline dashboards/alerts
