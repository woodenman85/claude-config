# Troubleshooting Guide — Windows

Common problems after setup and how to fix them.

---

## 🔴 "irm is not recognized" or "iex is not recognized"

**Cause:** You're using Command Prompt (cmd), not PowerShell.

**Fix:**
1. Close the black Command Prompt window
2. Click Start → search `PowerShell` → click **Windows PowerShell**
3. The window should be blue (or dark blue)
4. Try your command again

---

## 🔴 "Running scripts is disabled on this system"

**Cause:** Windows blocks PowerShell scripts by default.

**Fix:** Run this once in PowerShell to allow scripts:
```
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```
Type `Y` and press Enter when prompted. Then run the installer again.

---

## 🔴 "GHL tools not available" or Claude can't see my contacts

**Symptoms:** Claude says it doesn't have access to GHL, or can't search contacts.

**Fix:**
1. Close Claude completely — right-click Claude in the taskbar → Close window (or Alt + F4)
2. Reopen Claude from the Start menu
3. Try again — MCPs load fresh on startup

If still broken, check your GHL token:
1. Open: `C:\Users\[YourName]\AppData\Roaming\Claude\claude_desktop_config.json`
   - Tip: Press **Win + R**, type `%APPDATA%\Claude`, press Enter — the folder opens
2. Look for `"GHL_API_KEY"` — make sure the token starts with `pit-`
3. If the token expired, get a new one in GHL → Settings → Private Integrations

---

## 🔴 "I don't have access to your calendar" or Gmail not working

**Fix:** Gmail and Google Calendar connect through OAuth — you need to connect them manually:

1. Open the Claude desktop app
2. Look for the plug/integrations icon
3. Connect **Gmail** with your Google account
4. Connect **Google Calendar** with your Google account
5. Test: ask Claude "what's on my calendar today?"

---

## 🔴 MCP tools aren't showing up at all

**Most likely cause:** Node.js is not installed, or the config file wasn't updated correctly.

**Check Node.js:**
1. Open PowerShell
2. Type: `node -v` and press Enter
3. If you get an error, go to nodejs.org, install the LTS version, then **close and reopen PowerShell**

**Check the config file:**
1. Press **Win + R**, type `%APPDATA%\Claude`, press Enter
2. Open `claude_desktop_config.json` in Notepad
3. You should see entries for `ghl`, `context7`, and `magic`
4. If missing, run the setup script again

---

## 🔴 Node.js installed but npx not found

**Symptoms:** `npx` command not found after installing Node.js.

**Fix:** Close and reopen PowerShell — the PATH doesn't refresh automatically. If it still doesn't work:
1. Open Start → search "Environment Variables"
2. Click "Edit the system environment variables"
3. Click "Environment Variables"
4. Under "System variables" find "Path" and check that it includes Node.js (usually `C:\Program Files\nodejs\`)
5. If it's missing, reinstall Node.js from nodejs.org

---

## 🔴 Setup script failed partway through

**Fix:** The script is safe to run again — it overwrites (doesn't duplicate) configs.
```
irm https://raw.githubusercontent.com/woodenman85/claude-config/main/onboarding/setup.ps1 | iex
```

---

## 🔴 Claude forgot my name / agency / GHL info

**Fix:** The context file may be missing.
1. Press **Win + R**, type `%USERPROFILE%\.claude`, press Enter
2. Check that `CLAUDE.md` exists and has your info
3. If it's empty or missing, run the setup script again

---

## 🔴 Can't find the Claude config file

The Claude config is at:
```
C:\Users\[YourName]\AppData\Roaming\Claude\claude_desktop_config.json
```

Shortcut: Press **Win + R**, type `%APPDATA%\Claude`, press Enter.

> Note: `AppData` is hidden by default. If you don't see it in File Explorer: View → Show → Hidden items.

---

## 🔴 Canva isn't working

**Fix:** Connect Canva via OAuth:
1. Open Claude desktop app
2. Look for the integrations/plug icon
3. Connect Canva with your Canva account

---

## ✅ How to verify everything is working

Run the verification script in PowerShell:
```
irm https://raw.githubusercontent.com/woodenman85/claude-config/main/onboarding/verify.ps1 | iex
```

Or manually test each tool by asking Claude:
- GHL: "Search my GHL contacts for anyone added in the last 7 days"
- Gmail: "Search my inbox for unread emails from the last 24 hours"
- Calendar: "What's on my calendar today?"

---

## Still stuck?

Message Ben Wood or check the full setup guide:
📄 [SETUP_GUIDE_WINDOWS.md](SETUP_GUIDE_WINDOWS.md)
