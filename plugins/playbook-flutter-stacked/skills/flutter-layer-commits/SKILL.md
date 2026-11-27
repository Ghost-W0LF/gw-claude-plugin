---
name: flutter-layer-commits
description: Split Flutter feature work into one commit per architectural layer. Use together with commit-conventions whenever the user asks to commit changes that span several layers (model, service, widget, feature, codegen) in a Flutter + Stacked project.
---

# Per-layer commits (Flutter + Stacked)

Extends `commit-conventions`. When the working tree spans several layers, make **one commit per layer bucket**, even for a single feature. Combine into one commit only if the user asks.

## Order

```
model → service/repository → base widget → feature (view + viewmodel + widgets) → app/codegen
```

Add `l10n` between feature and app/codegen if the project uses generated localization. Skip layers with no changes.

| Layer | Files | Typical type |
|---|---|---|
| model | `lib/**/model/**` plus `*.freezed.dart` / `*.g.dart` | `feat` / `refactor` |
| service | `*_service.dart` (+ `.g.dart`), `*_repository.dart` + `*_repository_impl.dart` | `feat` / `refactor` |
| widget | shared widgets under `lib/base/widgets/` | `feat` / `fix` / `style` |
| feature | `<feature>_view.dart`, `view_model/`, that feature's `widgets/` | `feat` / `fix` |
| app/codegen | `lib/app/app.dart` + generated router/locator, injector config | `chore` |

| l10n (if used) | `lib/l10n/*.arb` + generated `lib/generated/**` outputs | `feat(l10n)` |

## Keep pairs together

Never split these across commits:

| Group | Stage together |
|---|---|
| Repository | `*_repository.dart` + `*_repository_impl.dart` |
| Retrofit service | `*_service.dart` + `*_service.g.dart` |
| Freezed/JSON model | `*.dart` + `*.freezed.dart` + `*.g.dart` |
| Localization | `.arb` sources + every touched generated output |
| Feature screen | `<feature>_view.dart` + `view_model/<feature>_viewmodel.dart` + that feature's `widgets/` |
| Base widget | `<widget>.dart` + its `widget/` sub-parts |

## Procedure

1. `git status`; classify every changed file into a layer.
2. For each touched layer in order: stage only that layer's files (pairs together), commit with a focused message (scope = feature folder), then `git status`.
3. Repeat until the tree is clean. Never push.

If only one layer changed, make a single commit. If a widget change is also wired through a view and ViewModel, make two: widget first, then feature.

## Example

A saved-trails feature touching service, widget, screen and codegen becomes four commits:

| # | Layer | Message |
|---|---|---|
| 1 | service | `feat(saved_trails): add local SavedTrailsService` |
| 2 | widget | `feat(base): add bookmark toggle to trail card` |
| 3 | feature | `feat(saved_trails): add saved trails screen and wire trail list` |
| 4 | app/codegen | `chore: regenerate router and locator for saved trails` |

Do not combine them unless the user asks.
