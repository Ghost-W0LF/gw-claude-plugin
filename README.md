# gw-claude-plugin

Reusable working rules for Claude Code, packaged as plugins so a new project needs one install instead of re-teaching Claude.

| Plugin | What it gives you |
|---|---|
| `playbook-core` | Per-module + app-level changelog rules, Conventional Commits, project hygiene; a SessionStart hook keeps the core rules always-on |
| `playbook-flutter-stacked` | Strict MVVM + Stacked architecture, UI conventions, per-layer commits (opt-in) |

## Install (private GitHub repo)

```
gh auth login && gh auth setup-git      # once per machine
/plugin marketplace add Ghost-W0LF/gw-claude-plugin
/plugin install playbook-core@gw-claude-plugin
/plugin install playbook-flutter-stacked@gw-claude-plugin   # Flutter + Stacked projects only
```

Then, in the new project:

```
/playbook-core:init                     # CLAUDE.md block + docs/CHANGELOG.md
/playbook-flutter-stacked:init          # Flutter projects only
```

`init` is idempotent: re-running refreshes the marked blocks in `CLAUDE.md` and never duplicates them.

## Updating the rules

Edit files here, commit, push, then in any project: `/plugin marketplace update gw-claude-plugin`. Bump `version` in the plugin's `plugin.json` so installed copies update. Re-run `init` in a project to refresh its `CLAUDE.md` block.

## Layout

```
.claude-plugin/marketplace.json
plugins/playbook-core/            skills/, commands/, hooks/, scripts/, context/, templates/
plugins/playbook-flutter-stacked/ skills/, commands/, templates/
```

## Adding a stack pack

Copy `playbook-flutter-stacked`, rename it, replace the skills and `templates/CLAUDE.<stack>.md`, and add it to `.claude-plugin/marketplace.json`.
