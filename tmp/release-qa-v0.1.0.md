# v0.1.0 Release QA Inventory

## Release Context

- Repository: `Sunwood-ai-labs/codex-mobile-remote-control-vm`
- Release: `v0.1.0`
- Release URL: `https://github.com/Sunwood-ai-labs/codex-mobile-remote-control-vm/releases/tag/v0.1.0`
- Tag target commit: `bfbbd3849475dff301297212ea380211ebdb19dc`
- Published at: `2026-05-15T14:39:11Z`
- Scope: initial public release, covering the complete shipped history from an empty repository to the first public Skill package.

## Claim Matrix

| Claim | Evidence |
| --- | --- |
| The repository packages a Codex Skill for mobile remote control of a VM-backed Codex Desktop session. | `SKILL.md`, `agents/openai.yaml`, `README.md`, `README.ja.md`, and docs release pages. |
| The strongest proof surface is phone-side control, not only the Linux Connections UI. | README and docs include paired mobile screenshots under `assets/screenshots/` and `docs/public/screenshots/`. |
| The release includes bilingual docs and a companion walkthrough. | Published English/Japanese release pages and article pages returned HTTP 200. |
| The repository validates locally and in CI. | `./scripts/validate.sh` passed locally; GitHub Actions CI run `25923726184` succeeded. |
| GitHub Pages deployment is live. | Deploy Docs run `25923726170` succeeded; release/article/header URLs returned HTTP 200. |

## Steady-State Docs Review

- README badges include CI, Docs, and `v0.1.0` release links.
- README and README.ja link to release notes and walkthrough pages.
- VitePress nav/sidebar expose release notes and walkthrough pages in English and Japanese.
- The public docs home pages include release notes and article links.
- Release notes and walkthrough pages use committed images from `docs/public/`.

## QA Inventory

| Criterion | Status | Evidence |
| --- | --- | --- |
| compare_range | pass | Initial-release scope reviewed from empty tree through `bfbbd38`; `git diff --stat $(git hash-object -t tree /dev/null) HEAD` showed 32 files and full repository content before release-collateral additions. |
| release_claims_backed | pass | Release body claims map to committed files, docs, screenshots, scripts, and workflow results. |
| docs_release_notes | pass | `docs/guide/releases/v0.1.0.md` and `docs/ja/guide/releases/v0.1.0.md` are committed and live. |
| companion_walkthrough | pass | `docs/guide/articles/mobile-remote-control-vm-v0.1.0.md` and Japanese counterpart are committed and live. |
| operator_claims_extracted | pass | Release notes focus on operator workflow: desktop setup, feature flags, Codex Desktop launch, mobile sign-in, validation, and repair checks. |
| impl_sensitive_claims_verified | pass | Local validation, SVG validation, GitHub Actions, live docs checks, tag, and release were verified before completion. |
| steady_state_docs_reviewed | pass | README, docs home pages, VitePress sidebar/nav, release notes, and walkthrough links were reviewed after edits. |
| claim_scope_precise | pass | Release is described as an initial public Skill package, not as a guaranteed upstream Codex Linux product capability. |
| latest_release_links_updated | pass | README, README.ja, VitePress nav/sidebar, and docs home pages link to `v0.1.0`. |
| svg_assets_validated | pass | `xmllint --noout assets/icon.svg docs/public/logo.svg assets/release-header-v0.1.0.svg docs/public/releases/release-header-v0.1.0.svg` passed. |
| docs_assets_committed_before_tag | pass | Release collateral was committed in `bfbbd38`; annotated tag `v0.1.0` dereferences to that commit. |
| docs_deployed_live | pass | GitHub Actions Deploy Docs run `25923726170` succeeded and live release/article/header URLs returned HTTP 200. |
| tag_local_remote | pass | Local annotated tag exists; remote tag `refs/tags/v0.1.0` and peeled target `bfbbd3849475dff301297212ea380211ebdb19dc` verified. |
| github_release_verified | pass | `gh release view v0.1.0` returned a non-draft, non-prerelease release at the expected URL. |
| validation_commands_recorded | pass | Validation commands and results are recorded in this QA inventory and release body. |
| publish_date_verified | pass | GitHub release `publishedAt` is `2026-05-15T14:39:11Z`. |
| powershell_release_validator | not_applicable | `pwsh`/`powershell` are unavailable on this macOS environment; shell checks were used as a fallback. |

## Command Evidence

```text
./scripts/validate.sh
validation ok
```

```text
xmllint --noout assets/icon.svg docs/public/logo.svg assets/release-header-v0.1.0.svg docs/public/releases/release-header-v0.1.0.svg
exit 0
```

```text
gh run list --limit 6
completed success Prepare v0.1.0 release collateral CI main push 25923726184
completed success Prepare v0.1.0 release collateral Deploy Docs main push 25923726170
```

```text
gh release view v0.1.0 --json url,tagName,name,isDraft,isPrerelease,publishedAt,targetCommitish
{"isDraft":false,"isPrerelease":false,"name":"v0.1.0","publishedAt":"2026-05-15T14:39:11Z","tagName":"v0.1.0","targetCommitish":"main","url":"https://github.com/Sunwood-ai-labs/codex-mobile-remote-control-vm/releases/tag/v0.1.0"}
```

```text
HTTP 200:
https://sunwood-ai-labs.github.io/codex-mobile-remote-control-vm/guide/releases/v0.1.0
https://sunwood-ai-labs.github.io/codex-mobile-remote-control-vm/ja/guide/releases/v0.1.0
https://sunwood-ai-labs.github.io/codex-mobile-remote-control-vm/guide/articles/mobile-remote-control-vm-v0.1.0
https://sunwood-ai-labs.github.io/codex-mobile-remote-control-vm/ja/guide/articles/mobile-remote-control-vm-v0.1.0
https://sunwood-ai-labs.github.io/codex-mobile-remote-control-vm/releases/release-header-v0.1.0.svg
```
