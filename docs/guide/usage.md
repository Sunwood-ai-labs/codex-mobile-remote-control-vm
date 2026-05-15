# Usage

## Setup Flow

The Skill guides Codex through this sequence:

1. Confirm VM access through SSH or Proxmox.
2. Install or repair a desktop session with XFCE and LightDM.
3. Confirm noVNC or RDP reaches the GUI session.
4. Create a stable Codex Desktop launcher.
5. Enable `remote_connections` and `remote_control`.
6. Sign in with the same account used by the mobile app.
7. Verify actual control from the ChatGPT/Codex mobile app.

## Audit An Existing VM

Run the read-only audit script:

```bash
./scripts/audit-codex-remote-vm.sh codex-ubuntu
```

The script checks:

- desktop services such as `lightdm`, `xrdp`, and `qemu-guest-agent`
- GUI session evidence
- `~/.codex/config.toml`
- local app-server feature flags
- `remote_control_enrollments`
- recent Codex Desktop remote-control logs

## Primary Success Criterion

The best proof is that the mobile app can open and control the VM-backed Codex Desktop session.

The Linux port's Settings > Connections screen may not display the same device row that a desktop build shows. Do not treat an empty row list as failure until mobile control has been tested.

## Handoff Notes

Leave the next operator with:

- VM id, VM name, guest IP, SSH alias, and GUI access method
- launcher path and restart command
- the final `[features]` block
- audit-script output or a short health summary
- whether mobile control was personally verified by the user
