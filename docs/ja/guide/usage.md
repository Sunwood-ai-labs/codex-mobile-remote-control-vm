# 使い方

## セットアップの流れ

このSkillは、Codexを次の順番で案内します。

1. SSHまたはProxmoxでVMアクセスを確認する。
2. XFCEとLightDMでdesktop sessionを導入または修復する。
3. noVNCまたはRDPがGUI sessionへ到達することを確認する。
4. 安定したCodex Desktop launcherを作る。
5. `remote_connections` と `remote_control` を有効にする。
6. mobile appと同じaccountでサインインする。
7. ChatGPT/Codex mobile appから実際に制御できることを確認する。

## 既存VMを監査する

読み取り専用の監査スクリプトを実行します。

```bash
./scripts/audit-codex-remote-vm.sh codex-ubuntu
```

確認対象:

- `lightdm`, `xrdp`, `qemu-guest-agent` などのdesktop services
- GUI sessionの証拠
- `~/.codex/config.toml`
- local app-server feature flags
- `remote_control_enrollments`
- Codex Desktopのremote-control関連ログ

## 最重要の成功条件

一番強い証拠は、mobile appからVM上のCodex Desktop sessionを開いて制御できることです。

Linuxポートの Settings > Connections は、desktop buildと同じdevice rowを表示しない場合があります。mobile controlを試す前に、空のrow listだけで失敗判定しないでください。

## 引き継ぎメモ

次の担当者には、最低限これを残します。

- VM id、VM name、guest IP、SSH alias、GUI access method
- launcher path と restart command
- 最終的な `[features]` block
- audit-script output または短いhealth summary
- mobile controlをユーザー本人が検証したかどうか
