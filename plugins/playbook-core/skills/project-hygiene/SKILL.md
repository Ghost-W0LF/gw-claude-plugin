---
name: project-hygiene
description: Project documentation and safety hygiene. Use when changing architecture, flow, routes, tech stack or build setup, adding logging, handling tokens or secrets, or deciding whether docs need updating.
---

# Project hygiene

## Keep docs in step with code

- When you change architecture, flow, tech or routes, **update `CLAUDE.md`** in the same change. If the project has a screens/flows doc, update it for screen or route changes.
- Keep a **Docs Map** section in `CLAUDE.md` that lists where each doc lives. Add new docs to it.
- Record cross-module changes in the app-level `docs/CHANGELOG.md` and per-module changes in each module's `CHANGELOG.md` (see the `changelog-upkeep` skill).
- Do not duplicate what the code or git history already shows. Docs capture intent, decisions and gaps.

## Secrets and logging

- Never commit real tokens, keys or credentials. Use build-time defines or environment config, and keep example files for the shape.
- Do not log secrets or user personal data. Tag log lines with the class or module name.
- Warn the user before touching files likely to contain secrets.

## Scope discipline

- Do the requested change; mention adjacent problems instead of silently fixing them.
- Prefer reusing existing helpers and shared components over adding new ones.
- State plainly what you verified and what you did not (for example "analyzer passes, not run on a device").
