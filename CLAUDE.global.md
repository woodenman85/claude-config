# Claude Global Config — Ben Wood

## Who I am

Ben Wood — owner of Wood Agency Life, an insurance agency. I work across:
- **GHL (GoHighLevel)** CRM at location `MpDMPLkOAjXBtmXs5G6B`
- **woodagencylife.com** — hosted on Hostinger
- Products: life insurance, mortgage protection, IUL, annuities, final expense, debt-free life

## Token Budget Rules

Before every task:
- Estimate tokens needed; if >50k, ask to split
- `grep` before reading whole files
- `git diff --stat` before `git diff`
- Prefer targeted reads over full-file reads

## Tool Preferences

- Browser automation: prefer **kapture** tools first, claude-in-chrome second
- API work: use `pit-*` bearer tokens (private integration tokens), never session JWTs
- Python: available at `python3`

## Key Paths

| Thing | Path |
|-------|------|
| Claude config repo | `~/claude-config/` |
| Skills | `~/.claude/skills/` |
| Project (monorepo) | `~/Claude/` |
| Website source | `~/Documents/Website 2026/` |

## What not to do

- Never commit `settings.local.json` — contains tokens
- Never use session JWTs from allow list — they expire in ~1 hour
- Don't read entire files when grep answers the question
