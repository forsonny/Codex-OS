# Codex-OS Code Style — TypeScript
_Version 1.0 • Strict mode everywhere_

## Tooling
- **Formatter**: Prettier (print width 100, single quotes, trailing commas `all`, semicolons on)
- **Linter**: ESLint (`@typescript-eslint`, `unicorn`, `import`, `jsx-a11y` for React)
- **Build**: tsconfig strict, module `NodeNext`, target `ES2022`
- **Tests**: Vitest/Jest + `ts-node`/esbuild for tooling

### `tsconfig.json` (baseline)
```json
{
  "compilerOptions": {
    "target": "ES2022",
    "module": "NodeNext",
    "moduleResolution": "NodeNext",
    "strict": true,
    "noUncheckedIndexedAccess": true,
    "noImplicitOverride": true,
    "noFallthroughCasesInSwitch": true,
    "useUnknownInCatchVariables": true,
    "resolveJsonModule": true,
    "esModuleInterop": true,
    "forceConsistentCasingInFileNames": true,
    "skipLibCheck": true,
    "baseUrl": ".",
    "paths": {
      "@/*": ["src/*"]
    },
    "types": []
  },
  "include": ["src", "tests", "scripts"],
  "exclude": ["dist", "node_modules"]
}
```

### `.eslintrc.cjs` (baseline)
```js
module.exports = {
  root: true,
  parser: "@typescript-eslint/parser",
  plugins: ["@typescript-eslint", "unicorn", "import"],
  extends: [
    "eslint:recommended",
    "plugin:@typescript-eslint/recommended",
    "plugin:import/recommended",
    "plugin:import/typescript",
    "plugin:unicorn/recommended"
  ],
  rules: {
    "import/order": ["error", {
      "groups": ["builtin", "external", "internal", ["parent", "sibling", "index"]],
      "newlines-between": "always",
      "alphabetize": { "order": "asc", "caseInsensitive": true }
    }],
    "unicorn/prevent-abbreviations": "off",
    "@typescript-eslint/explicit-module-boundary-types": "off",
    "@typescript-eslint/no-explicit-any": "error",
    "no-console": ["warn", { "allow": ["warn", "error"] }]
  }
};
```

## Formatting
- 2-space indentation; 100-col print width (enforced by Prettier).
- Always use braces for control blocks.
- Single quotes; semicolons required; trailing commas where valid.

## Naming
- Files: `kebab-case.ts`; React components: `PascalCase.tsx`
- Variables/functions: `camelCase`; Classes/Types/Interfaces: `PascalCase`
- Constants: `UPPER_SNAKE_CASE`
- Booleans: `isX`, `hasX`, `shouldX`, `canX`
- Enums: `PascalCase` with `UPPER_SNAKE_CASE` members

## Imports/Exports
- Prefer **named exports** (no default exports).
- Group imports: builtin → external → internal; alphabetize within groups.
- Avoid deep `../../..` by configuring `paths` in `tsconfig`.

## Functions & Classes
- Single responsibility; prefer pure functions.
- Use **early returns**; keep functions ~30–40 lines where reasonable.
- Use `readonly` for fields that shouldn’t change.
- Never use `any`—use `unknown` and narrow with type guards.

## React (if used)
- Functional components, hooks, and React 18 features.
- Props interface named `ComponentNameProps`.
- Avoid prop drilling; prefer context or composition.
- Accessibility: follow `jsx-a11y` rules; label controls properly.

## Example
```ts
// src/users/user-service.ts
export interface CreateUserInput {
  email: string;
  displayName: string;
}

export interface User {
  id: string;
  email: string;
  displayName: string;
  createdAt: Date;
}

export class UserService {
  constructor(private readonly repo: UserRepository) {}

  async createUser(input: CreateUserInput): Promise<User> {
    if (!isValidEmail(input.email)) throw new Error("Invalid email");
    const dupe = await this.repo.findByEmail(input.email);
    if (dupe) throw new Error("User already exists");
    return this.repo.insert({ ...input, createdAt: new Date() });
  }
}
```
