---
name: commit-conventions
description: Conventional Commits rules and git safety for this project. Use whenever the user asks to commit, create a git commit, write a commit message, or mentions /commit. Commits only; never pushes unless asked.
---

# Commit conventions

## Format

```
<type>(optional scope): <description>

[optional body]

[optional footer(s)]
```

| Type | Purpose |
|---|---|
| `feat` | New feature |
| `fix` | Bug fix |
| `refactor` | Restructure with no behavior change |
| `perf` | Performance improvement |
| `style` | Formatting only |
| `test` | Add or update tests |
| `docs` | Documentation only (including changelogs) |
| `build` | Build system, dependencies |
| `ci` | CI and config |
| `chore` | Maintenance, codegen, lockfiles |
| `revert` | Revert a commit |

- **Scope**: the feature or module folder (`home`, `trail_detail`) or a shared area (`base`, `network`). Omit it for repo-wide changes. Match scopes already used in `git log`.
- **Description**: present tense, imperative ("add", not "added"), under 72 characters.
- Breaking changes: `feat!:` or a `BREAKING CHANGE:` footer.

## Diff to type

Read the diff, then pick the most specific match.

| Diff signal | Type |
|---|---|
| Only `*.md`, docs, changelogs or agent skill/rule files | `docs` |
| Only test files (`*_test.*`, `test/`, `integration_test/`) | `test` |
| Dependency manifests, lockfiles, Gradle/Podfile, build config | `build` |
| CI workflows, fastlane | `ci` |
| New screen, widget, endpoint or user-facing behavior | `feat` |
| Corrects broken behavior | `fix` |
| Renames or restructures with no behavior change | `refactor` |
| Whitespace, formatting, lint-only | `style` |
| Dependency bumps, codegen-only, lockfile-only | `chore` |

Scope: lowercase and short, reusing scopes already in `git log`. Omit it when a change spans many modules or the whole repo (`chore: update flutter sdk`).

## Workflow

1. Run `git status`, `git diff` (or `git diff --staged`) and `git log --oneline -n 20` in parallel. Match the repo's existing style.
2. Choose type and scope from the actual diff.
3. Prefer **small commits**: one logical change per commit. Keep generated pairs together (source plus its generated output, interface plus implementation).
4. Commit, then run `git status` to confirm what remains.
5. Use `git add -p` only to split hunks **within** one file, never to separate files that belong together.

Multi-line messages: pass the body on stdin (`git commit -F - <<'EOF' … EOF`), not inside `$(...)`. Reference issues in the footer (`Closes #123`, `Refs #456`).

## Safety

- **Only commit when the user explicitly asks.** Never push unless asked.
- Never commit secrets (`.env`, credentials, private keys, tokens). Warn the user if they ask for it.
- Never run destructive commands (`--force`, hard reset) or skip hooks (`--no-verify`) without an explicit request.
- Never update git config. Never create empty commits. Never force-push to main/master.
- If a hook rejects a commit, fix the problem and make a **new** commit. Amend only when a hook auto-modified files from a commit you just made and have not pushed.
- Follow any attribution or footer rules the session or `CLAUDE.md` gives (for example co-author lines).

Stack packs may add finer rules, such as splitting a feature into one commit per architectural layer.
