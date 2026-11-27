# gw-claude-plugin

Reusable working rules for Claude Code, packaged as plugins. Install once in a new project instead of re-teaching Claude the same rules every time.

## Quick start (run this first)

Requires Claude Code. The repo is public, so no GitHub login or `gh` setup is needed.

**1. Add the marketplace and install the plugin.** Inside a Claude Code session in your project:

```
/plugin marketplace add Ghost-W0LF/gw-claude-plugin
/plugin install playbook-core@gw-claude-plugin
```

Flutter + Stacked project? Also install the Flutter pack:

```
/plugin install playbook-flutter-stacked@gw-claude-plugin
```

**2. Initialize the project:**

```
/playbook-core:init
/playbook-flutter-stacked:init     # Flutter projects only
```

**3. Check it worked:**
- `/plugin` → Installed tab lists the plugin(s).
- Start a new session; the core rules are injected automatically at session start.
- `CLAUDE.md` now has a `playbook-core` block and `docs/CHANGELOG.md` exists.

Done. From now on Claude follows the rules in this project without further teaching.

## What you get

| Plugin | Contents |
|---|---|
| `playbook-core` | Skills `changelog-upkeep`, `commit-conventions`, `project-hygiene`; a SessionStart hook that keeps the core rules always-on; `/playbook-core:init` |
| `playbook-flutter-stacked` (opt-in) | Skills `flutter-stacked-architecture`, `flutter-ui-conventions`, `flutter-layer-commits`; `/playbook-flutter-stacked:init` |

### The rules, in short

- **Module changelogs:** every feature module has a `CHANGELOG.md` at its root, created with the module and updated in the same change as the code (files, current behavior, chronological changes, decisions, known gaps).
- **App-level changelog:** a change touching more than one module also gets an entry in `docs/CHANGELOG.md`.
- **Docs in step with code:** update `CLAUDE.md` (and any screens/flows doc) when flow, architecture, tech or routes change.
- **Commits:** Conventional Commits, small logical commits, only when asked, never push unless asked, never commit secrets.
- **Flutter pack:** strict MVVM (Service → Repository → ViewModel → View), `flutter_screenutil` sizing, color tokens only, reusable widgets in `base/widgets/`, one commit per architectural layer.

## What `init` does

`/playbook-core:init` is idempotent:
1. Adds (or refreshes) a block between `<!-- playbook-core:start -->` and `<!-- playbook-core:end -->` in the project's `CLAUDE.md`. Nothing outside the markers is touched.
2. Creates `docs/CHANGELOG.md` from the template if it doesn't exist.
3. Lists existing modules that have no `CHANGELOG.md` and asks before creating starter ones.
4. Never commits.

`/playbook-flutter-stacked:init` does the same for the Flutter block (`<!-- playbook-flutter-stacked:start/end -->`) and tells you if your project's package name, color-token class or base widget folder differ from the defaults.

Project-specific values (package name, folder names, token names) belong in the project's own `CLAUDE.md`; it wins over the plugin defaults.

## Updating the rules

1. Edit files in this repo, bump `version` in the affected `plugin.json` (installed copies only update when it changes), commit and push.
2. In each project: `/plugin marketplace update gw-claude-plugin`.
3. Re-run `/playbook-core:init` to refresh the `CLAUDE.md` block.

Third-party marketplaces have auto-update off by default; enable it under `/plugin` → Marketplaces if you want it.

## Try changes locally before pushing

```bash
claude plugin validate .
claude plugin validate plugins/playbook-core
claude plugin marketplace add ./path/to/gw-claude-plugin
```

## Troubleshooting

- **"Failed to clone" / network errors:** `owner/repo` shorthand tries SSH first. If you have no GitHub SSH key, launch Claude Code with `CLAUDE_CODE_PLUGIN_PREFER_HTTPS=1` (set before it starts). If you later make the repo private again, you need a working git credential for github.com (`gh auth login && gh auth setup-git`, or any stored HTTPS credential).
- **Plugin not found:** the part after `@` is the marketplace name (`gw-claude-plugin`), not the plugin name.
- **Rules not showing in a session:** start a fresh session (the hook runs at session start); `claude --debug` shows hook output.
- **Remove:** `claude plugin marketplace remove gw-claude-plugin`.

## Layout

```
.claude-plugin/marketplace.json
plugins/
  playbook-core/             skills/ commands/ hooks/ scripts/ context/
  playbook-flutter-stacked/  skills/ commands/
```

## Adding a stack pack

Copy `plugins/playbook-flutter-stacked`, rename it, replace its skills, update its `init` command (it embeds the CLAUDE.md block and markers), and add it to `.claude-plugin/marketplace.json`.
