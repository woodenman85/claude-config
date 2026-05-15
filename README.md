# 🤖 Claude Code Setup — Wood Agency Network

> One command. Five minutes. Claude configured specifically for insurance agents.

---

## 🍎 Mac setup

**[→ Mac Setup Guide](onboarding/SETUP_GUIDE.md)**

```bash
# Install everything
curl -fsSL https://raw.githubusercontent.com/woodenman85/claude-config/main/onboarding/setup.sh | bash

# Verify it's working
curl -fsSL https://raw.githubusercontent.com/woodenman85/claude-config/main/onboarding/verify.sh | bash
```

---

## 🪟 Windows setup

**[→ Windows Setup Guide](onboarding/SETUP_GUIDE_WINDOWS.md)**

Open **PowerShell** (not Command Prompt), then run:

```powershell
# One-time: allow scripts to run
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

# Install everything
irm https://raw.githubusercontent.com/woodenman85/claude-config/main/onboarding/setup.ps1 | iex

# Verify it's working
irm https://raw.githubusercontent.com/woodenman85/claude-config/main/onboarding/verify.ps1 | iex
```

---

## What you get

After setup, Claude can:

| Tool | What it does |
|------|-------------|
| **Daily Briefing** | Pull your leads, calendar, and emails every morning |
| **GHL CRM** | Find contacts, manage pipeline, add notes, trigger workflows |
| **Lead Nurture** | Draft follow-up sequences for life, mortgage, final expense |
| **SMS Drafting** | Write compliant texts to leads and clients |
| **Compliance Check** | Review marketing content before you post or send |
| **Gmail** | Search inbox, draft follow-up emails, write sequences |
| **Google Calendar** | Schedule calls, set reminders, check availability |
| **Canva** | Create social posts, flyers, lead magnets |
| **Website Design** | Build and redesign pages in plain English |
| **FTP Deploy** | Push website changes live instantly |

---

## All documents

| Document | Platform | What it's for |
|----------|----------|--------------|
| [SETUP_GUIDE.md](onboarding/SETUP_GUIDE.md) | 🍎 Mac | Full step-by-step setup |
| [SETUP_GUIDE_WINDOWS.md](onboarding/SETUP_GUIDE_WINDOWS.md) | 🪟 Windows | Full step-by-step setup |
| [QUICK_REFERENCE.md](onboarding/QUICK_REFERENCE.md) | Both | Daily cheat sheet — copy-paste prompts |
| [TROUBLESHOOTING.md](onboarding/TROUBLESHOOTING.md) | 🍎 Mac | Fix common issues |
| [TROUBLESHOOTING_WINDOWS.md](onboarding/TROUBLESHOOTING_WINDOWS.md) | 🪟 Windows | Fix common issues |
| [verify.sh](onboarding/verify.sh) | 🍎 Mac | Check everything is working |
| [verify.ps1](onboarding/verify.ps1) | 🪟 Windows | Check everything is working |

---

## Need help?

Contact **Ben Wood** — he set this up and can walk you through it.
