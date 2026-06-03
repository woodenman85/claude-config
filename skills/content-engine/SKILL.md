---
name: content-engine
description: Full content production workflow for Ben Wood / The Wood Agency. Use when asked to create content, write a post, build a content batch, or plan a content week. Pulls from story bank, checks brand voice, and can publish directly via GHL.
---

# Content Engine — The Wood Agency

## Before writing anything, read:
1. Brand voice rules in CLAUDE.md
2. Story bank at `~/.claude/story-bank.md` — find a real story that fits
3. Run compliance check on anything that mentions rates, taxes, or guarantees

---

## The anti-slop rule
Every piece of content needs ONE of these to anchor it:
- A specific story (real, anonymized if needed)
- A surprising statistic (researched, not made up)
- A counterintuitive insight ("your employer's life insurance isn't protecting you — it's protecting them")
- A specific scenario the reader recognizes

If the content has none of these — it's slop. Rewrite.

---

## Content formats and when to use each

| Format | Platform | Best for | Time to create |
|--------|----------|----------|---------------|
| Short story post | Facebook | Trust, warmth, shares | 15 min |
| Educational carousel | Instagram | Saves, reach, authority | 20 min |
| Reel script | Instagram/Facebook | Reach, personality | 10 min |
| Email newsletter | GHL → email list | Nurturing leads, conversions | 20 min |
| Blog post | Website | SEO, long-term traffic | 45 min |
| Google Business post | Google | Local SEO, trust | 5 min |

---

## The content workflow (use this every time)

### Step 1 — Topic brief
Before drafting, answer:
- What's the ONE thing this content is about?
- Who specifically is it for? (young families? denied buyers? new homeowners?)
- What do I want them to feel? (understood, educated, urgency, trust)
- What do I want them to DO? (book a call, share this, save it)
- Which story from the story bank fits?

### Step 2 — Draft with constraints
Tell Claude:
```
Write a [format] about [topic] for [specific audience].
Hook: [specific angle or story]
Voice: direct, warm, no jargon, personal
CTA: [one specific action]
Pull from my story bank if relevant.
Max length: [word count]
```

### Step 3 — Quality check
Before approving, ask:
- Does the first line stop a scroll? (test: would YOU keep reading?)
- Is there a specific detail that makes it feel real?
- Does it sound like Ben or like a template?
- Is the CTA clear and singular?

### Step 4 — Compliance check
For any claim about rates, taxes, guarantees, or returns:
```
Check this content for compliance before I publish it: [paste content]
```

### Step 5 — Design (pick one approach)

**Option A — AI photo via Higgsfield (best for lifestyle images):**
```
Generate an image for this social post.
Scene: [describe — e.g. "a warm family at home feeling secure and peaceful"]
Style: professional, warm lighting, authentic (not stock-photo fake)
Model: marketing_studio_image
Format: square for Instagram, landscape for Facebook
```

**Option B — Canva graphic (best for carousels, quote cards, data):**
```
Create a Canva graphic for this post.
Style: dark background, gold accent, clean typography
Text overlay: [key quote from post]
Format: [Instagram square / Facebook landscape / Story vertical]
```

**Option C — Use a real photo of Ben/Andrea (highest performing):**
Real photos consistently outperform AI and stock. 
If you have a photo that fits, use it over any generated image.

### Step 6 — Publish via GHL
Post directly to social from Claude:
```
Create a social media post in GHL with this content:
[paste caption]
Schedule for: [date and time]
Platform: [Facebook / Instagram]
```

---

## Weekly content batch (do this Monday morning)

Produce the whole week in one session:

```
Create my content batch for this week.
Read my story bank first.
Products to feature: [pick 1-2 this week]
Audience focus: [new homebuyers / families with kids / denied buyers / etc.]
Formats needed:
- 3 Facebook posts (Mon/Wed/Fri)
- 2 Instagram carousels
- 1 email for my GHL list
Tone: direct, warm, story-first
Run each through my brand voice rules before showing me.
```

---

## Content types that consistently perform for insurance agents

### High engagement
- "I turned down a client today" (counterintuitive story)
- "The call I dread most" (emotional, after a claim)
- "Your employer told you something that isn't true" (myth-busting)
- "A client texted me this morning" (real moment)

### High save/share
- "5 things your life insurance agent won't tell you"
- "What actually happens to your mortgage if you die"
- "How to figure out if you're underinsured (takes 2 minutes)"
- "The difference between term and whole life in plain English"

### High conversion
- "I have 3 spots open this week" (scarcity + soft CTA)
- "Free 15-minute call this week — here's what we cover" (specific offer)
- "If you've been denied before, read this" (direct to pain point)

---

## Publish directly via GHL — how to do it

**See your connected social accounts:**
```
Show me my connected social accounts in GHL
```

**Create and schedule a post:**
```
Create a social post in GHL:
Caption: [paste your caption]
Platform: Facebook
Schedule: [tomorrow at 10am] OR [post now]
```

**See what's already scheduled:**
```
Search my scheduled GHL social posts for this week
```

**Send an email to my GHL list:**
```
Send an email to my GHL contacts tagged as [tag].
Subject: [subject line]
Body: [paste email content]
```

---

## The content I prioritize (in order)

1. **Email to existing leads** — highest ROI, already warm
2. **Facebook** — where my age bracket of clients actually is
3. **Instagram** — for reaching younger buyers and referral sources
4. **Google Business posts** — underrated, helps local SEO
5. **Blog posts** — slow burn, long-term SEO value

---

## What I never do

- Post the same content on every platform without adapting the format
- Write content that could've been written by any insurance agent anywhere
- Use stock photos of smiling families — use real photos of Ben and Andrea
- Post without a CTA
- Publish anything rate-specific without a compliance check
