# SSHだけのUbuntu VMを、スマホから操作できるCodex Desktop環境にした話

> Codex DesktopをLinux VMで動かし、ChatGPT/CodexモバイルアプリからそのVMを遠隔操作できるところまで整えたセットアップ記録です。

今回やったことは、単に「Ubuntuにデスクトップ環境を入れた」だけではありません。

もともとはCLI環境しかないUbuntu VMでした。そこへGUIを入れ、Codex Desktopを起動できる状態にし、さらにスマホからそのCodex Desktopセッションを操作できるところまで持っていきました。

最終的には、この一連の作業を第三者でも再現しやすいようにCodex Skill化し、公開リポジトリとして整備しています。

- Repository: <https://github.com/Sunwood-ai-labs/codex-mobile-remote-control-vm>
- Docs: <https://sunwood-ai-labs.github.io/codex-mobile-remote-control-vm/>
- Release: <https://github.com/Sunwood-ai-labs/codex-mobile-remote-control-vm/releases/tag/v0.1.0>

## 何ができるようになったのか

完成形はこうです。

1. Proxmox上にUbuntu VMを用意する
2. SSHだけだったVMにXFCE/LightDMのデスクトップ環境を入れる
3. VM内でCodex Desktopを起動する
4. Codexのremote control系featureを有効にする
5. 同じアカウントでスマホ側からアクセスする
6. スマホからVM上のCodex Desktopを操作する

一番重要なのは最後の「スマホから操作できる」部分です。

Linux側のSettings > Connections画面が完璧に見えるかどうかよりも、実際にモバイルアプリからVM上のCodex Desktopセッションを開き、操作できることを成功条件にしました。

## セットアップ後の画面

Proxmoxのコンソール上では、Ubuntu VMの中でCodex Desktopが動いています。

![Proxmox console showing Codex Desktop running inside the codex-ubuntu VM](../assets/screenshots/proxmox-codex-desktop-vm.png)

VMには、あとで見分けやすいように `codex`, `desktop`, `remote-control`, `ubuntu` のタグも付けました。

![Proxmox node view showing the codex-ubuntu VM with codex, desktop, remote-control, and ubuntu tags](../assets/screenshots/proxmox-node-tags.png)

そして、今回の本命がこちらです。スマホ側からVM上のCodex Desktopセッションを操作できています。

<table>
  <tr>
    <td width="50%">
      <img src="../assets/screenshots/mobile-remote-control-proof.png" alt="ChatGPT/Codex mobile app controlling the VM-backed Codex Desktop session">
    </td>
    <td width="50%">
      <img src="../assets/screenshots/mobile-remote-control-second-proof.png" alt="Second ChatGPT/Codex mobile remote-control proof screenshot">
    </td>
  </tr>
</table>

この2枚のスマホスクリーンショットが、今回のセットアップで一番大事な証跡です。

## ハマりどころ

今回のポイントは、GUI環境とremote controlの両方を揃える必要があったことです。

CLIだけのUbuntu VMでは、Proxmoxのコンソールにログインプロンプトしか出ません。Codex Desktopを使うには、まず軽量なデスクトップ環境を入れて、noVNC越しにもGUIが見えるようにする必要があります。

また、Codex側では次のfeature設定が必要でした。

```toml
[features]
remote_connections = true
remote_control = true
workspace_dependencies = false
```

ただし、Linux版Codex DesktopのConnections画面は、状態表示が少し紛らわしいことがあります。画面上でデバイス行が出たり消えたりしても、モバイルアプリ側では正常に操作できるケースがありました。

そこで、今回のSkillでは「Linux側の表示」ではなく「スマホから実際に制御できるか」を最終確認にしています。

## なぜSkill化したのか

一度うまくいっただけでは、次回もスムーズに再現できるとは限りません。

特にこの手のVMセットアップは、次の情報が散らばりがちです。

- VM ID
- VM名
- IPアドレス
- SSH alias
- GUIログイン方法
- Codex Desktopの起動方法
- feature flagの設定
- remote controlの確認方法
- 失敗時に見るログ

そこで、作業手順をCodex Skillとしてまとめました。

このリポジトリをCodexのskillsディレクトリに入れておけば、次回からは次のように依頼できます。

```text
Ubuntu VMでCodex Desktopをスマホ mobile からremote controlできるようにセットアップして
```

Skill側では、VMの棚卸し、GUI環境の確認、Codex設定、mobile control検証、トラブルシュート観点までを一連の流れとして扱います。

## 監査スクリプトも入れた

再現性を上げるために、読み取り専用の監査スクリプトも用意しました。

```bash
./scripts/audit-codex-remote-vm.sh codex-ubuntu
```

このスクリプトでは、だいたい次の観点を確認します。

- desktop service
- GUI session
- Codex config
- app-server feature flags
- remote-control enrollment
- Codex Desktop logs

「なぜスマホから見えないのか」「なぜConnections行が消えたのか」を調べるための入口になります。

## 公開リポジトリとして整備

最終的には、Skillだけでなくリポジトリ全体も公開用に整えました。

- 英日README
- VitePressドキュメント
- リリースノート
- スクリーンショット付きウォークスルー
- GitHub Actions CI
- GitHub Pages deploy
- `v0.1.0` GitHub Release

`v0.1.0` のリリースでは、初回公開に必要なドキュメントと検証導線をまとめています。

## まとめ

今回の面白いところは、Codex Desktopを「手元のMacアプリ」だけではなく、「VM上で動く遠隔操作対象」として扱えるようになったところです。

SSHだけで触っていたUbuntu VMが、GUIを持ち、Codex Desktopを起動し、スマホから操作できる作業環境になる。これはかなり便利です。

しかも、今回の手順はSkill化したので、次に同じようなVMを作るときはゼロから思い出す必要がありません。

スマホからCodexを操作できるLinux VM。これはちょっと楽しい未来の作業机です。
