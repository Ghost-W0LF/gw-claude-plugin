---
name: flutter-stacked-architecture
description: Strict MVVM architecture for Flutter apps using Stacked, injectable and get_it. Use when adding or changing a feature, screen, ViewModel, repository, service, route or dependency registration in a Flutter project that uses Stacked.
---

# Flutter + Stacked architecture

## Layers (strict)

- **View**: widgets only, no logic.
- **ViewModel**: business logic and state. Calls repository functions only.
- **Repository**: calls service functions plus business logic. No direct API calls.
- **Service**: pure API/data calls. No business logic.
- **Base**: UI kit, helpers, shared models, storage, mixins.
- **DI**: `injectable` + `get_it`. **Routing and UI services**: `stacked_services` (navigation, dialogs, bottom sheets).

Flow: **Service** (pure calls) → **Repository** (service + business logic) → **ViewModel** (repository calls) → **View** (renders `Status` data).

Rules:
1. No API calls in ViewModels; use repositories.
2. No API calls in repositories; use services.
3. Reusable widgets live under `base/widgets/` first, then features use them.
4. Feature folders are isolated and share the same internal structure.

## Feature structure

```
lib/ui/<feature>/
  views/<name>/{<name>_view.dart, view_model/, model/, repository/, widgets/}
  services/            # data access for the feature
  CHANGELOG.md         # required, see the changelog-upkeep skill
```

Shared code: `lib/base/{models,services,utils,widgets}`, `lib/network/`, `lib/app/app.dart` (`@StackedApp` routes, dialogs, sheets, DI).

## ViewModel responsibilities

- Invoke repositories only.
- Emit `Status` (`Idle/Loading/Success/Failure`) to drive the UI; views render success data only.
- Own permission requests through a permission helper.
- Be idempotent: handle duplicate taps safely.

## New feature checklist

1. Create the `/ui/<feature>/` subfolders (`service/`, `repository/`, `viewmodel/`, `model/`, `views/`, `widgets/`).
2. Define interfaces first (`repository.dart`, `service.dart`), then `*_impl.dart`.
3. Register interfaces and implementations with `injectable`.
4. Add routes to `@StackedApp` in `app/app.dart`.
5. Use the base UI kit; no ad-hoc widgets inside features.
6. Add ViewModel unit tests with mocked repositories.
7. Add `CHANGELOG.md` at the feature root; update it with every change (and `docs/CHANGELOG.md` if more than one module is touched).
8. Run code generation after changing routes, injectables, Retrofit services or Freezed models:
   `flutter pub run build_runner build --delete-conflicting-outputs`

If the project's `CLAUDE.md` differs from these defaults (package name, folder names, versions), `CLAUDE.md` wins.
