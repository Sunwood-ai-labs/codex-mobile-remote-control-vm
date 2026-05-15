# Getting Started

## Install The Skill

Clone the repository into your Codex skills directory:

```bash
mkdir -p "$HOME/.codex/skills"
git clone https://github.com/Sunwood-ai-labs/codex-mobile-remote-control-vm.git \
  "$HOME/.codex/skills/codex-mobile-remote-control-vm"
```

Restart Codex Desktop or start a new Codex session so the skill registry refreshes.

## Confirm Discovery

Ask Codex for a mobile remote-control VM setup:

```text
Ubuntu VMでCodex Desktopをスマホ mobile からremote controlできるようにセットアップして
```

The skill should be selected when the request mentions Ubuntu, VM setup, Codex Desktop, mobile, or remote control.

## Inputs To Prepare

Have these details ready before the setup starts:

- Proxmox host, node, VM id, VM name, storage, and bridge
- SSH alias or guest IP address
- Ubuntu version and desktop access method
- GUI username and password policy
- Codex Desktop Linux-port source or install path
- ChatGPT/Codex mobile account used for pairing

Do not put credentials into the repository. Share them only through the active setup conversation when needed.
