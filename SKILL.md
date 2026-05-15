---
name: codex-mobile-remote-control-vm
description: Set up, repair, or verify an Ubuntu/Linux desktop VM that lets the ChatGPT/Codex mobile app remotely control Codex Desktop. Use when Codex needs to create a Proxmox or SSH-accessible Ubuntu VM, install a desktop session, run the Linux Codex Desktop port, configure remote_connections/remote_control, pair or troubleshoot mobile remote control, handle disappearing Connections rows, or document a third-party handoff.
---

# Codex Mobile Remote Control VM

## Workflow

Use this skill to take a fresh or existing Ubuntu VM from SSH-only to a usable Codex Desktop host that can be controlled from the ChatGPT/Codex mobile app.

1. Establish access and inventory.
   - Confirm Proxmox VM id/name/IP when applicable.
   - Confirm SSH works before changing the VM.
   - Record the GUI username/password handoff only if the user explicitly wants it stored.
   - If using Proxmox UI or noVNC, use Computer Use for browser/GUI verification.

2. Install or repair the desktop layer.
   - Prefer a light desktop such as XFCE with LightDM.
   - Ensure `qemu-guest-agent` is active on Proxmox VMs.
   - Ensure `xrdp` only when the user wants RDP access.
   - Verify noVNC shows a GUI login or desktop, not only `tty1`.

3. Install or launch Codex Desktop.
   - Use the local Linux-compatible Codex Desktop port already chosen by the user or repo.
   - Create a stable launcher such as `~/.local/bin/codex-desktop-launch`.
   - If the port's launcher assumes a NixOS-only path, wrap it so it directly executes the app's `start.sh` with a normal shell.
   - Launch from the GUI session with:

```bash
DISPLAY=:0 XAUTHORITY=$HOME/.Xauthority XDG_RUNTIME_DIR=/run/user/1000 ~/.local/bin/codex-desktop-launch
```

4. Configure mobile remote control.
   - Ensure `~/.codex/config.toml` contains:

```toml
[features]
remote_connections = true
remote_control = true
workspace_dependencies = false
```

   - Also check the app-server feature DB when Connections behaves inconsistently:

```bash
sqlite3 ~/.codex/sqlite/codex-dev.db 'select feature_name, enabled from local_app_server_feature_enablement order by feature_name;'
```

   - If needed, insert `remote_control` and `remote_connections` with `enabled=1`, then relaunch Codex Desktop.
   - Do not leave `~/.codex/config.toml` immutable. Immutable config can block future app settings writes.

5. Sign in and pair mobile.
   - Sign into Codex Desktop in the VM with the same ChatGPT account as the mobile app.
   - Have the user open the ChatGPT/Codex mobile app and refresh/open the mobile remote-control surface.
   - Treat the VM-side Connections UI carefully: on the Linux port it may show only the SSH card while mobile remote control still works.

6. Verify using three surfaces.
   - GUI: Codex Desktop reaches the home screen and Settings > Connections opens.
   - Local state: `~/.codex/state_5.sqlite` has a `remote_control_enrollments` row.
   - User proof: mobile app can open and control the VM Codex session.

For detailed command sequences and known failure modes, read [references/runbook.md](references/runbook.md). For a read-only health check, run [scripts/audit-codex-remote-vm.sh](scripts/audit-codex-remote-vm.sh).

## Troubleshooting Priorities

- If the user says the row appeared and disappeared, check logs before reinstalling.
- `connectionCount=0` in `~/.cache/codex-desktop/launcher.log` means the Connections UI list is empty, but not necessarily that mobile remote control is broken.
- A valid enrollment looks like one row in `remote_control_enrollments` with `server_name`, `environment_id`, and `updated_at`.
- If the app removes `remote_control = true` at startup, re-add it after the app is open and verify again; avoid making the file immutable except for short diagnosis.
- If Proxmox noVNC shows a TTY after reboot, GUI login may still be required before launching Codex Desktop.
- If mobile control works, report that as the primary success criterion even if Settings > Connections does not show a device row.

## Handoff

Always leave a short repo or note with:

- VM host, VM id, VM name, guest IP, SSH alias, and GUI login method.
- Exact launcher path and restart command.
- The `config.toml` feature block.
- How to verify enrollment and logs.
- Whether mobile control was personally verified by the user.
