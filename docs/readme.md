# Codex-OS

**A structured development operating system for turning product requirements into working software through consistent workflows, standards, and documentation.**

Codex-OS provides a complete framework for software development that emphasizes safety, quality, and reproducibility. It includes opinionated workflows, coding standards, and automation tools to streamline the journey from PRD to production.

## 🎯 Purpose

Codex-OS helps teams:
- Transform product requirements into actionable technical specs
- Maintain consistent code quality and style across projects
- Execute development tasks safely and incrementally
- Document decisions and maintain living architecture docs
- Automate repetitive workflows while maintaining human oversight

## 🚀 Quick Start

### Installation

1. **Clone the repository** to your project:
   ```bash
   # For project-local installation
   git clone https://github.com/forsonny/codex-os .codex-os
   ```

2. **Make helper scripts executable**:
   ```bash
   chmod +x bin/co-*
   ```

3. **Install dependencies** (if using the TypeScript/JavaScript stack):
   ```bash
   npm install  # or pnpm install
   ```

### First Project Setup

```bash
# 1. Plan your product from a PRD
bin/co-plan

# 2. Create your first spec
bin/co-create-spec "User Authentication"

# 3. Execute the spec tasks
bin/co-exec-tasks .codex-os/specs/2025-08-23-user-authentication

# 4. Analyze your codebase health
bin/co-analyze
```

## 📁 Directory Structure

```
.codex-os/
├── product/              # Product documentation
│   ├── mission.md       # Vision, audience, value proposition
│   ├── roadmap.md       # Milestones and timeline
│   ├── decisions.md     # Architecture Decision Records (ADRs)
│   ├── stack.md         # Technology choices
│   └── analysis.md      # Generated codebase analysis
│
├── standards/           # Development standards
│   ├── tech-stack.md    # Default technology choices
│   ├── code-style.md    # Cross-language style guide
│   ├── best-practices.md # Engineering principles
│   └── code-style/      # Language-specific guides
│       ├── typescript.md
│       ├── python.md
│       ├── javascript.md
│       └── markdown.md
│
├── instructions/        # Workflow playbooks
│   └── core/
│       ├── plan-product.md    # Product planning workflow
│       ├── create-spec.md     # Spec creation workflow
│       ├── execute-tasks.md   # Task execution workflow
│       ├── execute-task.md    # Single task execution
│       └── analyze-product.md # Codebase analysis workflow
│
└── specs/              # Feature specifications
    └── YYYY-MM-DD-kebab-title/
        ├── srd.md      # Software Requirements Document
        ├── tech-spec.md # Technical specification
        └── tasks.md    # Prioritized task list
```

## 🔧 Core Workflows

### 1. Plan Product
Transform a raw PRD into structured product documentation:
```bash
bin/co-plan
```
**Outputs:** Updated mission, roadmap, decisions, and stack documents

### 2. Create Spec
Convert product requirements into actionable technical specifications:
```bash
bin/co-create-spec "Feature Name"
```
**Outputs:** New spec folder with SRD, tech spec, and task list

### 3. Execute Tasks
Implement all tasks from a spec with tests and documentation:
```bash
bin/co-exec-tasks .codex-os/specs/YYYY-MM-DD-feature-name
```
**Outputs:** Working code, tests, updated documentation

### 4. Execute Single Task
Implement one specific task from a spec:
```bash
bin/co-exec-task .codex-os/specs/YYYY-MM-DD-feature-name T-001
```
**Outputs:** Minimal code change to satisfy task requirements

### 5. Analyze Product
Generate a comprehensive analysis of your codebase:
```bash
bin/co-analyze
```
**Outputs:** Architecture overview, risks, recommendations in `product/analysis.md`

## 🛠️ Technology Stack

### Default Stack (Full-Stack Web)
- **Frontend:** React 18 + Next.js 14+ (App Router)
- **Backend:** FastAPI (Python) or NestJS (TypeScript)
- **Database:** PostgreSQL 15+
- **Cache:** Redis 7+
- **Testing:** Vitest/Jest (TS), pytest (Python), Playwright (E2E)
- **CI/CD:** GitHub Actions
- **Container:** Docker + docker-compose

### Supported Languages
- TypeScript/JavaScript (primary)
- Python 3.11+ (services, data workflows)
- Bash (automation scripts)

## 📝 Standards & Best Practices

### Code Style
- **TypeScript:** Prettier + ESLint with strict mode
- **Python:** Black + Ruff with type hints
- **Commits:** Conventional Commits format
- **Testing:** Unit > Integration > E2E pyramid

### Core Principles
- Small, reversible changes
- Tests prove behavior
- Security by default
- Documentation as code
- Automation over manual processes

## 🎮 Helper Scripts

| Command | Purpose |
|---------|---------|
| `bin/co-plan` | Update product documentation from PRD |
| `bin/co-create-spec` | Create new feature specification |
| `bin/co-exec-tasks` | Execute all tasks in a spec |
| `bin/co-exec-task` | Execute a single task |
| `bin/co-analyze` | Analyze codebase health |

## 🔒 Safety Features

- **Non-destructive by default:** All risky operations require explicit approval
- **Incremental migrations:** Forward-only with rollback plans
- **Test-first development:** Write tests before implementation
- **Small commits:** One logical change per commit
- **Documentation requirements:** ADRs for architectural decisions

## 📚 Documentation

Each workflow has detailed documentation in `.codex-os/instructions/core/`:
- [Plan Product](.codex-os/instructions/core/plan-product.md)
- [Create Spec](.codex-os/instructions/core/create-spec.md)
- [Execute Tasks](.codex-os/instructions/core/execute-tasks.md)
- [Execute Single Task](.codex-os/instructions/core/execute-task.md)
- [Analyze Product](.codex-os/instructions/core/analyze-product.md)

## 🤝 Contributing

1. Follow the standards in `.codex-os/standards/`
2. Create specs for new features
3. Write tests for all changes
4. Update documentation as needed
5. Use conventional commits

## 📄 License

[Add your license here]

## 🙋 Support

For questions or issues:
- Check the documentation in `.codex-os/instructions/`
- Review existing specs in `.codex-os/specs/`
- Consult the standards in `.codex-os/standards/`

---

**Built with Codex-OS** - Turning ideas into reliable software, one spec at a time.
