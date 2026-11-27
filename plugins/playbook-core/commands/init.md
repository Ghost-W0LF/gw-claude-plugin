---
description: Set up playbook-core rules in this project (CLAUDE.md block + docs/CHANGELOG.md)
---
Set up the playbook-core working rules in the current project. Be idempotent. Do not read files from the plugin folder; everything you need is in this command and in the `changelog-upkeep` skill.

The block to put in `CLAUDE.md` (include the marker comments exactly):

````markdown
<!-- playbook-core:start -->
## Working rules (playbook-core)

- **Module changelogs:** every feature module has a `CHANGELOG.md` at its root. Create it with the module and update it in the same change as the code (files, current behavior, chronological changes, decisions & rationale, known gaps).
- **App-level changelog:** a change touching more than one module also gets an entry in `docs/CHANGELOG.md` (modules touched, what, why, links to module changelogs).
- **Docs in step with code:** when flow, architecture, tech or routes change, update this file (and any screens/flows doc). Keep a Docs Map section.
- **Commits:** Conventional Commits (`type(scope): description`), small logical commits, commit only when asked, never push unless asked, never commit secrets.
- **Secrets and logs:** never commit real tokens; never log secrets or personal data.
<!-- playbook-core:end -->
````

1. If the project's `CLAUDE.md` (create it if missing) already contains `<!-- playbook-core:start -->`, replace everything from that marker through `<!-- playbook-core:end -->` with the block above; otherwise append the block at the end of `CLAUDE.md`. Never touch other parts of the file.
2. If `docs/CHANGELOG.md` does not exist, create it from the app-level changelog template in the `changelog-upkeep` skill, replacing the placeholder entry with a first entry dated today that says the playbook rules were adopted. If it exists, leave it alone.
3. Find the project's existing feature/module folders. For each one without a `CHANGELOG.md`, list them for the user and ask whether to create starter changelogs from the module template in the `changelog-upkeep` skill. Do not create them without confirmation.
4. Report what was created, updated or skipped. Do not commit.
