#!/bin/bash
# ============================================================
# Claude Code — Post-Install Verification
# Run this to check that everything is set up correctly
# ============================================================

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

PASS=0
FAIL=0
WARN=0

check() {
  local label="$1"
  local result="$2"  # "pass", "fail", or "warn"
  local message="$3"

  if [ "$result" = "pass" ]; then
    echo -e "  ${GREEN}✓${NC} $label"
    PASS=$((PASS+1))
  elif [ "$result" = "warn" ]; then
    echo -e "  ${YELLOW}⚠${NC}  $label — $message"
    WARN=$((WARN+1))
  else
    echo -e "  ${RED}✗${NC} $label — $message"
    FAIL=$((FAIL+1))
  fi
}

echo ""
echo "=============================================="
echo "   Claude Code Setup Verification"
echo "=============================================="
echo ""

# ── Node.js ───────────────────────────────────────────────
echo "Node.js"
if command -v node &> /dev/null; then
  NODE_VER=$(node -v)
  NODE_MAJOR=$(echo "$NODE_VER" | cut -d'v' -f2 | cut -d'.' -f1)
  if [ "$NODE_MAJOR" -ge 18 ]; then
    check "Node.js $NODE_VER" "pass"
  else
    check "Node.js $NODE_VER" "fail" "need v18 or newer — get LTS at https://nodejs.org"
  fi
else
  check "Node.js" "fail" "not installed — get it at https://nodejs.org"
fi

if command -v npx &> /dev/null; then
  check "npx available" "pass"
else
  check "npx available" "fail" "install Node.js to get npx"
fi

echo ""

# ── Claude config ─────────────────────────────────────────
echo "Claude Config"

DESKTOP_CONFIG="$HOME/Library/Application Support/Claude/claude_desktop_config.json"
if [ -f "$DESKTOP_CONFIG" ]; then
  check "Claude desktop config exists" "pass"

  if python3 -c "import json; d=json.load(open('$DESKTOP_CONFIG')); assert 'mcpServers' in d" 2>/dev/null; then
    check "MCP servers block present" "pass"
  else
    check "MCP servers block present" "fail" "run setup.sh again"
  fi

  for server in ghl context7 magic; do
    if python3 -c "import json; d=json.load(open('$DESKTOP_CONFIG')); assert '$server' in d.get('mcpServers', {})" 2>/dev/null; then
      check "  $server MCP configured" "pass"
    else
      if [ "$server" = "magic" ]; then
        check "  magic MCP configured" "warn" "optional — add a 21st.dev key to enable"
      else
        check "  $server MCP configured" "fail" "run setup.sh again"
      fi
    fi
  done
else
  check "Claude desktop config exists" "fail" "Claude desktop app not installed — get it at https://claude.ai/download"
fi

echo ""

# ── CLAUDE.md ─────────────────────────────────────────────
echo "Claude Context Files"

if [ -f "$HOME/.claude/CLAUDE.md" ]; then
  check "~/.claude/CLAUDE.md exists" "pass"
  if grep -q "pit-" "$HOME/.claude/CLAUDE.md" 2>/dev/null; then
    check "  GHL token present" "pass"
  else
    check "  GHL token present" "warn" "no pit- token found — run setup.sh to add it"
  fi
  if grep -q "Location ID" "$HOME/.claude/CLAUDE.md" 2>/dev/null; then
    check "  GHL Location ID present" "pass"
  else
    check "  GHL Location ID present" "warn" "run setup.sh to add it"
  fi
else
  check "~/.claude/CLAUDE.md exists" "fail" "run setup.sh to create it"
fi

echo ""

# ── Skills ────────────────────────────────────────────────
echo "Skills"
for skill in ghl design website gmail calendar canva daily-briefing lead-nurture compliance sms; do
  if [ -f "$HOME/.claude/skills/$skill/SKILL.md" ]; then
    check "  $skill skill" "pass"
  else
    check "  $skill skill" "fail" "run setup.sh to install it"
  fi
fi

echo ""

# ── Git ───────────────────────────────────────────────────
echo "Git"
if command -v git &> /dev/null; then
  GIT_NAME=$(git config --global user.name 2>/dev/null)
  GIT_EMAIL=$(git config --global user.email 2>/dev/null)
  if [ -n "$GIT_NAME" ]; then
    check "Git name: $GIT_NAME" "pass"
  else
    check "Git name" "warn" "not set — run: git config --global user.name 'Your Name'"
  fi
  if [ -n "$GIT_EMAIL" ]; then
    check "Git email: $GIT_EMAIL" "pass"
  else
    check "Git email" "warn" "not set — run: git config --global user.email 'you@email.com'"
  fi
else
  check "Git" "warn" "not installed (optional)"
fi

echo ""

# ── Summary ───────────────────────────────────────────────
echo "=============================================="
TOTAL=$((PASS+FAIL+WARN))
echo -e "  ${GREEN}$PASS passed${NC}  |  ${YELLOW}$WARN warnings${NC}  |  ${RED}$FAIL failed${NC}  (of $TOTAL checks)"
echo "=============================================="
echo ""

if [ "$FAIL" -gt 0 ]; then
  echo -e "${RED}Action needed:${NC} Fix the items marked ✗ above."
  echo "See TROUBLESHOOTING.md for step-by-step fixes."
  echo ""
elif [ "$WARN" -gt 0 ]; then
  echo -e "${YELLOW}Almost there!${NC} A few optional items need attention (see ⚠ above)."
  echo ""
else
  echo -e "${GREEN}Everything looks great!${NC} You're all set up."
  echo ""
  echo "Next: ask Claude to pull your daily briefing:"
  echo "  \"Good morning. Pull my daily briefing.\""
  echo ""
fi
