---
name: changelog-upkeep
description: Keep per-module and app-level CHANGELOG.md files up to date. Use whenever you add, change, remove or make a decision about a feature module, screen or package, when creating a new module, or when a change touches more than one module.
---

# Changelog upkeep

Every feature module keeps a living `CHANGELOG.md` at its root. Changes that span modules also go in one app-level changelog.

## Rules

1. **Each module has its own `CHANGELOG.md`** at the module root (for example `lib/ui/<feature>/CHANGELOG.md`, `src/features/<feature>/CHANGELOG.md`, `packages/<name>/CHANGELOG.md`). Use the module template below.
2. **Create it when you create the module.** If you change an existing module that has none, create it in the same change.
3. **Update it in the same change as the code**, never later. Edit the existing file; never create duplicates.
4. **If a change touches more than one module**, also add an entry to the app-level `docs/CHANGELOG.md` (template below): modules touched, what changed, why, and links to each module changelog. Single-module changes go only in that module's changelog.
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

## Templates

Module changelog (`<module>/CHANGELOG.md`):

````markdown
# <Module name> — changes & decisions

Living log for this module (`<path/to/module>/`). **Update this file whenever the module changes.** Newest entries go at the bottom of each section.

## Files

- `<path/to/main_file>` — what it does.
- Embedded or used by: `<other module or entry point>`.

## Current behavior

- <What the module does today, one bullet per behavior.>

## Changes (chronological)

1. **<Short title>.** <What changed and why.>

## Decisions & rationale

- **<Decision>:** <why this option; how to revert it.>

## Known gaps / ideas

- <Open issue, unverified assumption, or next step.>
````

App-level changelog (`docs/CHANGELOG.md`):

````markdown
# App-level changelog

Cross-module changes: anything that touches **more than one** feature module (or app/shared code plus a feature). Single-module changes go only in that module's own `CHANGELOG.md`. **Update this file in the same change.** Newest entries at the bottom.

Entry format: `### <date> — <title>` · modules touched · what changed · why · links to each module changelog.

---

### <YYYY-MM-DD> — <title>
- **Modules:** `<module-a>`, `<module-b>`
- **What:** <what changed across the modules>
- **Why:** <the reason>
- **Details:** `<path/to/module-a/CHANGELOG.md>`, `<path/to/module-b/CHANGELOG.md>`
````
