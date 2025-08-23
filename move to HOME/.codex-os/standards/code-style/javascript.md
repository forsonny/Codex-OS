# Codex-OS Code Style — JavaScript
_Version 1.0 • Prefer TypeScript; when using JS, enable type-checking_

## Tooling
- **Formatter**: Prettier (print width 100, single quotes, trailing commas `all`, semicolons on)
- **Linter**: ESLint (`eslint:recommended`, `unicorn`, `import`)
- **Type checking**: Enable **TypeScript check** for JS with `// @ts-check` and JSDoc types
- **Modules**: Use **ESM** (`"type": "module"` in `package.json`)

### `.eslintrc.cjs` (baseline)
```js
module.exports = {
  root: true,
  extends: ["eslint:recommended", "plugin:import/recommended", "plugin:unicorn/recommended"],
  plugins: ["import", "unicorn"],
  rules: {
    "import/order": ["error", {
      "groups": ["builtin", "external", "internal", ["parent", "sibling", "index"]],
      "newlines-between": "always",
      "alphabetize": { "order": "asc", "caseInsensitive": true }
    }],
    "unicorn/prevent-abbreviations": "off",
    "no-console": ["warn", { "allow": ["warn", "error"] }]
  }
};
```

## Naming & Files
- Files: `kebab-case.js`
- Variables/functions: `camelCase`; Classes: `PascalCase`
- Constants: `UPPER_SNAKE_CASE`

## Patterns
- `// @ts-check` at the top of each JS file to enable type checking.
- JSDoc your public APIs; prefer small, pure functions.
- Avoid mutation; use `const` by default; never `var`.

## Example
```js
// @ts-check

/**
 * @typedef {Object} CreateUserInput
 * @property {string} email
 * @property {string} displayName
 */

/**
 * @param {CreateUserInput} input
 * @returns {{ id: string, email: string, displayName: string, createdAt: Date }}
 */
export function createUser(input) {
  if (!/^[^@]+@[^@]+\.[^@]+$/.test(input.email)) {
    throw new Error("Invalid email");
  }
  return { id: crypto.randomUUID(), ...input, createdAt: new Date() };
}
```
