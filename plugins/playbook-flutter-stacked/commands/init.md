---
description: Add the Flutter + Stacked rules block to this project's CLAUDE.md
---
Add the Flutter + Stacked rules to the current project. Be idempotent. Do not read files from the plugin folder; everything you need is in this command.

The block to put in `CLAUDE.md` (include the marker comments exactly):

````markdown
<!-- playbook-flutter-stacked:start -->
## Flutter + Stacked rules (playbook-flutter-stacked)

- **Architecture:** strict MVVM. Service (pure calls) → Repository (business logic) → ViewModel (repository calls only) → View (widgets only). No API calls in ViewModels or Repositories.
- **Reusable widgets** live in `lib/base/widgets/` first; features reuse them.
- **UI:** size with `flutter_screenutil` (`.w .h .r .sp`); colors only from the project's color tokens; no logic in views.
- **New feature:** interfaces first, then `*_impl`; register with `injectable`; add routes to `@StackedApp`; ViewModel unit tests; run `build_runner` after codegen-affecting changes; add the feature `CHANGELOG.md`.
- **Commits:** one commit per layer (model → service/repository → base widget → feature → app/codegen); keep generated pairs together.
<!-- playbook-flutter-stacked:end -->
````

1. If the project's `CLAUDE.md` (create it if missing) already contains `<!-- playbook-flutter-stacked:start -->`, replace everything from that marker through `<!-- playbook-flutter-stacked:end -->` with the block above; otherwise append the block at the end. Never touch other parts of the file.
2. Check the project's actual package name, color-token class and base widget folder, and tell the user if they differ from the defaults named in the `flutter-stacked-architecture` and `flutter-ui-conventions` skills, so they can record them in `CLAUDE.md`.
3. Report what changed. Do not commit.
