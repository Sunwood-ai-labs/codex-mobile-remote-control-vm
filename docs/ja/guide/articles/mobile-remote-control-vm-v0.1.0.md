# Walkthrough: SSHだけのVMからスマホ制御できるCodex Desktopへ

![Codex Mobile Remote Control VM v0.1.0 release header](/releases/release-header-v0.1.0.svg)

v0.1.0 は、一度うまくいったセットアップを再利用できるSkillにした初回リリースです。目的ははっきりしています。SSHだけで触れるUbuntu VMを、スマホから操作できるCodex Desktopホストとして仕上げます。

## このリリースで大事なこと

このworkflowで難しいのは、単にdesktop packageを入れることではありません。どの証跡を成功条件にするかです。Linux版Codex Desktopポートでは、Settings > Connectionsが期待どおりのdevice rowを出さないことがあります。v0.1.0では、mobile appから実際に制御できることを最終証拠として扱い、その周辺で確認すべき状態をdocs化しました。

## Skillが案内する流れ

このSkillはCodexを次の流れで案内します。

1. ProxmoxまたはSSH可能なVMを棚卸しする。
2. XFCEとLightDMで軽量GUIを入れる、または修復する。
3. VMのGUI sessionでCodex Desktopを起動する。
4. `remote_connections` と `remote_control` を有効化する。
5. スマホ側と同じaccountでサインインする。
6. ChatGPT/Codex mobile appからVM上のCodex sessionを開いて制御できることを確認する。

## 証跡画像

横並びのスマホ画像が、このreleaseで一番重要な証跡です。VM上のCodex sessionをmobileから制御できていることを示します。Proxmox画像は、VM identity、desktop console、handoff用tagを補足します。

<div style="display: grid; grid-template-columns: repeat(2, minmax(0, 1fr)); gap: 16px; align-items: start;">
  <img src="/screenshots/mobile-remote-control-proof.png" alt="ChatGPT/Codex mobile app controlling the VM-backed Codex Desktop session">
  <img src="/screenshots/mobile-remote-control-second-proof.png" alt="Second ChatGPT/Codex mobile remote-control proof screenshot">
</div>

![Proxmox console showing Codex Desktop running inside the codex-ubuntu VM](/screenshots/proxmox-codex-desktop-vm.png)

![Proxmox node view showing the codex-ubuntu VM with codex, desktop, remote-control, and ubuntu tags](/screenshots/proxmox-node-tags.png)

## 検証と引き継ぎ

このreleaseには、読み取り専用の `scripts/audit-codex-remote-vm.sh` を含めています。desktop services、GUI session、Codex config、app-server feature flags、remote-control enrollment、Codex Desktopログを確認できます。

第三者へ引き継ぐときは、最低限これを残します。

- VM id、VM name、guest IP、SSH alias、GUI login method
- Codex Desktop launcher path と restart command
- 最終的な `[features]` block
- enrollment と log の確認結果
- mobile controlをユーザー本人が検証したかどうか

## リンク

- [v0.1.0 リリースノート](../releases/v0.1.0.md)
- [使い方](../usage.md)
- [トラブルシュート](../troubleshooting.md)
