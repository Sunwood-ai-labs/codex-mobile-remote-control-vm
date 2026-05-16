<p align="center">
  <img src="assets/icon.svg" width="96" height="96" alt="Codex Mobile Remote Control VM icon">
</p>

<h1 align="center">Codex Mobile Remote Control VM</h1>

<p align="center">
  SSHだけのUbuntu VMを、ChatGPT/Codexモバイルアプリから制御できるCodex Desktopホストへ整えるためのCodex Skillです。
</p>

<p align="center">
  <a href="README.md">English</a> | <a href="README.ja.md">日本語</a>
</p>

<p align="center">
  <a href="https://github.com/Sunwood-ai-labs/codex-mobile-remote-control-vm/actions/workflows/ci.yml"><img alt="CI" src="https://github.com/Sunwood-ai-labs/codex-mobile-remote-control-vm/actions/workflows/ci.yml/badge.svg"></a>
  <a href="https://github.com/Sunwood-ai-labs/codex-mobile-remote-control-vm/actions/workflows/deploy-docs.yml"><img alt="Docs" src="https://github.com/Sunwood-ai-labs/codex-mobile-remote-control-vm/actions/workflows/deploy-docs.yml/badge.svg"></a>
  <a href="https://github.com/Sunwood-ai-labs/codex-mobile-remote-control-vm/releases/tag/v0.1.0"><img alt="Release v0.1.0" src="https://img.shields.io/badge/Release-v0.1.0-2563EB"></a>
  <img alt="Codex Skill" src="https://img.shields.io/badge/Codex-Skill-111827">
  <img alt="Ubuntu" src="https://img.shields.io/badge/Ubuntu-24.04-E95420">
  <img alt="License" src="https://img.shields.io/badge/License-MIT-blue">
</p>

## ✨ このSkillでできること

このリポジトリは、UbuntuデスクトップVMを「スマホからCodex Desktopを操作できる環境」にするための再利用可能なCodex Skillです。

対応する流れ:

- ProxmoxまたはSSH可能なUbuntu VMの棚卸し
- noVNCが `tty1` だけではなくGUIを表示できるようにするXFCE/LightDMセットアップ
- Codex Desktop Linuxポートの起動・再起動導線
- `remote_connections` と `remote_control` の feature flag 設定
- モバイルアプリでのサインイン確認とremote control検証
- Connections行が消える、`connectionCount=0` が出る、といった症状の切り分け

一番大事な成功条件は、Linux側のConnections画面が綺麗に見えることではありません。ChatGPT/Codexモバイルアプリから、VM上のCodex Desktopセッションを開いて制御できることです。

## 🚀 インストール

このリポジトリをCodexのskillsディレクトリにcloneします。

```bash
mkdir -p "$HOME/.codex/skills"
git clone https://github.com/Sunwood-ai-labs/codex-mobile-remote-control-vm.git \
  "$HOME/.codex/skills/codex-mobile-remote-control-vm"
```

その後、Codex Desktopを再起動するか、新しいCodexセッションを開始してSkill registryを更新してください。

## 🧭 使い方

Codexに、たとえば次のように依頼します。

```text
Ubuntu VMでCodex Desktopをスマホ mobile からremote controlできるようにセットアップして
```

Skill本体は [SKILL.md](SKILL.md) です。実作業の手順は [references/runbook.md](references/runbook.md) にまとまっています。

## 📚 ドキュメント

ブラウザで読めるドキュメントはこちらです。

<https://sunwood-ai-labs.github.io/codex-mobile-remote-control-vm/>

- [v0.1.0 リリースノート](https://sunwood-ai-labs.github.io/codex-mobile-remote-control-vm/ja/guide/releases/v0.1.0)
- [スマホ制御ウォークスルー](https://sunwood-ai-labs.github.io/codex-mobile-remote-control-vm/ja/guide/articles/mobile-remote-control-vm-v0.1.0)

ローカルpreview:

```bash
cd docs
npm ci
npm run docs:dev
```

## 🖼️ セットアップ証跡

このSkillの検証に使った、実際のセットアップ画像です。最重要の証跡は、スマホからVM上のCodex Desktop sessionを制御できていることです。

<table>
  <tr>
    <td width="50%">
      <img src="assets/screenshots/mobile-remote-control-proof.png" alt="ChatGPT/Codex mobile app controlling the VM-backed Codex Desktop session">
    </td>
    <td width="50%">
      <img src="assets/screenshots/mobile-remote-control-second-proof.png" alt="Second ChatGPT/Codex mobile remote-control proof screenshot">
    </td>
  </tr>
</table>

![Proxmox console showing Codex Desktop running inside the codex-ubuntu VM](assets/screenshots/proxmox-codex-desktop-vm.png)

![Proxmox node view showing the codex-ubuntu VM with codex, desktop, remote-control, and ubuntu tags](assets/screenshots/proxmox-node-tags.png)

## 🩺 VMを監査する

SSH aliasまたはホスト名を指定して、読み取り専用の監査スクリプトを実行できます。

```bash
./scripts/audit-codex-remote-vm.sh codex-ubuntu
```

監査対象は、desktop service、GUI session、Codex config、app-server feature flag、remote-control enrollment、Codex Desktopログです。

## 🖥️ デスクトップショートカットを作る

VMに安定したlauncherを作ったあと、GUIデスクトップのショートカットを次で作れます。

```bash
ssh codex-ubuntu 'bash -s' < scripts/create-codex-desktop-shortcut.sh
```

`~/Desktop/Codex Desktop.desktop` と `~/.local/share/applications/codex-desktop.desktop` を作成し、desktop entryに実行権限を付け、`gio` が使える場合はtrusted metadataも設定します。

## 🧩 リポジトリ構成

```text
.
├── SKILL.md                         # Codex Skill entry point
├── README.md                        # 英語README
├── README.ja.md                     # 日本語README
├── agents/openai.yaml               # Codex skill registry metadata
├── references/runbook.md            # 詳細セットアップ・トラブルシュート
├── docs/                            # 日英VitePressドキュメント
├── scripts/audit-codex-remote-vm.sh # 読み取り専用VM監査
├── scripts/create-codex-desktop-shortcut.sh # GUIショートカット作成
└── scripts/validate.sh              # ローカル検証
```

## ✅ 検証

次を実行します。

```bash
./scripts/validate.sh
```

検証内容:

- Skill metadata と必須ファイル
- 利用可能な場合はCodex Skill quick validation
- helper scriptのshell構文
- READMEから主要ファイルへの参照
- Node dependenciesがある場合はVitePress docs build

## 🔐 安全メモ

- GUIパスワード、アカウント認証情報、token、VM secretsはこのリポジトリに保存しないでください。
- mobile controlを最終的な証拠面として扱ってください。LinuxポートのUI行表示は誤解を招くことがあります。
- `~/.codex/config.toml` をimmutableにするのは、短時間の診断時だけにしてください。

## 📄 ライセンス

MIT Licenseです。詳細は [LICENSE](LICENSE) を参照してください。
