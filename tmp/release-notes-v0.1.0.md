<p align="center">
  <a href="https://sunwood-ai-labs.github.io/codex-mobile-remote-control-vm/guide/releases/v0.1.0"><img alt="Release Notes" src="https://img.shields.io/badge/Release%20Notes-English-2563EB"></a>
  <a href="https://sunwood-ai-labs.github.io/codex-mobile-remote-control-vm/ja/guide/releases/v0.1.0"><img alt="リリースノート" src="https://img.shields.io/badge/Release%20Notes-日本語-16A34A"></a>
  <a href="https://sunwood-ai-labs.github.io/codex-mobile-remote-control-vm/guide/articles/mobile-remote-control-vm-v0.1.0"><img alt="Walkthrough" src="https://img.shields.io/badge/Walkthrough-English-7C3AED"></a>
  <a href="https://sunwood-ai-labs.github.io/codex-mobile-remote-control-vm/ja/guide/articles/mobile-remote-control-vm-v0.1.0"><img alt="日本語Walkthrough" src="https://img.shields.io/badge/Walkthrough-日本語-EA580C"></a>
</p>

![Codex Mobile Remote Control VM v0.1.0](https://sunwood-ai-labs.github.io/codex-mobile-remote-control-vm/releases/release-header-v0.1.0.svg)

## ✨ Highlights

`v0.1.0` is the initial public release of **Codex Mobile Remote Control VM**, a reusable Codex Skill for turning an SSH-only Ubuntu VM into a Codex Desktop host that can be controlled from the ChatGPT/Codex mobile app.

The release focuses on the end-to-end operator workflow: provision the desktop environment, configure Codex feature flags, launch the Linux desktop app, verify mobile access, and keep enough diagnostics around to repair disappearing connection rows.

## 📦 What's Included

- Codex Skill entry point and registry metadata for local Codex Desktop discovery.
- Bilingual README files and VitePress documentation.
- VM setup and troubleshooting runbook for Proxmox or SSH-accessible Ubuntu hosts.
- Read-only VM audit script for desktop service, GUI session, Codex config, app-server, enrollment, and log checks.
- Screenshot-backed proof showing the mobile app controlling the VM-backed Codex Desktop session.
- GitHub Actions for repository validation and GitHub Pages deployment.

## 📚 Docs And Proof

- English release notes: https://sunwood-ai-labs.github.io/codex-mobile-remote-control-vm/guide/releases/v0.1.0
- Japanese release notes: https://sunwood-ai-labs.github.io/codex-mobile-remote-control-vm/ja/guide/releases/v0.1.0
- English walkthrough: https://sunwood-ai-labs.github.io/codex-mobile-remote-control-vm/guide/articles/mobile-remote-control-vm-v0.1.0
- Japanese walkthrough: https://sunwood-ai-labs.github.io/codex-mobile-remote-control-vm/ja/guide/articles/mobile-remote-control-vm-v0.1.0

## ✅ Validation

- `./scripts/validate.sh`
- `xmllint --noout assets/icon.svg docs/public/logo.svg assets/release-header-v0.1.0.svg docs/public/releases/release-header-v0.1.0.svg`
- GitHub Actions `CI`: success
- GitHub Actions `Deploy Docs`: success
- Published GitHub Pages release, article, and header asset URLs returned HTTP 200 before release publication.

## 🧭 Install

```bash
mkdir -p "$HOME/.codex/skills"
git clone https://github.com/Sunwood-ai-labs/codex-mobile-remote-control-vm.git \
  "$HOME/.codex/skills/codex-mobile-remote-control-vm"
```

Restart Codex Desktop or start a new Codex session so the skill registry refreshes.
