# Troubleshooting

## Connections Row Appears And Disappears

Check the logs before reinstalling anything:

```bash
tail -n 120 ~/.cache/codex-desktop/launcher.log |
  grep -E "remote-connections|remote_control|connectionCount|No owner repo" || true
```

`connectionCount=0` means the desktop Connections UI list is empty. It does not prove that mobile remote control is broken.

## `remote_control = true` Disappears

The app may normalize `~/.codex/config.toml` during startup. Re-add the feature after Codex Desktop is open, then check the app-server feature table.

```toml
[features]
remote_connections = true
remote_control = true
workspace_dependencies = false
```

Avoid long-term immutable config files. They can block normal Settings writes.

## GUI Falls Back To TTY

If Proxmox noVNC shows only `tty1`, fix the desktop layer before debugging Codex Desktop.

```bash
sudo systemctl enable --now lightdm qemu-guest-agent
systemctl is-active lightdm qemu-guest-agent
```

Log into the GUI session, then launch Codex Desktop with `DISPLAY=:0`.

## Enrollment Check

Confirm local enrollment state:

```bash
python3 - <<'PY'
import pathlib, sqlite3
p = pathlib.Path.home()/'.codex/state_5.sqlite'
con = sqlite3.connect(p)
print(con.execute(
    'select server_name, environment_id, updated_at from remote_control_enrollments'
).fetchall())
PY
```

A row here plus successful mobile control is a stronger signal than the Linux Connections UI list.
