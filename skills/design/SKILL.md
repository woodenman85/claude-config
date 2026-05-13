---
name: design
description: Build beautiful, professional websites. Use when asked to create, redesign, or improve any website UI — landing pages, sections, components, or full sites.
---

# Design Skill

## Tools available
- **Magic MCP** (`@21st-dev/magic`) — generates polished UI components from a description. Use it like: "Create a hero section for an insurance agency"
- **Context7 MCP** — pulls current docs for any framework (Tailwind, Next.js, etc.) so code is always accurate. Add `use context7` to any prompt using a library.
- **Kapture** — screenshot and inspect the live site to see what needs improving

## Design principles for Wood Agency sites
- **Trust first** — insurance is a trust business. Clean, professional, not flashy
- **Mobile-first** — most leads come from phones
- **Clear CTAs** — every page needs one obvious next step (book a call, get a quote)
- **Fast** — no heavy frameworks unless needed. HTML/CSS/vanilla JS preferred for simple sites

## Workflow for improving a page
1. Screenshot the current page with kapture
2. Identify the weakest element (hero, CTA, trust signals, layout)
3. Use Magic MCP to generate a better version: `/magic create a [component] for [context]`
4. Preview in browser, iterate
5. Deploy via FTP when approved

## Prompts that work well with Magic MCP
- "Create a hero section for a life insurance agency. Professional, trust-building, with a clear CTA to book a call"
- "Build a product card for mortgage protection insurance. Include key benefits and a button"
- "Design a testimonial section. Clean, modern, mobile-friendly"
- "Create a sticky navigation bar for an insurance agency website"

## Stack for woodagencylife.com
- Plain HTML/CSS/JS — no build step needed
- Tailwind CDN for utility classes if needed
- Deploy: FTP to Hostinger at `191.101.13.254`, path `/domains/woodagencylife.com/public_html/`
