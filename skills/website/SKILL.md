---
name: website
description: Edit and deploy websites via FTP. Use for HTML/CSS/JS edits and pushing changes live.
---

# Website Skill

## Workflow
1. Make edits in the local website folder
2. Preview with kapture screenshot
3. Deploy only changed files via FTP

## Deploy template
```bash
curl --ftp-pasv -T <file> ftp://<host>/domains/<domain>/public_html/<file> \
  --user <username>:<password>
```

## Best practices
- Always preview before deploying
- Deploy one file at a time
- Never edit directly on the server
