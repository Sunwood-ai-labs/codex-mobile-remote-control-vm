#!/usr/bin/env bash
set -euo pipefail

launcher="${1:-$HOME/.local/bin/codex-desktop-launch}"
app_dir="${CODEX_APP_DIR:-$HOME/codex-app}"
desktop_dir="${XDG_DESKTOP_DIR:-}"

if [ -z "$desktop_dir" ]; then
  desktop_dir="$(xdg-user-dir DESKTOP 2>/dev/null || true)"
fi
desktop_dir="${desktop_dir:-$HOME/Desktop}"

icon="$app_dir/.codex-linux/codex-desktop.png"
shortcut="$desktop_dir/Codex Desktop.desktop"
app_entry="$HOME/.local/share/applications/codex-desktop.desktop"

if [ ! -x "$launcher" ]; then
  echo "missing executable launcher: $launcher" >&2
  exit 1
fi

mkdir -p "$desktop_dir" "$HOME/.local/share/applications"

cat > "$shortcut" <<EOF
[Desktop Entry]
Version=1.0
Type=Application
Name=Codex Desktop
Comment=Launch Codex Desktop
Exec=$launcher
Icon=$icon
Terminal=false
Categories=Development;Utility;
StartupNotify=true
StartupWMClass=codex-desktop
EOF

chmod +x "$shortcut"
cp "$shortcut" "$app_entry"
chmod 644 "$app_entry"

if command -v gio >/dev/null 2>&1; then
  gio set "$shortcut" metadata::trusted true 2>/dev/null || true
fi

if command -v update-desktop-database >/dev/null 2>&1; then
  update-desktop-database "$HOME/.local/share/applications" 2>/dev/null || true
fi

echo "created desktop shortcut: $shortcut"
echo "created application entry: $app_entry"
