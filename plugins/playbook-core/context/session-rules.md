Working rules from the playbook-core plugin (apply unless this project's CLAUDE.md says otherwise):
- Every feature module has its own CHANGELOG.md at its module root. Create it with the module; update it in the same change as the code (see the changelog-upkeep skill).
- A change touching more than one module also gets an entry in the app-level docs/CHANGELOG.md.
- When flow, architecture, tech or routes change, update CLAUDE.md (and any screens/flows doc) in the same change.
- Commits: Conventional Commits, small logical commits, only when asked, never push unless asked, never commit secrets (see commit-conventions skill).
- Never commit real tokens or log secrets/personal data.
