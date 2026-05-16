#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_root"

echo "== required files =="
required=(
  "SKILL.md"
  "README.md"
  "README.ja.md"
  "LICENSE"
  "agents/openai.yaml"
  "references/runbook.md"
  "scripts/audit-codex-remote-vm.sh"
  "scripts/create-codex-desktop-shortcut.sh"
)

for path in "${required[@]}"; do
  test -f "$path"
  echo "ok $path"
done

echo "== shell syntax =="
bash -n scripts/audit-codex-remote-vm.sh
bash -n scripts/create-codex-desktop-shortcut.sh
bash -n scripts/validate.sh

echo "== skill quick validation =="
validator="$HOME/.codex/skills/.system/skill-creator/scripts/quick_validate.py"
if command -v python3 >/dev/null 2>&1 && [ -f "$validator" ]; then
  python3 "$validator" "$repo_root"
else
  echo "skip quick_validate.py: unavailable"
fi

echo "== README link smoke =="
grep -q "SKILL.md" README.md
grep -q "references/runbook.md" README.md
grep -q "scripts/audit-codex-remote-vm.sh" README.md
grep -q "scripts/create-codex-desktop-shortcut.sh" README.md
grep -q "sunwood-ai-labs.github.io/codex-mobile-remote-control-vm" README.md
grep -q "SKILL.md" README.ja.md
grep -q "references/runbook.md" README.ja.md
grep -q "scripts/audit-codex-remote-vm.sh" README.ja.md
grep -q "scripts/create-codex-desktop-shortcut.sh" README.ja.md
grep -q "sunwood-ai-labs.github.io/codex-mobile-remote-control-vm" README.ja.md

echo "== docs build =="
if command -v npm >/dev/null 2>&1 && [ -d docs/node_modules ]; then
  npm --prefix docs run docs:build
else
  echo "skip docs build: run npm --prefix docs ci first"
fi

echo "validation ok"
