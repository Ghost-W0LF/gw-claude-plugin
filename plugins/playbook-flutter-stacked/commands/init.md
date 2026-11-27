---
description: Add the Flutter + Stacked rules block to this project's CLAUDE.md
---
Add the Flutter + Stacked rules to the current project. Be idempotent.

1. Read `${CLAUDE_PLUGIN_ROOT}/templates/CLAUDE.flutter.md`. If the project's `CLAUDE.md` (create it if missing) already contains `<!-- playbook-flutter-stacked:start -->`, replace the text between `<!-- playbook-flutter-stacked:start -->` and `<!-- playbook-flutter-stacked:end -->` with the template's block; otherwise append the block at the end. Never touch other parts of the file.
2. Check the project's actual package name, color-token class and base widget folder, and tell the user if they differ from the defaults named in the `flutter-stacked-architecture` and `flutter-ui-conventions` skills, so they can record them in `CLAUDE.md`.
3. Report what changed. Do not commit.
