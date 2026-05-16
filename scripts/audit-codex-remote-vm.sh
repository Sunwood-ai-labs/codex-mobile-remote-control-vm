#!/usr/bin/env bash
set -euo pipefail

host="${1:-codex-ubuntu}"

ssh "$host" 'bash -s' <<'REMOTE'
set -euo pipefail

echo "== identity =="
hostname
date -Is
whoami

echo "== desktop services =="
for svc in lightdm xrdp qemu-guest-agent; do
  if command -v systemctl >/dev/null 2>&1; then
    printf "%s: " "$svc"
    systemctl is-active "$svc" 2>/dev/null || true
  fi
done

echo "== gui session =="
who || true
ps -ef | grep -E 'xfce4-session|lightdm|Xorg' | grep -v grep || true

echo "== codex config =="
if [ -f "$HOME/.codex/config.toml" ]; then
  sed -n '1,80p' "$HOME/.codex/config.toml"
else
  echo "missing ~/.codex/config.toml"
fi

echo "== codex desktop processes =="
pgrep -af '/codex-app/electron|codex-app/start.sh|webview-server' || true

echo "== desktop shortcut =="
for shortcut in "$HOME/Desktop/Codex Desktop.desktop" "$HOME/.local/share/applications/codex-desktop.desktop"; do
  if [ -f "$shortcut" ]; then
    ls -l "$shortcut"
    sed -n '1,12p' "$shortcut"
    if command -v gio >/dev/null 2>&1; then
      gio info "$shortcut" 2>/dev/null | grep 'metadata::trusted' || true
    fi
  else
    echo "missing $shortcut"
  fi
done

echo "== app-server features =="
python3 - <<'PY' || true
import pathlib, sqlite3
p = pathlib.Path.home()/'.codex/sqlite/codex-dev.db'
if not p.exists():
    print('missing', p)
    raise SystemExit
con = sqlite3.connect(p)
try:
    rows = con.execute('select feature_name, enabled, updated_at from local_app_server_feature_enablement order by feature_name').fetchall()
except Exception as exc:
    print('error', exc)
else:
    print(rows)
PY

echo "== remote control enrollment =="
python3 - <<'PY' || true
import pathlib, sqlite3
p = pathlib.Path.home()/'.codex/state_5.sqlite'
if not p.exists():
    print('missing', p)
    raise SystemExit
con = sqlite3.connect(p)
try:
    rows = con.execute('select server_name, environment_id, updated_at from remote_control_enrollments').fetchall()
except Exception as exc:
    print('error', exc)
else:
    print(rows)
PY

echo "== recent remote logs =="
log="$HOME/.cache/codex-desktop/launcher.log"
if [ -f "$log" ]; then
  grep -E 'remote-connections|remote_control|connectionCount|No owner repo|experimentalFeature' "$log" | tail -80 || true
else
  echo "missing $log"
fi
REMOTE
