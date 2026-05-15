# はじめに

## Skillをインストールする

このリポジトリをCodexのskillsディレクトリにcloneします。

```bash
mkdir -p "$HOME/.codex/skills"
git clone https://github.com/Sunwood-ai-labs/codex-mobile-remote-control-vm.git \
  "$HOME/.codex/skills/codex-mobile-remote-control-vm"
```

その後、Codex Desktopを再起動するか、新しいCodexセッションを開始してSkill registryを更新します。

## 認識を確認する

Codexに次のように依頼します。

```text
Ubuntu VMでCodex Desktopをスマホ mobile からremote controlできるようにセットアップして
```

Ubuntu、VM、Codex Desktop、mobile、remote control が含まれる依頼で、このSkillが選ばれる想定です。

## 準備しておく情報

セットアップ前に、次を用意しておくと進行が速くなります。

- Proxmox host、node、VM id、VM name、storage、bridge
- SSH alias または guest IP address
- Ubuntu version と desktop access method
- GUI username と password policy
- Codex Desktop Linuxポートのsourceまたはinstall path
- pairingに使うChatGPT/Codex mobile account

認証情報はリポジトリに入れないでください。必要なときだけ、セットアップ中の会話で共有します。
