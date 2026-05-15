<p align="center">
  <img src="assets/icon.svg" width="96" height="96" alt="Codex Mobile Remote Control VM icon">
</p>

<h1 align="center">Codex Mobile Remote Control VM</h1>

<p align="center">
  A Codex Skill for turning an SSH-only Ubuntu VM into a Codex Desktop host that can be controlled from the ChatGPT/Codex mobile app.
</p>

<p align="center">
  <a href="README.ja.md">日本語</a> | <a href="README.md">English</a>
</p>

<p align="center">
  <a href="https://github.com/Sunwood-ai-labs/codex-mobile-remote-control-vm/actions/workflows/ci.yml"><img alt="CI" src="https://github.com/Sunwood-ai-labs/codex-mobile-remote-control-vm/actions/workflows/ci.yml/badge.svg"></a>
  <img alt="Codex Skill" src="https://img.shields.io/badge/Codex-Skill-111827">
  <img alt="Ubuntu" src="https://img.shields.io/badge/Ubuntu-24.04-E95420">
  <img alt="License" src="https://img.shields.io/badge/License-MIT-blue">
</p>

## ✨ What This Skill Does

This repository packages a reusable Codex Skill for building and repairing Ubuntu desktop VMs that are meant to be remote-controlled from mobile.

It covers the full handoff path:

- Proxmox or SSH-accessible Ubuntu VM inventory
- XFCE/LightDM desktop setup so noVNC shows a real GUI instead of only `tty1`
- Codex Desktop Linux-port launch and restart flow
- `remote_connections` and `remote_control` feature configuration
- mobile app sign-in and remote-control verification
- diagnostics for disappearing Connections rows and empty `connectionCount=0` logs

The primary success criterion is not that the Linux desktop Connections panel looks perfect. The key proof is that the ChatGPT/Codex mobile app can open and control the VM-backed Codex Desktop session.

## 🚀 Install

Clone or copy this repository into your Codex skills directory:

```bash
mkdir -p "$HOME/.codex/skills"
git clone https://github.com/Sunwood-ai-labs/codex-mobile-remote-control-vm.git \
  "$HOME/.codex/skills/codex-mobile-remote-control-vm"
```

Restart Codex Desktop or start a new Codex session so the skill registry refreshes.

## 🧭 Use

Ask Codex for a mobile remote-control VM setup, for example:

```text
Ubuntu VMでCodex Desktopをスマホ mobile からremote controlできるようにセットアップして
```

The skill entry point is [SKILL.md](SKILL.md). The operational runbook is [references/runbook.md](references/runbook.md).

## 🩺 Audit A VM

After installing the skill, run the read-only audit script against an SSH alias or host:

```bash
./scripts/audit-codex-remote-vm.sh codex-ubuntu
```

The audit checks desktop services, GUI session state, Codex config, app-server feature flags, remote-control enrollment, and recent Codex Desktop logs.

## 🧩 Repository Layout

```text
.
├── SKILL.md                         # Codex Skill entry point
├── README.md                        # English public README
├── README.ja.md                     # Japanese public README
├── agents/openai.yaml               # Codex skill registry metadata
├── references/runbook.md            # Detailed setup and troubleshooting guide
├── scripts/audit-codex-remote-vm.sh # Read-only VM health audit
└── scripts/validate.sh              # Local repository validation
```

## ✅ Validation

Run:

```bash
./scripts/validate.sh
```

The validation checks:

- Skill metadata and required files
- Codex skill quick validation when available
- shell syntax for helper scripts
- README references to core files

## 🔐 Safety Notes

- Do not store GUI passwords, account credentials, tokens, or VM secrets in this repository.
- Treat mobile control as the final proof surface. UI rows in the Linux port can be misleading.
- Avoid making `~/.codex/config.toml` immutable except during short diagnosis.

## 📄 License

MIT License. See [LICENSE](LICENSE).
