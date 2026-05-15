---
name: daily-briefing
description: Start the day with a full business briefing. Pulls GHL pipeline, calendar, Gmail, and suggests priority actions. Use when user says "good morning", "start my day", "what should I focus on", or "daily briefing".
---

# Daily Briefing Skill

Run this every morning. Pulls live data from all connected tools and gives a prioritized action plan.

## What to pull (run all in parallel)

1. **GHL** — search_contacts (added last 7 days), search_opportunities (open deals by stage)
2. **Calendar** — list_events (today + tomorrow)
3. **Gmail** — search_threads (unread, last 48hrs, label:lead OR insurance)

## Output format

```
🌅 Good morning [name] — here's your day

📋 PIPELINE SNAPSHOT
- X new leads this week
- X open opportunities
- Who's been sitting too long without contact (flag anyone >3 days no touch)

📅 TODAY'S CALENDAR
- [list events with times]
- Any conflicts or back-to-backs to flag

📧 INBOX NEEDS ATTENTION
- [unread threads that look like leads or need reply]

🎯 TOP 3 PRIORITIES FOR TODAY
1. [Most urgent action]
2. [Second priority]
3. [Third priority]

💡 ONE THING
[One specific thing they should do in the next 30 minutes]
```

## Rules
- Keep it tight — no fluff, no filler
- Prioritize revenue actions (leads, appointments, follow-ups) above admin
- Flag anything that's falling through the cracks
- Always end with ONE specific action to do right now
