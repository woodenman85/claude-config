---
name: site-builder
description: Step-by-step guided workflow for building a complete insurance agency website from scratch. Use when someone says "build my website", "help me make a site", "I need a new website", or "redesign my site". Walks through every phase in plain English — no coding knowledge required.
---

# Site Builder — Complete Website Workflow

You don't need to know how to code. Just answer the questions and Claude handles the rest.

---

## Phase 1 — Plan (5 minutes)

Before touching any code, answer these questions:

1. **What's your agency name and tagline?**
2. **What city/state do you serve?** (used for SEO)
3. **What products do you offer?** (life, mortgage protection, final expense, IUL, annuities, debt-free life)
4. **What's your #1 goal for the site?** (book calls, get quote requests, build trust)
5. **Do you have a logo?** (yes/no — Claude can help if not)
6. **What's your color preference?** (or describe a vibe: "professional navy", "warm and friendly", "clean and modern")
7. **Do you have your headshot ready?** (strongly recommended — people buy from people)

**Prompt to start:**
```
Help me build my insurance agency website from scratch. 
My name is [Name], I'm with [Agency] in [City, State].
I sell [products]. My phone is [number] and email is [email].
I want the site to [goal]. My color preference is [colors].
```

---

## Phase 2 — Structure (what pages to build)

### Minimum viable site (start here)
- **Homepage** — who you are, what you do, why choose you, CTA to book a call
- **Contact page** — form, phone, email, your photo

### Add these next
- **Life Insurance page** — what it is, who needs it, how you help
- **About page** — your story, why you got into insurance, who you serve
- **Services page** — overview of all products with links

### Nice to have later
- Individual pages for: Mortgage Protection, Final Expense, IUL, Annuities
- Blog (1 post/month minimum)
- Testimonials page

---

## Phase 3 — Build the homepage

### Step 1 — Generate the hero section
```
Build me a homepage hero section for my insurance agency.
Agency: [name] | City: [city, state] | Phone: [number]
Headline: "Life Insurance That Actually Fits."
Sub: "We help [city] families get the right coverage — without the confusion."
CTA button: "Book My Free Call"
Colors: [your colors]
Style: professional, clean, trust-building, mobile-first
```

### Step 2 — Add trust signals
```
Add a trust bar below the hero with:
- Licensed in [state] since [year]
- [X]+ families protected
- ⭐⭐⭐⭐⭐ Google Reviews
- No pressure, no spam
```

### Step 3 — Add your services section
```
Build a services grid showing these products with icons:
[list your products]
Each card: icon, name, 1-sentence description, "Learn More" button
Style: clean cards, [your colors], hover effect
```

### Step 4 — Add your about/trust section
```
Build a "Why Choose Us" section with these 3 points:
1. Protection First — [your description]
2. No Pressure — [your description]  
3. Direct Access — [your description]
Include my photo on the left, text on the right (swap on mobile)
```

### Step 5 — Add a contact/CTA section
```
Build a full-width CTA section at the bottom of the page:
Headline: "Ready to Protect Your Family?"
Sub: "Book a free 15-minute call. No obligation, no pressure."
Button: "Book My Free Call" → links to [your calendar link]
Include phone number and email as secondary options
```

---

## Phase 4 — Review and fix

### Take a screenshot
```
Take a screenshot of my homepage and tell me:
1. What's the weakest part visually?
2. Is the CTA clear and prominent?
3. How does it look on mobile?
4. What would you change first?
```

### Test the lead form
```
Open my website and fill out the contact form as a test lead named "Test User" with phone 555-555-5555. 
Tell me if the form submits correctly and what happens after.
```

### Check mobile
```
Take a screenshot of my homepage at mobile width (390px) and tell me if anything is broken or hard to read.
```

---

## Phase 5 — SEO basics

### Add page titles and meta descriptions
```
Write SEO-optimized title tags and meta descriptions for every page on my site.
My agency: [name] | City: [city, state] | Products: [list]
Target keywords: "life insurance agent [city]", "mortgage protection [city]"
```

### Add schema markup
```
Add InsuranceAgency schema markup to my homepage.
Agency name: [name] | Phone: [number] | Address: [address] | City: [city] | State: [state]
```

### Set up Google Analytics
```
Add Google Analytics 4 tracking to my site. My measurement ID is: G-XXXXXXXXXX
Also add phone click tracking to my phone number link.
```

---

## Phase 6 — Deploy

### Preview before pushing
```
Take a screenshot of [page] before I deploy it.
```

### Deploy to Hostinger via FTP
```
Deploy [filename] to my Hostinger site.
FTP host: [host] | Username: [user] | Password: [password] | Path: /domains/[domain]/public_html/
```

---

## Quick prompts for common tasks

**"Make it look more professional"**
```
Screenshot my homepage and redesign the hero section to look more professional and trustworthy. 
Keep the same content but improve the typography, spacing, and visual hierarchy.
```

**"I don't like the colors"**
```
Change my site's color scheme to [description]. 
Update the CSS variables and show me a preview before I approve.
```

**"Add a testimonial"**
```
Add a testimonials section to my homepage with these reviews:
[paste 2-3 real Google reviews]
Style: clean cards with quote marks, star rating, client first name only
```

**"My site looks bad on phone"**
```
Screenshot my site at 390px width. Fix anything that's broken, 
hard to read, or hard to tap. Prioritize: text size, button size, navigation.
```

**"I need a landing page for Facebook ads"**
```
Build a simple landing page for Facebook ads about [product] in [city].
No navigation menu. Single focus: [offer, e.g. "free life insurance quote"].
Form: name, phone, email only. Above the fold CTA. 
Mobile-first. Deploy separately from my main site.
```
