#!/usr/bin/env bash
# Installer for the claude-daily-log skill.
# Copies the skill files into your Claude Code skills folder so `/daily-log` works.
#
# Usage:  bash install.sh
set -e

SRC="$(cd "$(dirname "$0")" && pwd)"
DEST="$HOME/.claude/skills/daily-log"

mkdir -p "$DEST"
cp "$SRC/SKILL.md" "$SRC/collect_day.py" "$SRC/render_pdf.sh" "$SRC/upload_to_drive.sh" "$DEST/"
chmod +x "$DEST/"*.sh

echo "✅ Installed daily-log skill to $DEST"
echo "   Restart Claude Code (or start a new session), then run:  /daily-log"
echo
echo "Optional:"
echo "  • PDF export needs Node.js + Google Chrome."
echo "  • Google Drive upload needs rclone:  brew install rclone && rclone config  (remote name: gdrive)"
