# ============================================================
# Claude Code — Post-Install Verification (Windows)
# Run this to check that everything is set up correctly
# ============================================================
# How to run:
#   irm https://raw.githubusercontent.com/woodenman85/claude-config/main/onboarding/verify.ps1 | iex

$pass  = 0
$fail  = 0
$warn  = 0

function Check-Item {
    param($label, $result, $message = "")
    if ($result -eq "pass") {
        Write-Host "  " -NoNewline
        Write-Host "[PASS]" -ForegroundColor Green -NoNewline
        Write-Host " $label"
        $script:pass++
    } elseif ($result -eq "warn") {
        Write-Host "  " -NoNewline
        Write-Host "[WARN]" -ForegroundColor Yellow -NoNewline
        Write-Host " $label — $message"
        $script:warn++
    } else {
        Write-Host "  " -NoNewline
        Write-Host "[FAIL]" -ForegroundColor Red -NoNewline
        Write-Host " $label — $message"
        $script:fail++
    }
}

Write-Host ""
Write-Host "==============================================" -ForegroundColor Cyan
Write-Host "   Claude Code Setup Verification"
Write-Host "==============================================" -ForegroundColor Cyan
Write-Host ""

# ── Node.js ───────────────────────────────────────────────
Write-Host "Node.js"
try {
    $nodeVer = (node -v 2>$null)
    if (-not $nodeVer) { throw }
    $nodeMajor = [int]($nodeVer -replace 'v(\d+)\..*','$1')
    if ($nodeMajor -ge 18) {
        Check-Item "Node.js $nodeVer" "pass"
    } else {
        Check-Item "Node.js $nodeVer" "fail" "need v18 or newer — get LTS at https://nodejs.org"
    }
} catch {
    Check-Item "Node.js" "fail" "not installed — get it at https://nodejs.org"
}

try {
    $null = (npx --version 2>$null)
    Check-Item "npx available" "pass"
} catch {
    Check-Item "npx available" "fail" "install Node.js to get npx"
}

Write-Host ""

# ── Claude config ─────────────────────────────────────────
Write-Host "Claude Config"
$configPath = "$env:APPDATA\Claude\claude_desktop_config.json"

if (Test-Path $configPath) {
    Check-Item "Claude desktop config exists" "pass"
    try {
        $config = Get-Content -Raw $configPath | ConvertFrom-Json
        if ($config.mcpServers) {
            Check-Item "MCP servers block present" "pass"
        } else {
            Check-Item "MCP servers block present" "fail" "run setup.ps1 again"
        }
        foreach ($server in @("ghl","context7","magic")) {
            if ($config.mcpServers.$server) {
                Check-Item "  $server MCP configured" "pass"
            } else {
                if ($server -eq "magic") {
                    Check-Item "  magic MCP configured" "warn" "optional — add a 21st.dev key to enable"
                } else {
                    Check-Item "  $server MCP configured" "fail" "run setup.ps1 again"
                }
            }
        }
    } catch {
        Check-Item "Config file is valid JSON" "fail" "file may be corrupted — run setup.ps1 again"
    }
} else {
    Check-Item "Claude desktop config exists" "fail" "Claude desktop app not installed — get it at https://claude.ai/download"
}

Write-Host ""

# ── CLAUDE.md ─────────────────────────────────────────────
Write-Host "Claude Context Files"
$claudeMdPath = "$env:USERPROFILE\.claude\CLAUDE.md"

if (Test-Path $claudeMdPath) {
    Check-Item "~/.claude/CLAUDE.md exists" "pass"
    $claudeMdContent = Get-Content -Raw $claudeMdPath
    if ($claudeMdContent -match "pit-") {
        Check-Item "  GHL token present" "pass"
    } else {
        Check-Item "  GHL token present" "warn" "no pit- token found — run setup.ps1 to add it"
    }
    if ($claudeMdContent -match "Location ID|GHL_LOCATION|MpDMPLk") {
        Check-Item "  GHL Location ID present" "pass"
    } else {
        Check-Item "  GHL Location ID present" "warn" "run setup.ps1 to add it"
    }
} else {
    Check-Item "~/.claude/CLAUDE.md exists" "fail" "run setup.ps1 to create it"
}

Write-Host ""

# ── Skills ────────────────────────────────────────────────
Write-Host "Skills"
$skillList = @("ghl","design","website","gmail","calendar","canva","daily-briefing","lead-nurture","compliance","sms")
foreach ($skill in $skillList) {
    $skillPath = "$env:USERPROFILE\.claude\skills\$skill\SKILL.md"
    if (Test-Path $skillPath) {
        Check-Item "  $skill skill" "pass"
    } else {
        Check-Item "  $skill skill" "fail" "run setup.ps1 to install it"
    }
}

Write-Host ""

# ── Git ───────────────────────────────────────────────────
Write-Host "Git"
try {
    $null = git --version 2>$null
    $gitName  = (git config --global user.name  2>$null)
    $gitEmail = (git config --global user.email 2>$null)
    if ($gitName)  { Check-Item "Git name: $gitName"   "pass" }
    else           { Check-Item "Git name"              "warn" "not set — run: git config --global user.name 'Your Name'" }
    if ($gitEmail) { Check-Item "Git email: $gitEmail" "pass" }
    else           { Check-Item "Git email"             "warn" "not set — run: git config --global user.email 'you@email.com'" }
} catch {
    Check-Item "Git" "warn" "not installed (optional)"
}

Write-Host ""

# ── Summary ───────────────────────────────────────────────
$total = $pass + $fail + $warn
Write-Host "==============================================" -ForegroundColor Cyan
Write-Host "  " -NoNewline
Write-Host "$pass passed" -ForegroundColor Green -NoNewline
Write-Host "  |  " -NoNewline
Write-Host "$warn warnings" -ForegroundColor Yellow -NoNewline
Write-Host "  |  " -NoNewline
Write-Host "$fail failed" -ForegroundColor Red -NoNewline
Write-Host "  (of $total checks)"
Write-Host "==============================================" -ForegroundColor Cyan
Write-Host ""

if ($fail -gt 0) {
    Write-Host "Action needed: " -ForegroundColor Red -NoNewline
    Write-Host "Fix the items marked [FAIL] above."
    Write-Host "See TROUBLESHOOTING_WINDOWS.md for step-by-step fixes."
} elseif ($warn -gt 0) {
    Write-Host "Almost there! " -ForegroundColor Yellow -NoNewline
    Write-Host "A few optional items need attention (see [WARN] above)."
} else {
    Write-Host "Everything looks great! " -ForegroundColor Green -NoNewline
    Write-Host "You're all set up."
    Write-Host ""
    Write-Host "Next: ask Claude to pull your daily briefing:"
    Write-Host '  "Good morning. Pull my daily briefing."'
}
Write-Host ""
