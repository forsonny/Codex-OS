/* ESLint baseline for Codex-OS */
// Supports TS/JS with import/unicorn rules; aligns with Prettier.
module.exports = {
  root: true,
  env: {
    es2022: true,
    node: true,
    browser: false,
    jest: true
  },
  parser: "@typescript-eslint/parser",
  parserOptions: {
    project: ["./tsconfig.json"],
    tsconfigRootDir: __dirname,
    ecmaVersion: "latest",
    sourceType: "module"
  },
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
  },
  overrides: [
    {
      files: ["**/*.js"],
      rules: {
        "@typescript-eslint/no-var-requires": "off"
      }
    },
    {
      files: ["**/*.ts", "**/*.tsx"],
      rules: {}
    },
    {
      files: ["**/*.test.*", "**/*.spec.*"],
      env: { jest: true }
    }
  ]
};
