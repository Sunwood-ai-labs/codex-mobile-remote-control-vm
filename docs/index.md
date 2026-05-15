---
layout: home

hero:
  name: Codex Mobile Remote Control VM
  text: Mobile-first Codex Desktop VM setup
  tagline: Turn an SSH-only Ubuntu VM into a Codex Desktop host that the ChatGPT/Codex mobile app can control.
  image:
    src: /logo.svg
    alt: Codex Mobile Remote Control VM logo
  actions:
    - theme: brand
      text: Get Started
      link: /guide/getting-started
    - theme: alt
      text: 日本語
      link: /ja/

features:
  - title: Mobile control first
    details: Treat real mobile app control as the primary proof, even when the Linux Connections UI is sparse.
  - title: VM-ready runbook
    details: Covers Proxmox, SSH access, XFCE, LightDM, qemu-guest-agent, and Codex Desktop launch details.
  - title: Repair-oriented checks
    details: Includes diagnostics for feature flags, app-server state, enrollments, logs, and disappearing rows.
---

## Documentation Map

- [Getting Started](./guide/getting-started.md): install the skill and prepare inputs.
- [Usage](./guide/usage.md): run the setup or audit an existing VM.
- [Troubleshooting](./guide/troubleshooting.md): interpret Linux-port edge cases.

For the raw Skill entry point, see [SKILL.md](https://github.com/Sunwood-ai-labs/codex-mobile-remote-control-vm/blob/main/SKILL.md).

## Setup Proof

These screenshots show the validated setup. The phone screenshot is the primary proof: the ChatGPT/Codex mobile app is controlling the VM-backed Codex Desktop session. The Proxmox screenshots show VM `101 (codex-ubuntu)` running Codex Desktop in the console, plus the node inventory with `codex`, `desktop`, `remote-control`, and `ubuntu` tags.

![ChatGPT/Codex mobile app controlling the VM-backed Codex Desktop session](/screenshots/mobile-remote-control-proof.png)

![Proxmox console showing Codex Desktop running inside the codex-ubuntu VM](/screenshots/proxmox-codex-desktop-vm.png)

![Proxmox node view showing the codex-ubuntu VM with codex, desktop, remote-control, and ubuntu tags](/screenshots/proxmox-node-tags.png)
