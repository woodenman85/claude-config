---
name: analytics
description: Read and act on website analytics for insurance agency sites. Use when asked to interpret Google Analytics, find which pages are getting traffic, understand bounce rates, or set up conversion tracking.
---

# Analytics Skill — Insurance Agency Website Analytics

## What to track (the only metrics that matter)

| Metric | What it tells you | Good benchmark |
|--------|------------------|----------------|
| **Form submissions** | Leads generated | Goal: track every one |
| **Phone clicks** | Mobile leads | Goal: track every one |
| **Conversion rate** | Visitors → leads | 2-5% is solid for insurance |
| **Traffic source** | Where visitors come from | Organic = free, Paid = paid |
| **Top pages** | What content works | Focus resources here |
| **Bounce rate** | Visitors who leave instantly | Under 70% is okay |

## Setting up Google Analytics 4 (GA4)

### Install the tracking code
Add this to every page, inside the `<head>` tag:
```html
<!-- Google tag (gtag.js) -->
<script async src="https://www.googletagmanager.com/gtag/js?id=G-XXXXXXXXXX"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());
  gtag('config', 'G-XXXXXXXXXX');
</script>
```
Replace `G-XXXXXXXXXX` with your actual Measurement ID from GA4.

### Track form submissions (conversions)
Add to your contact form's success/thank-you page, or on form submit:
```html
<script>
  gtag('event', 'generate_lead', {
    'event_category': 'form',
    'event_label': 'Contact Form'
  });
</script>
```

### Track phone number clicks
Add to your phone number link:
```html
<a href="tel:+1XXXXXXXXXX" 
   onclick="gtag('event','click',{'event_category':'phone','event_label':'Header Phone'})">
  (XXX) XXX-XXXX
</a>
```

## Reading your analytics — what to look for

### Every month, check:
1. **How many leads did the site generate?** (Form submissions + phone clicks)
2. **Which pages get the most traffic?** (Double down on those)
3. **Which pages have high bounce rates?** (Fix those)
4. **Where is traffic coming from?** (Google organic, direct, social, paid)

### Traffic sources decoded:
- **Organic Search** — people found you on Google (best, free, sustainable)
- **Direct** — typed your URL or bookmarked you (existing clients)
- **Social** — came from Facebook/Instagram (great if you're posting)
- **Referral** — another website linked to you
- **Paid Search** — Google Ads (only valuable with good landing pages)

### Red flags to fix immediately:
- Homepage bounce rate over 80% → headline or load speed problem
- Zero conversions in a month → form is broken or CTA is missing
- 95%+ mobile traffic but site not mobile-friendly → fix this today
- Average session under 30 seconds → page isn't loading or content isn't relevant

## Google Search Console — free SEO data

Different from Analytics. Shows you:
- **What search terms** people use to find your site
- **Your ranking position** for those terms
- **Which pages** Google has indexed

Set it up at: search.google.com/search-console

Key report: **Performance → Queries** — shows you every search term that brought someone to your site. Sort by impressions to find opportunities.

## What to ask Claude
- "Here's my GA4 data [paste screenshot or numbers] — what should I focus on?"
- "Add Google Analytics tracking code to my website — my ID is G-XXXXXXXXXX"
- "Set up conversion tracking for my contact form"
- "Make my phone number trackable in Google Analytics"
- "I'm getting 500 visitors/month but zero leads — what's wrong?"
- "Set up Google Search Console for my site and tell me what to look for"
