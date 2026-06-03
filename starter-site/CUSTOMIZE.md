# How to Customize Your Starter Site

You have a working insurance agency website. This file tells you exactly what to change to make it yours. No coding knowledge needed — just find the text and replace it.

---

## Step 1 — Find and replace your info throughout the file

Open `index.html` in a text editor (TextEdit on Mac, Notepad on Windows).

Use **Find & Replace** (Cmd+H on Mac, Ctrl+H on Windows) to replace:

| Find this | Replace with |
|-----------|-------------|
| `Your Agency Name` | Your real agency name |
| `Your Name` | Your name |
| `Your City, State` | Your city and state |
| `YOUR-PHONE-NUMBER` | Your phone number (format: 9285550100) |
| `(XXX) XXX-XXXX` | Your phone number (display format) |
| `your@email.com` | Your email address |
| `yourwebsite.com` | Your actual domain |
| `2025` | Current year |
| `License #XXXXXXXX` | Your insurance license number |

---

## Step 2 — Add your photo

1. Put your headshot or team photo in the `images/` folder
2. Name it `your-photo.jpg` (or whatever you want)
3. In `index.html`, find this section:

```html
<!-- CUSTOMIZE: Replace with your photo -->
<div class="about-img-placeholder">
  <p>📷 Add your photo here</p>
</div>
```

4. Delete the placeholder div and replace with:

```html
<img src="images/your-photo.jpg"
     alt="Your Name — Your Agency Name"
     class="about-img"
     loading="lazy">
```

---

## Step 3 — Write your story

Find the `<!-- CUSTOMIZE: Your story -->` comment in the About section and replace the placeholder text with your real story. Keep it personal — why did you get into insurance? What drives you?

---

## Step 4 — Add real testimonials

Find the testimonials section and replace the placeholder reviews with real ones from your Google Business Profile.

To get your Google review link:
1. Search your business name on Google
2. Click "Reviews"
3. Click "Get more reviews"
4. Copy the link

---

## Step 5 — Connect your contact form

The form currently shows an alert when submitted. To actually receive leads, connect it to one of these (all free tiers available):

**Option A — Formspree (easiest):**
1. Go to formspree.io and create a free account
2. Create a new form
3. Replace the form tag with: `<form action="https://formspree.io/f/YOUR-ID" method="POST">`
4. Remove the JavaScript submit handler at the bottom

**Option B — Your GHL form embed:**
1. In GHL, go to Sites → Forms
2. Create or copy a form
3. Get the embed code
4. Replace the entire `<form>` block with the GHL embed

**Option C — EmailJS (sends directly to your email):**
1. Go to emailjs.com
2. Follow their setup guide
3. Update the form submission JavaScript

---

## Step 6 — Change colors (optional)

At the top of the CSS, find the `:root` section:

```css
:root {
  --gold:    #C9A84C;  ← Change this to your accent color
  --bg-deep: #080808;  ← Change this to your background color
}
```

Not sure what colors to use? Ask Claude:
> "Suggest 3 color schemes for a professional insurance agency website. Give me the hex codes."

---

## Step 7 — Deploy to Hostinger

See `HOSTING_GUIDE.md` for full instructions. The short version:

```
Deploy my website to Hostinger.
FTP Host: ftp.yourdomain.com
Username: [your username]
Password: [your password]
Domain: yourdomain.com
File: index.html
```

---

## Quick customizations you can ask Claude to do

```
"Rewrite the hero headline and paragraph for my [city] insurance agency.
Focus on [product]. Keep it under 30 words for the headline."
```

```
"Write an About section story for an insurance agent named [name] in [city]
who [your background]. Personal, warm, 3 short paragraphs."
```

```
"Change the color scheme of my website from gold/black to [your color preference].
Update all the CSS variables."
```

```
"Add a fourth testimonial card to my testimonials section with this review: [paste review]"
```
