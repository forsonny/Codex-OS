# AI Agent Instructions

This folder contains **workflow playbooks** that AI agents read and execute when you use `/co-` commands. These are machine-readable instructions that define how AI assistants should perform development tasks in your project.

## 🤖 How AI Agents Use These Files

When you type `/co-plan`, `/co-create-spec`, etc., your AI assistant:

1. **Reads the corresponding instruction file** (e.g., `core/plan-product.md`)
2. **Follows the step-by-step procedures** defined in the playbook
3. **Uses project-specific customizations** if they exist here
4. **Falls back to global defaults** (`~/.codex-os/instructions/`) if files are missing

## 🔄 Precedence System

```
Project Instructions (.codex-os/instructions/) → Global Instructions (~/.codex-os/instructions/)
```

- **If a workflow exists here** → AI uses your project-specific version
- **If a workflow doesn't exist here** → AI uses the global default
- **You can customize selectively** → Override only the workflows you need to modify

## 📁 Core Workflow Instructions

### Available Workflows (`core/` subfolder)

| File | AI Command | Purpose | When to Customize |
|------|------------|---------|------------------|
| `plan-product.md` | `/co-plan` | Transform PRDs into product documentation | Different planning methodologies |
| `create-spec.md` | `/co-create-spec` | Generate technical specifications from requirements | Custom spec templates or formats |
| `execute-tasks.md` | `/co-exec-tasks` | Implement all tasks in a specification | Different development workflows |
| `execute-task.md` | `/co-exec-task` | Implement a single task minimally | Custom task execution patterns |
| `analyze-product.md` | `/co-analyze` | Generate codebase health reports | Different analysis criteria |

## 🛠️ Customizing AI Behavior

### Common Customization Scenarios

#### **Different Planning Methodology**
```markdown
# In your custom plan-product.md
## Step-by-Step Procedure
### 1) Use RICE Prioritization (not MoSCoW)
1. Read the PRD and extract features
2. Score each feature using RICE (Reach, Impact, Confidence, Effort)
3. Generate roadmap.md with RICE scores in decision matrix
```

#### **Custom Spec Templates**
```markdown
# In your custom create-spec.md
## 2) Output Structure
Create a new folder with additional files:
- compliance-checklist.md  # Required for our enterprise environment
- security-review.md       # Security team review template
- performance-budget.md    # Performance requirements tracking
```

**Remember:** These instructions are read by AI agents, not humans. Write them as clear, executable procedures that AI can follow reliably.
