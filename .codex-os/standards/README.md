# Project Standards

This folder contains **project-specific standards** that override the global Codex-OS defaults. You can customize these files to match your team's preferences, technology choices, and coding conventions.

## 🔄 How It Works

Codex-OS follows a **project-local first** precedence:

```
Project Standards (.codex-os/standards/) → Global Standards (~/.codex-os/standards/)
```

- **If a file exists here** → Codex-OS uses your project-specific version
- **If a file doesn't exist here** → Codex-OS falls back to the global default
- **You can mix and match** → Override only the files you want to customize

## 📁 Available Standards Files

### Core Standards
| File | Purpose | When to Customize |
|------|---------|------------------|
| `tech-stack.md` | Default technologies, frameworks, tools | Different language/framework preferences |
| `code-style.md` | Cross-language formatting and naming rules | Team-specific style preferences |
| `best-practices.md` | Development philosophy and quality gates | Different testing/security/workflow needs |

### Language-Specific Guides
| File | Purpose | When to Customize |
|------|---------|------------------|
| `code-style/typescript.md` | TypeScript formatting, linting, patterns | Different TS config or React patterns |
| `code-style/python.md` | Python formatting, type hints, structure | Different Python version or tools |
| `code-style/javascript.md` | JavaScript (non-TS) standards | Legacy JS projects or different configs |
| `code-style/markdown.md` | Documentation formatting rules | Different doc structure preferences |

## 🚀 Getting Started

### Option 1: Start Fresh (Recommended)
Delete the sample files and create your own:

```bash
# Remove sample files
rm -rf .codex-os/standards/*

# Create your custom standards
# (Codex-OS will fall back to global defaults for missing files)
```

### Option 2: Customize Existing
Edit the sample files to match your preferences:

```bash
# Edit the tech stack for your project
vim .codex-os/standards/tech-stack.md

# Adjust code style rules
vim .codex-os/standards/code-style.md
```

### Option 3: Selective Override
Keep only the files you want to customize:

```bash
# Keep only the tech stack override
rm .codex-os/standards/code-style.md
rm .codex-os/standards/best-practices.md
# (These will use global defaults)
```

## 📝 Common Customizations

### Tech Stack Examples
```markdown
# Use Vue instead of React
- Frontend: Vue 3 + Nuxt 3

# Use Django instead of FastAPI  
- Backend: Django + Django REST Framework

# Use PostgreSQL with different version
- Database: PostgreSQL 14 (not 15+)
```

### Code Style Examples
```markdown
# Different line length
- Line length: 120 (instead of 100)

# Different indentation
- Python: 2 spaces (instead of 4)

# Different naming for React
- React files: `ComponentName.component.tsx`
```

### Best Practices Examples
```markdown
# Different test coverage target
- Coverage threshold: 90% (instead of 70%)

# Different commit style
- Use Angular commit convention (instead of Conventional Commits)

# Additional security requirements
- All PRs must pass penetration testing
```

## 🎯 Project-Specific Scenarios

### **Legacy Codebase**
```bash
# Override to match existing patterns
cp ~/.codex-os/standards/code-style.md .codex-os/standards/
# Edit to match legacy naming conventions, file structure, etc.
```

### **Enterprise Environment**
```bash
# Add compliance requirements
cp ~/.codex-os/standards/best-practices.md .codex-os/standards/
# Add sections for SOX compliance, security reviews, etc.
```

### **Different Language Focus**
```bash
# For a Python-only project
rm .codex-os/standards/code-style/typescript.md
rm .codex-os/standards/code-style/javascript.md
# Customize python.md with project-specific requirements
```

### **Startup vs Enterprise**
```bash
# Startup: Faster iteration, fewer gates
# Edit best-practices.md to reduce ceremony

# Enterprise: More rigor, compliance
# Edit best-practices.md to add approval workflows
```

## 🔍 Validation

After customizing your standards, validate they work:

```bash
# Test with AI commands
/co-analyze    # Should use your custom standards
/co-create-spec "Test Feature"    # Should follow your style guide

# Or with CLI
bin/co-analyze
bin/co-create-spec "Test Feature"
```

## 💡 Tips

- **Start minimal** — Only override what you actually need to change
- **Document decisions** — Add comments explaining why you deviated from defaults
- **Keep in sync** — Periodically review global defaults for useful updates
- **Team alignment** — Make sure all team members understand your customizations

## 📚 Examples in the Wild

Check out these example customizations:

- **Monorepo Setup** — Custom tech-stack.md for workspace management
- **Mobile App** — React Native specific code-style overrides
- **Data Science** — Python-focused with Jupyter and pandas conventions
- **Enterprise SaaS** — Additional security and compliance requirements

---

## Current Status

> **⚠️ These are sample/default files** — The current files in this folder are examples copied from the global defaults. Feel free to modify, replace, or remove them entirely to fit your project's needs.

**Next Steps:**
1. Review each file and decide what to customize
2. Delete or modify files as needed  
3. Test your changes with `/co-analyze` or similar commands
4. Update this README with your specific customizations (optional)
