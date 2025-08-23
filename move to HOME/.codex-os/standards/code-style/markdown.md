# Codex-OS Code Style — Markdown
_Version 1.0 • For docs/PRDs/specs_

## Formatting
- Use **ATX headings** (`#`, `##`, …). One `# H1` per file.
- Keep lines ~100 chars where practical; wrap sentences manually to keep diffs readable.
- Leave a blank line **after** headings and **between** paragraphs/lists/code blocks.
- Use fenced code blocks with language tags (```` ```ts ```` / ```` ```python ```` etc.).
- Avoid trailing spaces; end files with a newline.

## Structure
- Start with an H1 title, then an optional short context/summary.
- Prefer **lists and tables** for structured data; avoid dense paragraphs.
- Use **relative links** for intra-repo references; include alt text for images.
- Use callouts sparingly with blockquotes `> Note:` / `> Warning:`.

## Content Guidelines
- Be concise and actionable. Explain **why** decisions were made.
- For PRDs/specs, include: goals, non-goals, success metrics, risks, and acceptance criteria.
- Keep a change log or decision record (ADRs) for major shifts.

## Linting
- Enable **markdownlint** with a lightweight config (e.g., MD001, MD012, MD022, MD025, MD033 selectively disabled for code blocks with HTML).
- Spellcheck using editor extensions; keep acronyms consistent.

## Examples
### Task list
```md
## Tasks
1. Add user registration API
2. Implement email verification
3. Add login with session management
```

### Table
```md
| Endpoint | Method | Description           |
|---------:|:------:|-----------------------|
| /users   | POST   | Create a new user     |
| /login   | POST   | Authenticate a user   |
```
