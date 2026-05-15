---
name: sms
description: Draft text messages to leads and clients — follow-ups, appointment reminders, check-ins. Use when asked to write a text, SMS, or quick message to a prospect or client.
---

# SMS Skill

## The rules of insurance texting
- Keep it under 160 characters when possible
- Sound human — not like a bot
- One clear ask per text
- Never include policy details or rates in a text
- Always identify yourself by name on first text
- Check state TCPA rules — get opt-in consent before texting

## Text templates by situation

### First contact after form fill
```
Hey [name], this is [agent] with [agency]. Saw you had questions about [product] — happy to help! When's a good time to connect? 📞
```

### Follow-up after no response (Day 3)
```
Hey [name] — [agent] again. Just want to make sure I didn't miss you. Still happy to answer any questions about [product]. 🙂
```

### Appointment reminder (24hr before)
```
Hey [name]! Quick reminder — we're chatting tomorrow at [time] about [product]. Looking forward to it! Reply if anything changes.
```

### After appointment (same day)
```
Great talking with you today [name]! I'll get that info over to you shortly. Any questions, just text or call me anytime.
```

### Re-engagement (cold lead, 2+ weeks)
```
Hey [name] — [agent] here. Wanted to check in and see if you ever got the [product] info you were looking for. No pressure, just here if you need anything!
```

### Referral ask
```
Hey [name]! Hope everything's great. If you know anyone who could use [product], I'd love to help them too. I take good care of referrals! 🙏
```

## GHL integration
- Use `send_sms` tool to send directly from GHL
- Always check contact record first for opt-in status
- Log all texts as notes in GHL contact record
