# Step-by-Step Setup Guide
### Claude Code for Wood Agency Network

Don't worry if you've never done anything like this before. Follow each step exactly and you'll be done in about 15 minutes. Every step has a ✅ checkpoint so you know you're on track.

---

## What you'll end up with

After setup, Claude will be able to:
- 🏗️ **Build and redesign your website** — describe it, Claude builds it
- 📋 **Work inside your GoHighLevel CRM** — contacts, pipelines, workflows, automations
- 🎨 **Create marketing materials in Canva** — social posts, flyers, presentations
- 📧 **Draft and organize emails in Gmail** — follow-ups, outreach, client emails
- 📅 **Manage your Google Calendar** — book appointments, set reminders, check availability
- 🖥️ **Generate professional website components** — hero sections, forms, testimonials

---

# PHASE 1 — Run the installer
*Gets the core tools set up automatically*

---

## Step 1 — Install Claude Code

1. Go to **https://claude.ai/download** on your Mac
2. Download and install the app (drag it to Applications like any Mac app)
3. Open Claude and sign in
4. You need a **Claude Pro plan** ($20/mo) — if you don't have one, click your name → Upgrade to Pro

✅ **Done when:** Claude opens and you can type to it.

---

## Step 2 — Get your GHL Private Integration Token

This gives Claude permission to work inside your GoHighLevel account.

1. Log into **GoHighLevel**
2. Click **Settings** (gear icon, bottom left)
3. Click **Integrations**
4. Click **Private Integrations**
5. Click **+ Create New Integration** (or **+ New**)
6. Name it: `Claude MCP`
7. **Turn on ALL scopes** — scroll through and enable everything
8. Click **Save**
9. **Copy the token** — it starts with `pit-` and looks like:
   `pit-a1b2c3d4-e5f6-7890-abcd-ef1234567890`

> ⚠️ Keep this safe — don't share it publicly. It's like a password for your GHL account.

✅ **Done when:** You have a `pit-...` token copied somewhere safe.

---

## Step 3 — Get your GHL Location ID

1. Still in GoHighLevel → **Settings**
2. Click **Business Profile** (sometimes called Company or Location Info)
3. Find **Location ID** — it's a string like: `MpDMPLkOAjXBtmXs5G6B`
4. Copy it

✅ **Done when:** You have your Location ID copied.

---

## Step 4 — Get your free Magic API key

This makes Claude generate beautiful, professional website designs instead of plain-looking ones.

1. Go to **https://21st.dev**
2. Click **Sign Up** — completely free
3. Once logged in, find your **API Key** in the dashboard
4. Copy it

> You can skip this for now and add it later — just press Enter when the installer asks.

✅ **Done when:** You have an API key from 21st.dev (or you're skipping for now).

---

## Step 5 — Run the installer

### Open Terminal:
1. Press **Cmd + Space** at the same time
2. Type `Terminal`
3. Press **Enter**
4. A window opens with a blinking cursor — that's Terminal. Don't be intimidated!

### Paste and run this command:
Click inside the Terminal window, paste this entire line, then press **Enter**:

```
curl -fsSL https://raw.githubusercontent.com/woodenman85/claude-config/main/onboarding/setup.sh | bash
```

> **To paste in Terminal:** Cmd + V (same as everywhere else on your Mac)

### The installer will ask you for:
| Prompt | What to type |
|--------|-------------|
| Your name | Your first and last name |
| GHL token | Paste your `pit-...` token from Step 2 |
| GHL Location ID | Paste your Location ID from Step 3 |
| 21st.dev API key | Paste your key from Step 4 (or press Enter to skip) |
| Set git name/email? | Type `y` then enter your email if you want, or `n` to skip |

✅ **Done when:** You see `Setup complete!` in green text.

---

## Step 6 — Restart Claude

1. Press **Cmd + Q** to quit Claude completely
2. Open Claude again from your Applications folder
3. Start a **new session** (new conversation)

✅ **Phase 1 complete!** GHL, website design tools, and Context7 are all live.

---

# PHASE 2 — Connect your apps
*Takes 3 minutes — no tokens needed, just click to authorize*

Gmail, Google Calendar, and Canva connect through the Claude app using your existing accounts. Claude never sees your password — it's the same "Sign in with Google" you've used everywhere.

---

## Step 7 — Connect Gmail

1. In Claude, click the **integrations or plugins icon** (looks like puzzle pieces or a grid, usually top right or in settings)
2. Find **Gmail** in the list
3. Click **Connect**
4. A Google sign-in window opens — sign in with your Gmail account
5. Click **Allow** when Google asks for permission

✅ **Done when:** Gmail shows as connected in Claude.

**Test it:** Type `"Search my Gmail inbox for any leads from this week"` — Claude should return real results.

---

## Step 8 — Connect Google Calendar

1. Same integrations area in Claude
2. Find **Google Calendar**
3. Click **Connect** → sign in with your Google account → Allow

✅ **Done when:** Google Calendar shows as connected.

**Test it:** Type `"What's on my calendar this week?"` — Claude should show your real events.

---

## Step 9 — Connect Canva

1. Same integrations area in Claude
2. Find **Canva**
3. Click **Connect** → sign in with your Canva account → Allow
4. If you don't have a Canva account: go to **canva.com** → Sign up free → come back and connect

✅ **Done when:** Canva shows as connected.

**Test it:** Type `"Create a simple Instagram post about life insurance"` — Claude should generate a real Canva design.

---

# You're fully set up! 🎉

Here's what Claude can now do for you. Copy and paste any of these to try it out:

---

## 🏗️ Website
> *"Look at woodagencylife.com and tell me what you'd change to get more leads."*

> *"Build me a hero section for my life insurance website. Professional, trust-building, mobile-first, with a 'Book a Free Call' button."*

> *"Create a testimonials section for my insurance website — clean and modern."*

---

## 📋 GoHighLevel
> *"Audit my GHL account — show me my pipelines, how many contacts I have, and what workflows are running."*

> *"Help me build an automated follow-up sequence for new leads."*

> *"Show me all contacts added in the last 7 days."*

---

## 📧 Gmail
> *"Draft a follow-up email to a lead who filled out my life insurance form but hasn't booked a call yet."*

> *"Search my inbox for emails I haven't replied to from this week."*

> *"Write a referral request email I can send to happy clients."*

---

## 📅 Google Calendar
> *"What does my week look like?"*

> *"Schedule a 30-minute consultation call with [name] for Thursday at 2pm."*

> *"Block every Monday morning for lead follow-up calls."*

---

## 🎨 Canva
> *"Create an Instagram post about the importance of life insurance for young families."*

> *"Design a flyer for a free life insurance consultation."*

> *"Make a Facebook post about mortgage protection with a CTA to book a call."*

---

## Something didn't work?

**"Command not found" in Terminal**
→ Make sure you copied the whole command starting with `curl`

**"Claude desktop app not found"**
→ Install Claude first from claude.ai/download, then re-run the installer

**Can't find the integrations panel in Claude**
→ Look for a small icon in the top-right of the Claude window, or check Settings → Integrations

**Gmail/Calendar/Canva won't connect**
→ Make sure you're signed into that account in your browser first, then try again

**Anything else**
→ Contact Ben Wood — he can walk you through it

---

*Setup built by Ben Wood · github.com/woodenman85/claude-config*
