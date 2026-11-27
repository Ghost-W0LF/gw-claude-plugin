<!-- playbook-core:start -->
## Working rules (playbook-core)

- **Module changelogs:** every feature module has a `CHANGELOG.md` at its root. Create it with the module and update it in the same change as the code (files, current behavior, chronological changes, decisions & rationale, known gaps).
- **App-level changelog:** a change touching more than one module also gets an entry in `docs/CHANGELOG.md` (modules touched, what, why, links to module changelogs).
- **Docs in step with code:** when flow, architecture, tech or routes change, update this file (and any screens/flows doc). Keep a Docs Map section.
- **Commits:** Conventional Commits (`type(scope): description`), small logical commits, commit only when asked, never push unless asked, never commit secrets.
- **Secrets and logs:** never commit real tokens; never log secrets or personal data.
<!-- playbook-core:end -->
