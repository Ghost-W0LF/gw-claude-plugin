<!-- playbook-flutter-stacked:start -->
## Flutter + Stacked rules (playbook-flutter-stacked)

- **Architecture:** strict MVVM. Service (pure calls) → Repository (business logic) → ViewModel (repository calls only) → View (widgets only). No API calls in ViewModels or Repositories.
- **Reusable widgets** live in `lib/base/widgets/` first; features reuse them.
- **UI:** size with `flutter_screenutil` (`.w .h .r .sp`); colors only from the project's color tokens; no logic in views.
- **New feature:** interfaces first, then `*_impl`; register with `injectable`; add routes to `@StackedApp`; ViewModel unit tests; run `build_runner` after codegen-affecting changes; add the feature `CHANGELOG.md`.
- **Commits:** one commit per layer (model → service/repository → base widget → feature → app/codegen); keep generated pairs together.
<!-- playbook-flutter-stacked:end -->
