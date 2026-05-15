# Walkthrough: From SSH-Only VM To Mobile-Controlled Codex Desktop

![Codex Mobile Remote Control VM v0.1.0 release header](/releases/release-header-v0.1.0.svg)

The v0.1.0 release turns a successful one-off setup into a reusable Skill. The goal is straightforward: take an Ubuntu VM that starts as a remote shell and leave it as a Codex Desktop host that a phone can control.

## Why This Release Matters

The hardest part of this workflow is not installing a desktop package. It is knowing which proof surface matters. On the Linux Codex Desktop port, Settings > Connections may not show the same device row a desktop user expects. v0.1.0 makes the mobile app control path the finish line and documents the supporting evidence that should be checked around it.

## What The Skill Automates For The Operator

The Skill guides Codex through a concrete setup sequence:

1. Inventory the Proxmox or SSH-accessible VM.
2. Install or repair a lightweight GUI with XFCE and LightDM.
3. Launch Codex Desktop in the VM GUI session.
4. Enable `remote_connections` and `remote_control`.
5. Sign in with the same account used by the phone.
6. Verify that the ChatGPT/Codex mobile app can open and control the VM-backed Codex session.

## Proof Images

The paired phone screenshots are the main release evidence. They show the VM-backed Codex session being controlled from mobile. The Proxmox screenshots then show the VM identity, desktop console, and tags used for handoff.

<div style="display: grid; grid-template-columns: repeat(2, minmax(0, 1fr)); gap: 16px; align-items: start;">
  <img src="/screenshots/mobile-remote-control-proof.png" alt="ChatGPT/Codex mobile app controlling the VM-backed Codex Desktop session">
  <img src="/screenshots/mobile-remote-control-second-proof.png" alt="Second ChatGPT/Codex mobile remote-control proof screenshot">
</div>

![Proxmox console showing Codex Desktop running inside the codex-ubuntu VM](/screenshots/proxmox-codex-desktop-vm.png)

![Proxmox node view showing the codex-ubuntu VM with codex, desktop, remote-control, and ubuntu tags](/screenshots/proxmox-node-tags.png)

## Validation And Handoff

The release includes `scripts/audit-codex-remote-vm.sh` for read-only VM checks. It reports desktop services, GUI session evidence, Codex config, app-server feature flags, remote-control enrollment rows, and recent Codex Desktop logs.

For a third-party handoff, keep these details close:

- VM id, VM name, guest IP, SSH alias, and GUI login method
- Codex Desktop launcher path and restart command
- final `[features]` block
- enrollment and log checks
- whether mobile control was personally verified

## Links

- [v0.1.0 release notes](../releases/v0.1.0.md)
- [Usage guide](../usage.md)
- [Troubleshooting guide](../troubleshooting.md)
