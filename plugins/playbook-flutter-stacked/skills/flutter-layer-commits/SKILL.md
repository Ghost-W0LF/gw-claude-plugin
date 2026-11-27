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

## Keep pairs together

Never split these across commits: repository + impl, service + `.g.dart`, model + `.freezed.dart`/`.g.dart`, localization source + generated output.

## Procedure

1. `git status`; classify every changed file into a layer.
2. For each touched layer in order: stage only that layer's files, commit with a focused message (scope = feature folder), then `git status`.
3. Repeat until the tree is clean. Never push.
