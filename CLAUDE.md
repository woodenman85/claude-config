# Project

Monorepo with three packages: frontend, backend, and shared.

## Structure

- `frontend/src/` — UI code
- `backend/api/` — API routes and server logic
- `shared/types/` — Types shared across packages (auto-loaded)

## Token Budget Protocol

Before every task:
- Estimate tokens needed
- If >50k, ask before proceeding — offer to split the task
- Prefer `grep` over reading entire files
- Run `git diff --stat` before `git diff` to scope changes first

## Conventions

- Ignore: `*.test.ts`, `node_modules/`, `dist/`
- MCP servers: `typescript-lsp`, `github`
- Auto-load: `shared/types/index.ts`
