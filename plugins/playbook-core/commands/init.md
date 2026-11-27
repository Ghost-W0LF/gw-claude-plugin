---
description: Set up playbook-core rules in this project (CLAUDE.md block + docs/CHANGELOG.md)
---
Set up the playbook-core working rules in the current project. Be idempotent.

1. Read `${CLAUDE_PLUGIN_ROOT}/templates/CLAUDE.core.md`. If the project's `CLAUDE.md` (create it if missing) already contains the marker `<!-- playbook-core:start -->`, replace the text between `<!-- playbook-core:start -->` and `<!-- playbook-core:end -->` with the template's block; otherwise append the block at the end of `CLAUDE.md`. Never touch other parts of the file.
2. If `docs/CHANGELOG.md` does not exist, create it from `${CLAUDE_PLUGIN_ROOT}/templates/APP_CHANGELOG.md`, replacing the placeholder entry with a first entry dated today that says the playbook rules were adopted. If it exists, leave it alone.
3. Find the project's existing feature/module folders. For each one without a `CHANGELOG.md`, list them for the user and ask whether to create starter changelogs from `${CLAUDE_PLUGIN_ROOT}/templates/MODULE_CHANGELOG.md`. Do not create them without confirmation.
4. Report what was created, updated or skipped. Do not commit.
