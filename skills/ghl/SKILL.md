---
name: ghl
description: GoHighLevel (GHL) CRM work — surveys, custom fields, contacts, workflows, and API calls for Wood Agency Life. Use when user asks to build, edit, or query anything in GHL/LeadConnector.
---

# GoHighLevel Skill

## Account Context

- **Location ID:** `MpDMPLkOAjXBtmXs5G6B`
- **API Base:** `https://services.leadconnectorhq.com`
- **API Version header:** `Version: 2021-07-28`
- **Auth:** Use `pit-*` private integration tokens from the user — never session JWTs

## Common Endpoints

| Resource | Method | Path |
|----------|--------|------|
| Custom Fields | GET | `/locations/{locationId}/customFields` |
| Custom Fields | POST | `/locations/{locationId}/customFields` |
| Surveys | GET | `/surveys/?locationId={locationId}` |
| Survey detail | GET | `/surveys/{surveyId}` |
| Contacts | GET | `/contacts/?locationId={locationId}` |
| Workflows | GET | `/workflows/?locationId={locationId}` |

## Workflow

1. Ask for the current `pit-*` token before any API call
2. Use `curl -s` piped to `python3 -m json.tool` for readable output
3. Always scope with `--stat` style checks before bulk operations
4. Confirm destructive changes (DELETE, bulk field edits) before executing

## Custom Fields in use

- `product_interest` — SINGLE_OPTIONS (Life Insurance, Mortgage Protection, IUL & Annuities, Debt Free Life, Infinite Banking, Final Expense Insurance, Not Sure)
- Additional fields created per survey build — query `/customFields` to get current list

## Notes

- Session JWTs (Bearer `eyJ...`) expire in ~1 hour — never save or reuse them
- `pit-*` tokens are durable — store in env or ask user to provide per session
- Survey slide logic uses `uuid` fields to map to custom fields
