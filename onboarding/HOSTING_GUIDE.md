# Hosting & Deployment Guide
### Getting your website live on Hostinger

This guide covers two scenarios:
- **Starting from zero** — no website yet, need to get hosting
- **Already have Hostinger** — just need to find your FTP credentials and deploy

---

## Starting From Zero — Get Hosting First

If you don't have a website or hosting yet, Hostinger is the recommended option. It's affordable, reliable, and works well with the FTP deploy workflow Claude uses.

### Step 1 — Buy hosting

1. Go to **hostinger.com**
2. Choose **Premium Web Hosting** ($2.99-3.99/mo — the middle tier is fine)
3. Check the box to also register a domain name (e.g. `yournamegency.com`)
   - Good domain formula: `[yourname]insurance.com` or `[agencyname]life.com`
4. Complete checkout

### Step 2 — Set up your domain

After purchase, Hostinger walks you through connecting your domain automatically. Just follow their setup wizard — it takes about 5 minutes and no technical knowledge is needed.

### Step 3 — Skip to "Find Your FTP Credentials" below

---

## Already Have Hostinger — Find Your FTP Credentials

Claude deploys your website files using FTP (File Transfer Protocol). Think of it as a secure way to copy files from your computer to your website server.

You need 4 things:
1. FTP Host
2. FTP Username
3. FTP Password
4. Your domain name

### Where to find them

1. Log into **hpanel.hostinger.com**
2. Click **Hosting** in the top menu
3. Click **Manage** next to your domain
4. In the left sidebar, click **Files** → **FTP Accounts**
5. You'll see your FTP credentials listed there

The FTP host is usually: `ftp.yourdomain.com`
The username is usually: `u` followed by numbers (like `u123456789`)

> **Tip:** Write these down or save them in a secure note — you'll need them every time you want to update your site.

---

## Deploy Your Website With Claude

Once you have your FTP credentials, Claude can upload your files directly. Just say:

```
Deploy my website to Hostinger.
FTP Host: ftp.yourdomain.com
Username: [your username]
Password: [your password]
Domain: yourdomain.com
```

Claude will run this command for each file:
```bash
curl --ftp-pasv -T filename.html \
  ftp://ftp.yourdomain.com/domains/yourdomain.com/public_html/filename.html \
  --user username:password
```

### What files go where

All your website files go into:
```
/domains/yourdomain.com/public_html/
```

| File | Goes to |
|------|---------|
| `index.html` | `/public_html/index.html` |
| `style.css` | `/public_html/style.css` |
| `about.html` | `/public_html/about.html` |
| `images/photo.jpg` | `/public_html/images/photo.jpg` |

### Deploy one file vs. all files

**One file (most common — after making a change):**
```
Deploy index.html to my Hostinger site.
Host: ftp.yourdomain.com | User: [user] | Password: [password] | Domain: yourdomain.com
```

**All files at once (first time or major update):**
```
Deploy all my website files to Hostinger.
Host: ftp.yourdomain.com | User: [user] | Password: [password] | Domain: yourdomain.com
Files are in: ~/Documents/[your-site-folder]/
```

---

## Windows — Same Process, Different Command

The same FTP deploy works on Windows. Just ask Claude the same way — it handles the syntax automatically.

---

## After Deploying — Check Your Site

1. Open your browser and go to `yourdomain.com`
2. Hard refresh: **Cmd+Shift+R** (Mac) or **Ctrl+Shift+R** (Windows) to clear cache
3. If changes aren't showing, wait 1-2 minutes and try again

---

## Common Issues

**"Could not connect to FTP server"**
→ Double-check your FTP host — it's usually `ftp.yourdomain.com` not just `yourdomain.com`

**"Access denied" or "Permission denied"**
→ Check your username and password — copy-paste them rather than typing

**Site updated but browser shows old version**
→ Hard refresh: Cmd+Shift+R (Mac) or Ctrl+Shift+R (Windows)

**"No such file or directory"**
→ The path is wrong. Make sure it includes `/domains/yourdomain.com/public_html/`

---

## Security Note

Your FTP password is sensitive — treat it like a bank password. Never paste it into a public chat, social media, or email. Only share it with Claude in your private session.
