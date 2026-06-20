#!/bin/bash
# Nemesis Briefing Script — generates a complete project status dump.
# Run this and paste the output to ANY AI to instantly bring them up to speed.
# Usage:  ./brief.sh           (prints to terminal)
#         ./brief.sh | pbcopy  (copies to clipboard on macOS — then paste to AI)

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$REPO_ROOT"

cat <<EOF
================================================================================
NEMESIS PROJECT BRIEFING — generated $(date +%Y-%m-%d\ %H:%M)
================================================================================

You are continuing work on the Nemesis Roblox UI library. Multiple AIs share
this project. Read this briefing, then NEMESIS.md, then PROJECT_MEMORY.txt
for deep context.

--------------------------------------------------------------------------------
REPO STATE
--------------------------------------------------------------------------------
Branch:        $(git branch --show-current)
Last commit:   $(git log -1 --pretty='%h — %s')
Last AI:       $(git log -1 --pretty=%b | grep -i "Co-Authored-By" | head -1 | sed -E 's/.*Co-Authored-By: ([^<]+).*/\1/' | xargs)
Commit date:   $(git log -1 --pretty=%cd --date=relative)
Ahead of fork: $(git rev-list --count fork/main..HEAD 2>/dev/null || echo "?")
Working tree:  $(git diff --quiet && echo "clean" || echo "MODIFIED (uncommitted work!)")

--------------------------------------------------------------------------------
LAST 10 COMMITS
--------------------------------------------------------------------------------
$(git log -10 --pretty='%h  %ad  %s' --date=short)

--------------------------------------------------------------------------------
KEY FILE STATS
--------------------------------------------------------------------------------
$(wc -l source/library.lua 2>/dev/null | awk '{print "source/library.lua:  " $1 " lines"}')
$(wc -l NEMESIS.md 2>/dev/null | awk '{print "NEMESIS.md:          " $1 " lines"}')
$(wc -l PROJECT_MEMORY.txt 2>/dev/null | awk '{print "PROJECT_MEMORY.txt:  " $1 " lines"}')

--------------------------------------------------------------------------------
UNCOMMITTED CHANGES (if any)
--------------------------------------------------------------------------------
$(git diff --stat 2>/dev/null | tail -20)

--------------------------------------------------------------------------------
CURRENT STATE (from NEMESIS.md)
--------------------------------------------------------------------------------
$(awk '/^## 📍 CURRENT STATE/,/^## ⚠️ HANDOFF NOTE/' NEMESIS.md 2>/dev/null | head -40)

--------------------------------------------------------------------------------
HANDOFF NOTE (anything in-progress?)
--------------------------------------------------------------------------------
$(awk '/^## ⚠️ HANDOFF NOTE/,/^## 🎨 ELEMENT API/' NEMESIS.md 2>/dev/null | head -15)

--------------------------------------------------------------------------------
HARD RULES (don't break these)
--------------------------------------------------------------------------------
$(awk '/^## 🚫 HARD RULES/,/^## 🎨 NEMESIS THEME/' NEMESIS.md 2>/dev/null | head -25)

================================================================================
INSTRUCTIONS FOR YOU (the AI reading this)
================================================================================

1. Read NEMESIS.md and PROJECT_MEMORY.txt before touching code.
2. Use the Co-Authored-By trailer in your commits so the auto-log captures
   which AI you are. Format:
       Co-Authored-By: <your name/model> <noreply@example.com>
3. After committing, push to the FORK remote:  git push fork main
4. The post-commit git hook auto-updates NEMESIS.md — don't edit it manually
   unless you're leaving in-progress work in the "HANDOFF NOTE" section.

================================================================================
EOF
