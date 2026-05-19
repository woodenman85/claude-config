---
name: seo
description: Optimize insurance agency websites for local search. Use when asked to improve SEO, write meta tags, set up schema markup, audit page titles, or improve Google rankings.
---

# SEO Skill — Insurance Agency Local Search

## The goal
Insurance agents need to show up when someone in their city searches "life insurance agent near me" or "mortgage protection [city]". Local SEO is the highest-leverage activity.

## Quick wins (do these first)

### Page titles — the #1 ranking factor
Formula: `[Service] | [City] | [Agency Name]`
Examples:
- `Life Insurance Agent | Phoenix, AZ | Wood Agency Life`
- `Mortgage Protection Insurance | Scottsdale | Wood Agency Life`
- Keep under 60 characters

### Meta descriptions — drives click-through rate
Formula: `[Benefit] + [City] + [CTA]`
Example: `Protect your family with affordable life insurance in Phoenix. Get a free quote in minutes. Call today.`
- Keep under 155 characters
- Include city name
- End with a CTA

### H1 headline — one per page, matches intent
- Homepage: `Life Insurance Agent in [City], [State]`
- Service page: `Affordable Mortgage Protection Insurance in [City]`

## Local SEO checklist

### Google Business Profile (most important)
- [ ] Claim your Google Business Profile at business.google.com
- [ ] Category: "Insurance Agency" or "Life Insurance Agency"
- [ ] Add all services (life, mortgage protection, final expense, IUL, annuities)
- [ ] Upload photos (headshot, office, team)
- [ ] Post weekly updates (Claude can draft these)
- [ ] Respond to every review

### On-page SEO
- [ ] Every page has a unique title tag with city name
- [ ] Every page has a meta description
- [ ] H1 includes the target keyword + city
- [ ] NAP (Name, Address, Phone) consistent everywhere
- [ ] Phone number is clickable (tel: link) on mobile

### Schema markup (add to every page)
```html
<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "InsuranceAgency",
  "name": "[Agency Name]",
  "telephone": "[Phone]",
  "address": {
    "@type": "PostalAddress",
    "streetAddress": "[Street]",
    "addressLocality": "[City]",
    "addressRegion": "[State]",
    "postalCode": "[ZIP]"
  },
  "url": "[Website URL]",
  "openingHours": "Mo-Fr 09:00-17:00",
  "priceRange": "Free consultation"
}
</script>
```

### Content strategy
- One page per product + city (if serving multiple cities)
- FAQ section on each page (Google loves Q&A)
- Blog: 1 post/month minimum — "How much life insurance do I need in [City]?"

## What to ask Claude
- "Write SEO-optimized title tags and meta descriptions for my homepage and life insurance page"
- "Add schema markup to my insurance agency website"
- "Write an FAQ section for my mortgage protection page for [city]"
- "Audit my page titles — here's my site: [URL]"
- "Draft a Google Business Profile post about [topic]"
