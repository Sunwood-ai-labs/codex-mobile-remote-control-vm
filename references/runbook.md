# Codex Mobile Remote Control VM Runbook

## Inputs To Gather

- Proxmox host, node, VM id, VM name, storage target, and bridge.
- Ubuntu version and whether a GUI ISO/cloud image already exists.
- Desired GUI username and password policy.
- Whether the user wants RDP, Proxmox noVNC only, or both.
- Codex Desktop Linux port source and install directory.
- Mobile app account and expected remote-control verification path.
- Whether Chrome/Firefox login is already available.

## Proxmox Checks

```bash
ssh giobox 'qm status 101 --verbose'
ssh giobox 'qm config 101'
ssh giobox 'qm agent 101 ping'
ssh giobox 'qm set 101 --tags codex,desktop,remote-control,ubuntu'
```

Use the real host/vmid. If `qm agent` fails, install and start `qemu-guest-agent` inside the guest, then reboot or restart the agent.

## Ubuntu Desktop Baseline

```bash
sudo apt-get update
sudo apt-get install -y xfce4 lightdm xrdp qemu-guest-agent firefox
sudo systemctl enable --now lightdm qemu-guest-agent
sudo systemctl enable --now xrdp
```

Validate:

```bash
systemctl is-active lightdm xrdp qemu-guest-agent
who
ps -ef | grep -E 'xfce4-session|lightdm|Xorg' | grep -v grep
```

If the Proxmox console shows only `tty1`, log into the GUI through noVNC or fix LightDM before debugging Codex Desktop.

## Codex Desktop Launcher

Use a stable user launcher so future agents do not rediscover the port's exact start path.

```bash
mkdir -p ~/.local/bin
cat > ~/.local/bin/codex-desktop-launch <<'SH'
#!/usr/bin/env bash
set -euo pipefail
cd "$HOME/codex-app"
exec ./start.sh
SH
chmod +x ~/.local/bin/codex-desktop-launch
```

Launch in an existing GUI session:

```bash
DISPLAY=:0 XAUTHORITY=$HOME/.Xauthority XDG_RUNTIME_DIR=/run/user/1000 \
  nohup "$HOME/.local/bin/codex-desktop-launch" >/tmp/codex-desktop.log 2>&1 &
```

Optional restart helper:

```bash
pkill -f '[/]home/.*/codex-app/electron' 2>/dev/null || true
pkill -f 'codex-app/.codex-linux/webview-server.py' 2>/dev/null || true
DISPLAY=:0 XAUTHORITY=$HOME/.Xauthority XDG_RUNTIME_DIR=/run/user/1000 \
  nohup "$HOME/.local/bin/codex-desktop-launch" >/tmp/codex-desktop.log 2>&1 &
```

## Feature Flags

Ensure:

```toml
[features]
remote_connections = true
remote_control = true
workspace_dependencies = false
```

If the app rewrites config on startup, re-add `remote_control = true` after the GUI app is running. Use a TOML-aware edit when possible. Avoid long-term `chattr +i`; it can break normal settings writes.

The app-server DB can also hold feature state:

```bash
python3 - <<'PY'
import pathlib, sqlite3, time
p = pathlib.Path.home()/'.codex/sqlite/codex-dev.db'
con = sqlite3.connect(p)
now = int(time.time() * 1000)
for feature in ('remote_connections', 'remote_control'):
    con.execute(
        'insert into local_app_server_feature_enablement(feature_name, enabled, updated_at) values(?,?,?) '
        'on conflict(feature_name) do update set enabled=excluded.enabled, updated_at=excluded.updated_at',
        (feature, 1, now),
    )
con.commit()
print(list(con.execute('select feature_name, enabled from local_app_server_feature_enablement order by feature_name')))
PY
```

Relaunch Codex Desktop after changing DB feature state.

## Sign In And Pair Mobile

1. Open Codex Desktop in the VM GUI.
2. Sign in with the same ChatGPT account used by the ChatGPT/Codex mobile app.
3. Open Settings > Connections in Codex Desktop.
4. On mobile, refresh the Codex remote connection/control surface.
5. Ask the user to verify actual mobile control, not only row visibility.

Known Linux-port behavior: Settings > Connections can show only `SSH connections from this Mac` and the Add card while mobile remote control still works.

## Verification Commands

```bash
ssh codex-ubuntu 'sed -n "1,40p" ~/.codex/config.toml'
ssh codex-ubuntu 'pgrep -af "/codex-app/electron|webview-server|codex-app/start.sh"'
ssh codex-ubuntu 'tail -n 120 ~/.cache/codex-desktop/launcher.log | grep -E "remote-connections|remote_control|connectionCount|No owner repo" || true'
ssh codex-ubuntu 'python3 - <<PY
import pathlib, sqlite3
p = pathlib.Path.home()/".codex/state_5.sqlite"
con = sqlite3.connect(p)
print(con.execute("select server_name, environment_id, updated_at from remote_control_enrollments").fetchall())
PY'
```

Success is:

- SSH and GUI access work.
- Codex Desktop launches and remains signed in.
- `remote_control_enrollments` has a row for the VM.
- The ChatGPT/Codex mobile app can control the VM session.

## Failure Modes

- `remote_control = true` disappears: app normalized config; re-add after open, optionally set DB feature state, relaunch.
- `connectionCount=0`: desktop Connections UI list is empty; check mobile before declaring failure.
- `No owner repo found for remote task`: remote tasks are reaching the app but may not map to a local repo; this can coexist with working mobile control.
- GUI absent after reboot: log into LightDM/noVNC, then launch Codex Desktop in DISPLAY `:0`.
- App starts but browser login fails: open `https://auth.openai.com/` in the VM browser and complete sign-in manually.
