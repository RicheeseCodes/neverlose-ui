#!/bin/bash
# One-time setup script — run this ONCE on any machine to enable Nemesis
# auto-coordination hooks. Run from the repo root:
#     bash setup-hooks.sh

set -e
cd "$(dirname "${BASH_SOURCE[0]}")"

echo "Installing Nemesis AI coordination hooks..."

# Point git at our shared hooks dir
git config core.hooksPath .githooks

# Make all hooks executable
chmod +x .githooks/* 2>/dev/null || true
chmod +x brief.sh 2>/dev/null || true

echo "✅ Done. Hooks active:"
ls -1 .githooks/
echo ""
echo "Test it:  make any commit and watch NEMESIS.md auto-update."
echo "Brief any AI:  ./brief.sh | pbcopy  (then paste to the AI)"
