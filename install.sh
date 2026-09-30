#!/usr/bin/env bash
set -e

# AI Outreach Machine — Installer
# H&K Solutions · hk-solutions.nl

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
SKILLS_SRC="$SCRIPT_DIR/skills"
SOPS_SRC="$SCRIPT_DIR/sops"
PROMPTS_SRC="$SCRIPT_DIR/prompts"
SKILLS_DEST="$HOME/.claude/commands/outreach"
SOPS_DEST="$SKILLS_DEST/sops"
PROMPTS_DEST="$SKILLS_DEST/prompts"
PROGRESS_DIR="$HOME/.outreach-machine"
PROGRESS_FILE="$PROGRESS_DIR/progress.json"
DASHBOARD_PORT=8767

echo ""
echo "=============================================="
echo "  AI Outreach Machine — Installer"
echo "  door H&K Solutions · hk-solutions.nl"
echo "=============================================="
echo ""

# 1. Check prerequisites
if [ ! -d "$SKILLS_SRC" ]; then
  echo "FOUT: skills map niet gevonden op $SKILLS_SRC"
  echo "Voer dit script uit vanuit de uitgepakte cursusmap."
  exit 1
fi

if ! command -v python3 &> /dev/null; then
  echo "FOUT: python3 niet gevonden. Installeer via brew: brew install python3"
  exit 1
fi

if ! command -v claude &> /dev/null; then
  echo "WAARSCHUWING: Claude Code niet gevonden in PATH."
  echo "Installeer via: npm install -g @anthropic-ai/claude-code"
  echo "De skills worden wel geïnstalleerd — je kunt ze gebruiken zodra Claude Code beschikbaar is."
  echo ""
fi

# 2. Installeer skills
echo "[1/5] Skills installeren naar $SKILLS_DEST ..."
mkdir -p "$SKILLS_DEST"
cp "$SKILLS_SRC"/*.md "$SKILLS_DEST/"
SKILL_COUNT=$(ls -1 "$SKILLS_DEST"/*.md 2>/dev/null | wc -l | tr -d ' ')
echo "      $SKILL_COUNT skill-bestanden geïnstalleerd"

# 3. Installeer SOPs en prompts
echo "[2/5] SOPs + prompts installeren ..."
mkdir -p "$SOPS_DEST" "$PROMPTS_DEST"
cp "$SOPS_SRC"/*.md "$SOPS_DEST/" 2>/dev/null || true
cp "$PROMPTS_SRC"/*.md "$PROMPTS_DEST/" 2>/dev/null || true
SOP_COUNT=$(ls -1 "$SOPS_DEST"/*.md 2>/dev/null | wc -l | tr -d ' ')
echo "      $SOP_COUNT SOP-bestanden geïnstalleerd"

# 4. Voortgangsmap aanmaken
echo "[3/5] Voortgangsmap aanmaken in $PROGRESS_DIR ..."
mkdir -p "$PROGRESS_DIR"
if [ ! -f "$PROGRESS_FILE" ]; then
  cat > "$PROGRESS_FILE" <<EOF
{
  "current_lesson": null,
  "current_step": 0,
  "total_steps": 0,
  "completed_lessons": [],
  "started_at": null,
  "last_updated": null
}
EOF
  echo "      progress.json aangemaakt"
else
  echo "      progress.json bestaat al (behouden)"
fi

# 5. Symlink progress.json naar dashboard
ln -sf "$PROGRESS_FILE" "$SCRIPT_DIR/progress.json"
echo "[4/5] Dashboard gekoppeld aan progress.json"

# 6. Dashboard-server starten
echo "[5/5] Dashboard-server starten op poort $DASHBOARD_PORT ..."
lsof -ti:$DASHBOARD_PORT | xargs kill -9 2>/dev/null || true
cd "$SCRIPT_DIR"
nohup python3 -m http.server $DASHBOARD_PORT > /tmp/outreach-machine.log 2>&1 &
SERVER_PID=$!
sleep 1
echo "      Server draait (PID $SERVER_PID, log: /tmp/outreach-machine.log)"

# 7. Browser openen
DASHBOARD_URL="http://localhost:$DASHBOARD_PORT/dashboard.html"
echo ""
echo "=============================================="
echo "  Installatie klaar!"
echo "=============================================="
echo ""
echo "  Dashboard: $DASHBOARD_URL"
echo ""
echo "  Maak daarna een NIEUWE LEGE MAP voor jouw outreach-systeem,"
echo "  open Claude Code daarin, en voer uit:"
echo ""
echo "    /outreach:00-intro"
echo ""
echo "  Dashboard-server stoppen:"
echo "    kill $SERVER_PID"
echo "  Of: lsof -ti:$DASHBOARD_PORT | xargs kill -9"
echo ""

if command -v open &> /dev/null; then
  open "$DASHBOARD_URL"
elif command -v xdg-open &> /dev/null; then
  xdg-open "$DASHBOARD_URL"
else
  echo "  (browser kon niet automatisch openen — plak de URL zelf)"
fi

echo ""
echo "Succes! — Leo Kerkvliet, H&K Solutions"
echo "Vragen? hk-solutions.nl · https://calendly.com/hk-solutions/callmaillink"
echo ""
