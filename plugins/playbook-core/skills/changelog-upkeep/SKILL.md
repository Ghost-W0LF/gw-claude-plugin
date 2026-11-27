---
name: changelog-upkeep
description: Keep per-module and app-level CHANGELOG.md files up to date. Use whenever you add, change, remove or make a decision about a feature module, screen or package, when creating a new module, or when a change touches more than one module.
---

# Changelog upkeep

Every feature module keeps a living `CHANGELOG.md` at its root. Changes that span modules also go in one app-level changelog.

## Rules

1. **Each module has its own `CHANGELOG.md`** at the module root (for example `lib/ui/<feature>/CHANGELOG.md`, `src/features/<feature>/CHANGELOG.md`, `packages/<name>/CHANGELOG.md`). Use `${CLAUDE_PLUGIN_ROOT}/templates/MODULE_CHANGELOG.md` as the template.
2. **Create it when you create the module.** If you change an existing module that has none, create it in the same change.
3. **Update it in the same change as the code**, never later. Edit the existing file; never create duplicates.
4. **If a change touches more than one module**, also add an entry to the app-level `docs/CHANGELOG.md` (template: `${CLAUDE_PLUGIN_ROOT}/templates/APP_CHANGELOG.md`): modules touched, what changed, why, and links to each module changelog. Single-module changes go only in that module's changelog.
5. If the project's `CLAUDE.md` names different paths, follow `CLAUDE.md`.

## What goes in a module changelog

- **Files**: the key files and how the module is wired in.
- **Current behavior**: what it does today, in a few bullets.
- **Changes (chronological)**: numbered, newest at the bottom, each with the reason.
- **Decisions & rationale**: why one option was chosen over another, and how to revert it.
- **Known gaps / ideas**: open issues, unverified assumptions, next steps.

Refresh "Current behavior" and "Known gaps" whenever they stop being true. Record decisions that are not obvious from the code. Do not paste diffs.

## Checklist before finishing a task

- [ ] Module changelog updated (or created)
- [ ] App-level changelog entry added if more than one module was touched
- [ ] "Current behavior" and "Known gaps" still accurate
