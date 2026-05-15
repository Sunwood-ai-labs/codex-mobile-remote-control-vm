---
layout: home

hero:
  name: Codex Mobile Remote Control VM
  text: スマホ制御を主役にしたCodex Desktop VMセットアップ
  tagline: SSHだけのUbuntu VMを、ChatGPT/Codexモバイルアプリから制御できるCodex Desktopホストへ整えます。
  image:
    src: /logo.svg
    alt: Codex Mobile Remote Control VM logo
  actions:
    - theme: brand
      text: はじめる
      link: /ja/guide/getting-started
    - theme: alt
      text: English
      link: /

features:
  - title: mobile制御が主役
    details: Linux側のConnections表示ではなく、スマホから実際に制御できることを最終証拠として扱います。
  - title: VM向けrunbook
    details: Proxmox、SSH、XFCE、LightDM、qemu-guest-agent、Codex Desktop起動までまとめます。
  - title: 修復向けチェック
    details: feature flag、app-server状態、enrollment、ログ、消えるConnections行を切り分けます。
---

## ドキュメント構成

- [はじめに](./guide/getting-started.md): Skillの導入と準備情報。
- [使い方](./guide/usage.md): セットアップ実行と既存VMの監査。
- [トラブルシュート](./guide/troubleshooting.md): Linuxポート特有の挙動の読み方。

Skill本体は [SKILL.md](https://github.com/Sunwood-ai-labs/codex-mobile-remote-control-vm/blob/main/SKILL.md) です。
