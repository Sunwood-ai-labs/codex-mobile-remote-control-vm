# トラブルシュート

## Connections行が出て消える

再インストールする前にログを確認します。

```bash
tail -n 120 ~/.cache/codex-desktop/launcher.log |
  grep -E "remote-connections|remote_control|connectionCount|No owner repo" || true
```

`connectionCount=0` はdesktop Connections UIのリストが空という意味です。mobile remote controlが壊れている証拠ではありません。

## `remote_control = true` が消える

アプリ起動時に `~/.codex/config.toml` が正規化されることがあります。Codex Desktopを開いたあとでfeatureを再追加し、app-server feature tableも確認します。

```toml
[features]
remote_connections = true
remote_control = true
workspace_dependencies = false
```

長期的にconfigをimmutableにするのは避けてください。通常のSettings書き込みを邪魔することがあります。

## GUIがTTYに戻る

Proxmox noVNCが `tty1` だけを表示する場合、Codex Desktopより先にdesktop layerを修復します。

```bash
sudo systemctl enable --now lightdm qemu-guest-agent
systemctl is-active lightdm qemu-guest-agent
```

GUI sessionへログインしてから、`DISPLAY=:0` でCodex Desktopを起動します。

## Enrollmentを確認する

local enrollment stateを確認します。

```bash
python3 - <<'PY'
import pathlib, sqlite3
p = pathlib.Path.home()/'.codex/state_5.sqlite'
con = sqlite3.connect(p)
print(con.execute(
    'select server_name, environment_id, updated_at from remote_control_enrollments'
).fetchall())
PY
```

ここにrowがあり、mobile controlが成功しているなら、Linux側のConnections UIより強い証拠です。
