# Troubleshooting Guide

Common problems after setup and how to fix them.

---

## 🔴 "GHL tools not available" or Claude can't see my contacts

**Symptoms:** Claude says it doesn't have access to GHL, or `search_contacts` doesn't work.

**Fix:**
1. Quit the Claude desktop app completely (Cmd+Q)
2. Reopen it
3. Try again — MCPs load fresh on startup

If still broken:
1. Open Claude desktop app
2. Go to Settings → Developer → MCP Servers
3. Check that "ghl" shows a green dot (connected)
4. If it shows red, your GHL token may have expired

**Token expired?** Get a new one:
1. Log into GHL → Settings → Private Integrations
2. Create a new integration token (starts with `pit-`)
3. Open: `~/Library/Application Support/Claude/claude_desktop_config.json`
4. Find `"GHL_API_KEY"` and replace the old token
5. Restart Claude

---

## 🔴 "I don't have access to your calendar" or Gmail not working

**Symptoms:** Claude can't read emails or calendar events.

**Fix:** Gmail and Google Calendar connect through OAuth — not the setup script. You need to connect them manually:

1. Open the Claude desktop app
2. Look for the plug/integrations icon (bottom of the sidebar)
3. Connect **Gmail** with your Google account
4. Connect **Google Calendar** with your Google account
5. Test: ask Claude "what's on my calendar today?"

---

## 🔴 MCP tools aren't showing up at all

**Symptoms:** Claude doesn't seem to have any special tools beyond basic conversation.

**Most likely cause:** Node.js is not installed, or the config file wasn't updated correctly.

**Check Node.js:**
```bash
node -v
```
If this gives an error, go to https://nodejs.org, download the LTS version, install it, and restart Claude.

**Check the config file:**
```bash
cat ~/Library/Application\ Support/Claude/claude_desktop_config.json
```
You should see entries for `ghl`, `context7`, and `magic`. If the file is empty or missing those, run the setup script again:
```bash
curl -fsSL https://raw.githubusercontent.com/woodenman85/claude-config/main/onboarding/setup.sh | bash
```

---

## 🔴 "npx: command not found" error

**Symptoms:** Error messages mentioning `npx` when MCPs try to start.

**Fix:** npx comes with Node.js. Install Node.js from https://nodejs.org (LTS version), then restart Claude.

---

## 🔴 Magic components aren't generating

**Symptoms:** Claude can't create UI components, or says Magic MCP isn't available.

**Fix:**
1. Check your 21st.dev API key hasn't expired — log into https://21st.dev to verify
2. Open: `~/Library/Application Support/Claude/claude_desktop_config.json`
3. Find `"API_KEY"` under the `magic` server and verify the key is correct
4. Restart Claude

---

## 🔴 Setup script failed partway through

**Symptoms:** The script stopped with an error message.

**Fix:** The script is safe to run again — it overwrites (doesn't duplicate) configs.
```bash
curl -fsSL https://raw.githubusercontent.com/woodenman85/claude-config/main/onboarding/setup.sh | bash
```

---

## 🔴 Claude forgot my name / agency / GHL info

**Symptoms:** Claude is asking who you are or what GHL location to use.

**Fix:** The context file (`~/.claude/CLAUDE.md`) may be missing or empty.
```bash
cat ~/.claude/CLAUDE.md
```
If it's blank or missing, run the setup script again — it recreates this file with your info.

---

## 🔴 Canva isn't working

**Symptoms:** Claude can't create or edit Canva designs.

**Fix:** Canva connects via OAuth — same process as Gmail/Calendar:
1. Open Claude desktop app
2. Look for the integrations/plug icon
3. Connect Canva with your Canva account

---

## ✅ How to verify everything is working

Run the built-in verification script:
```bash
curl -fsSL https://raw.githubusercontent.com/woodenman85/claude-config/main/onboarding/verify.sh | bash
```

Or manually test each tool by asking Claude:
- GHL: "Search my GHL contacts for anyone added in the last 7 days"
- Gmail: "Search my inbox for unread emails from the last 24 hours"
- Calendar: "What's on my calendar today?"
- Magic: "Create a simple hero section for an insurance agency — just show me a preview"

---

## Still stuck?

Message Ben Wood or check the full setup guide:
📄 [SETUP_GUIDE.md](SETUP_GUIDE.md)
