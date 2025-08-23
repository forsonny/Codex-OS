# Codex-OS

**An AI-powered development framework that transforms product ideas into production-ready software through intelligent workflows, consistent standards, and seamless AI assistant integration.**

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![TypeScript](https://img.shields.io/badge/TypeScript-007ACC?logo=typescript&logoColor=white)](https://www.typescriptlang.org/)
[![Python](https://img.shields.io/badge/Python-3776AB?logo=python&logoColor=white)](https://www.python.org/)

---

## 🎯 Why Codex-OS?

**The Problem:** Most development teams struggle with inconsistency—different coding styles, ad-hoc planning processes, incomplete documentation, and manual repetitive tasks that lead to bugs and technical debt.

**The Solution:** Codex-OS provides an **AI-powered development framework** that guides you from initial product requirements to production deployment with:

- 🤖 **AI-First Workflows** — Work naturally with AI assistants using simple commands
- 📋 **Structured Planning** — Turn PRDs into actionable technical specs
- 🔄 **Consistent Processes** — Repeatable workflows for every development phase  
- 🛡️ **Safety by Default** — Built-in quality gates and rollback strategies
- 📚 **Living Documentation** — Auto-updating specs and decision records

## 🚀 Quick Start

### Installation

#### Option 1: Automated Installation (Recommended)

1. **Clone the repository**:
   ```bash
   git clone https://github.com/forsonny/codex-os codex-os
   cd codex-os
   ```

2. **Run the installation script**:
   ```bash
   chmod +x scripts/install-global.sh
   ./scripts/install-global.sh
   ```
   
   This script will:
   - Move global files to `~/.codex-os/`
   - Backup and install AGENTS.md to `~/.codex/`
   - Clean up placeholder directories
   - Verify the installation

3. **Make helper scripts executable**:
   ```bash
   chmod +x bin/co-*
   ```

4. **Install dependencies** (if using the TypeScript/JavaScript stack):
   ```bash
   npm install  # or pnpm install
   ```

#### Option 2: Manual Installation

1. **Clone the repository**:
   ```bash
   git clone https://github.com/forsonny/codex-os codex-os
   cd codex-os
   ```

2. **Move global files to your home directory**:
   ```bash
   # Create the target directories
   mkdir -p ~/.codex-os
   mkdir -p ~/.codex
   
   # Move the CONTENTS of the global Codex-OS folder
   mv "move to HOME/.codex-os"/* ~/.codex-os/
   
   # Backup existing AGENTS.md if it exists
   if [ -f ~/.codex/AGENTS.md ]; then
     cp ~/.codex/AGENTS.md ~/.codex/AGENTS.md.backup.$(date +%Y%m%d_%H%M%S)
     echo "Backed up existing AGENTS.md to ~/.codex/AGENTS.md.backup.$(date +%Y%m%d_%H%M%S)"
   fi
   
   # Move new AGENTS.md to ~/.codex directory
   mv "move to HOME/.codex/AGENTS.md" ~/.codex/AGENTS.md
   ```

3. **Clean up placeholder directories**:
   ```bash
   # Remove the now-empty placeholder directories
   rmdir "move to HOME/.codex-os/instructions/core"
   rmdir "move to HOME/.codex-os/instructions"
   rmdir "move to HOME/.codex-os/standards/code-style"
   rmdir "move to HOME/.codex-os/standards"
   rmdir "move to HOME/.codex-os/product"
   rmdir "move to HOME/.codex-os"
   rmdir "move to HOME/.codex"
   rmdir "move to HOME"
   ```

4. **Make helper scripts executable**:
   ```bash
   chmod +x bin/co-*
   ```

5. **Install dependencies** (if using the TypeScript/JavaScript stack):
   ```bash
   npm install  # or pnpm install
   ```

### Your First Project

You need to add/update the `.codex-os/specs/srd.md`. The `srd.md` is the file where you will place your PRD or MVP infomation in.

**Work with your AI assistant using these commands:**

```
/co-plan
```
*Plan your product from requirements*

```
/co-create-spec User Authentication System
```
> **💡 Pro Tip:** Use `/co-create-spec` to create a spec for the full project based on srd.md

*Create a technical specification*

```
/co-exec-tasks .codex-os/specs/2025-08-23-user-authentication-system
```
*Execute the implementation*

```
/co-exec-task [TASK-ID]
```
*Execute excate task*

```
/co-analyze
```
*Analyze your codebase health*

> **💡 Pro Tip:** These `/co-` commands work with Claude, GPT, and other AI assistants. Just type the command and your AI will execute the corresponding workflow!

## 🏗️ How It Works

Codex-OS is an **AI-powered development framework** that guides you through a proven workflow:

```
PRD/Idea → /co-plan → /co-create-spec → /co-exec-tasks → /co-analyze → Deploy
    ↓          ↓           ↓              ↓            ↓          ↓
  Goals → Roadmap → Specification → Implementation → Health → Production
```

### 1. **`/co-plan`** 📋
*Transform raw product requirements into structured documentation*
- Mission and success metrics
- Technology stack decisions  
- Roadmap with milestones
- Architecture decision records (ADRs)

### 2. **`/co-create-spec`** 📝
*Convert plans into actionable technical specifications*
- Software Requirements Document (SRD)
- Technical architecture and APIs
- Prioritized task breakdown with acceptance criteria

### 3. **`/co-exec-tasks`** ⚡
*Implement features safely with automated quality gates*
- Test-driven development
- Small, atomic commits
- Continuous integration
- Documentation updates

### 4. **`/co-analyze`** 🔍
*Monitor codebase health and identify improvements*
- Architecture analysis
- Risk assessment
- Performance bottlenecks
- Actionable recommendations

> **🤖 AI-First Approach:** Simply type these commands with your AI assistant (Claude, GPT, etc.) and watch as they execute complete workflows, write code, run tests, and update documentation automatically.

## 🛠️ Core Features

### 🤖 **AI-Powered Commands**
The primary way to interact with Codex-OS is through AI assistant commands:

| Command | Purpose |
|---------|---------|
| `/co-plan` | Update product documentation from requirements |
| `/co-create-spec [title]` | Generate new feature specifications |
| `/co-exec-tasks [spec-path]` | Execute all tasks in a specification |
| `/co-exec-task [task-id]` | Execute a single task with minimal changes |
| `/co-analyze` | Analyze codebase health and generate reports |

*These commands integrate seamlessly with Claude, GPT, and other AI assistants through the global `AGENTS.md` configuration.*

### 📁 **Intelligent Project Structure**
```
.codex-os/
├── product/         # Mission, roadmap, decisions, stack
├── specs/          # Feature specifications with tasks
└── standards/      # Coding standards and best practices
```

### 🎨 **Opinionated but Flexible Standards**
- **TypeScript/JavaScript**: Prettier + ESLint with strict mode
- **Python**: Black + Ruff with comprehensive type hints  
- **Testing**: Unit → Integration → E2E pyramid
- **Git**: Conventional Commits with semantic versioning
- **Security**: Secret scanning, dependency auditing, safe defaults

### 🔧 **Optional CLI Tools**
For users who prefer direct command-line access, helper scripts are available:
```bash
bin/co-plan              # Alternative to /co-plan
bin/co-create-spec       # Alternative to /co-create-spec
bin/co-exec-tasks        # Alternative to /co-exec-tasks
# ... etc
```

## 🏗️ Technology Stack

### **Default Full-Stack Web**
- **Frontend**: React 18 + Next.js 14+ (App Router)
- **Backend**: FastAPI (Python) or NestJS (TypeScript)
- **Database**: PostgreSQL 15+ with Redis caching
- **Testing**: Vitest/Jest + pytest + Playwright
- **DevOps**: Docker + GitHub Actions

### **Supported Languages**
- **TypeScript/JavaScript** (primary)
- **Python 3.11+** (services, data workflows)  
- **Bash** (automation scripts)

## 📖 Real-World Example

Let's say you have a PRD for a "Snake Game in 3D". Here's how Codex-OS guides you through your AI assistant:

### 1. Planning Phase
```
/co-plan
```
**AI Creates:**
- `product/mission.md` — Problem statement and success metrics
- `product/stack.md` — Three.js + HTML5 + TypeScript decisions
- `product/roadmap.md` — MVP → v1 → v1.x milestones

### 2. Specification Phase  
```
/co-create-spec 3D Snake Game
```
**AI Creates:**
- `specs/2025-08-23-3d-snake-game/srd.md` — User requirements
- `specs/2025-08-23-3d-snake-game/tech-spec.md` — 3D architecture, controls, rendering
- `specs/2025-08-23-3d-snake-game/tasks.md` — 12 atomic, testable tasks

### 3. Execution Phase
```
/co-exec-tasks .codex-os/specs/2025-08-23-3d-snake-game
```
**AI Implements:**
- Task 1: Three.js scene setup with camera
- Task 2: Snake entity with movement physics  
- Task 3: Food generation and collision detection
- ...and so on, with tests and documentation

### 4. Analysis Phase
```
/co-analyze
```
**AI Generates:**
- Performance analysis (60 FPS requirement met?)
- Security review (no XSS vulnerabilities)
- Code quality metrics (test coverage, complexity)
- Recommendations for optimization

> **🎯 The Result:** A complete, production-ready 3D Snake Game built through AI collaboration, with comprehensive tests, documentation, and quality assurance—all from a simple PRD!

## 📚 Documentation

### **Getting Started**
- [Installation Guide](#installation) — Automated and manual setup
- [First Project](#your-first-project) — Walk through the complete workflow
- [CLI Reference](#powerful-cli-tools) — All available commands

### **Advanced Usage**  
- [Custom Standards](/.codex-os/standards/) — Override global defaults
- [Workflow Customization](/.codex-os/instructions/) — Adapt processes to your needs
- [AI Integration](/move%20to%20HOME/.codex/AGENTS.md) — Enhance with Claude, GPT, etc.

## 🤝 Contributing

We welcome contributions! Please see our [contributing guidelines](CONTRIBUTING.md) for details.

### **Ways to Contribute**
- 🐛 Report bugs and suggest improvements
- 📚 Improve documentation and examples  
- 🔧 Add support for new languages/frameworks
- 🎨 Create new workflow templates

## 📄 License

MIT License - see the [LICENSE](LICENSE) file for details.

---

<div align="center">

**Built with Codex-OS** — *Turning ideas into reliable software, one spec at a time.*

[⭐ Star this repo](https://github.com/forsonny/codex-os) if you find it useful!

</div>
