---
name: flutter-ui-component
description: Build Flutter UI components and screens following shared-kit conventions: flutter_screenutil sizing, color tokens, base widgets, optional l10n/RTL, and MVVM separation with Stacked. Use when creating or editing widgets, views, screens, UI sections, reusable components or feature layouts under lib/base/widgets or lib/ui.
---

# Flutter UI component

> **TL;DR, 3 rules:** (1) size with `.w / .h / .r / .sp`, (2) colors from the project's color tokens only, (3) no logic in views.

Extends `flutter-ui-conventions` with the detailed how-to. If the project's `CLAUDE.md` names its own tokens, widgets or folders, those win over the examples here.

## Quick start

- **Adding a button or text to an existing screen?** Copy the closest skeleton from [Quick templates](#quick-templates).
- **Building a new reusable widget or screen?** Read [Must do](#must-do), [Component type](#component-type), [Common patterns](#common-patterns).
- **Wondering whether a widget already exists?** See [Discover before you build](#discover-before-you-build) and the layouts and templates in [reference.md](reference.md).

## Must do

1. **Size with `flutter_screenutil`**: `.w / .h / .r / .sp`, and `.sh / .sw` for screen fractions. Never raw pixels.
2. **Color from the project's color tokens** (for example `AppColor`). Never hardcode `Color(0x…)` or `Colors.*` in UI files.
3. **No logic in views or widgets**: no API calls, no business rules. Read state from the ViewModel and call `viewModel.method()` on actions.

## Discover before you build

1. List `lib/base/widgets/` and grep for the widget you need. Reuse or extend before writing new.
2. Typical shared pieces to look for: scaffold, app bar, body/title text, buttons, text fields, dropdowns, image variants, loading, empty and error states, skeletons, bottom nav, spacing helpers.
3. Pick the [component type](#component-type) and the [location](#where-to-put-files).

## Component type

ViewModels use `stacked`: they call `notifyListeners` and the bound UI rebuilds.

| Need | Use |
|---|---|
| Pure display, callbacks only | `StatelessWidget` with constructor params |
| Needs ViewModel state or methods | `ViewModelWidget<YourViewModel>` (reads the same ViewModel from the tree) |
| Full screen | the project's stacked view base (for example `StackedView<T>` / `BaseStackedView<T>`); UI only in `builder`, actions delegated to the ViewModel |

**Never** pass a ViewModel instance into a child widget by hand. Use `ViewModelWidget<T>`.

## Where to put files

| Scope | Path |
|---|---|
| App-wide reusable widget | `lib/base/widgets/<name>/<name>.dart` |
| Its private sub-parts | `lib/base/widgets/<name>/widget/` |
| Feature screen | `lib/ui/<area>/views/<feature>/<feature>_view.dart` |
| Feature ViewModel | `.../<feature>/view_model/<feature>_viewmodel.dart` |
| Feature UI sections | `.../<feature>/widgets/` |

A new reusable widget goes to `lib/base/widgets/` first, then features use it.
**Naming:** `snake_case.dart`, one public PascalCase class matching the file stem (`trail_view.dart` → `TrailView`).

## Common patterns

### Sizing

```dart
// GOOD
width: 100.w, height: 30.h, borderRadius: BorderRadius.circular(10.r), fontSize: 16.sp
constraints: BoxConstraints(minHeight: 0.185.sh)
width: 1.sw // full screen width

// BAD: raw pixels
width: 100, height: 30
```

### Colors and layout tokens

Use the project's color file (for example `lib/base/utils/app_color.dart`) and layout tokens (radii, side margins, button heights). If a color is truly new, add it to the token file instead of inlining it.

### Text, buttons, spacing, screens

Use the project's shared widgets rather than raw `Text`, `ElevatedButton` or `Scaffold`: they carry app font, sizing and (if used) RTL handling. Prefer the spacing helpers over inline `SizedBox`.

```dart
return AppScaffold(
  appBar: BaseAppBar(title: 'Trails'),
  body: Column(children: [
    BodyTextWidget(text: title, textType: TextType.medium, maxLines: 1, overflow: TextOverflow.ellipsis),
    verticalSpaceSmall,
    AppButton.primary(onTap: viewModel.onStart, buttonText: 'Start', height: 48.h),
  ]),
);
```

Names above are illustrative; use whatever the project's base kit calls them.

### Localization (only if the project uses it)

- With a `BuildContext` (widgets): `S.of(context).key`. Without one (ViewModels, helpers): `S.current.key`.
- Never hardcode user-facing strings in a localized project.
- If the project has no l10n yet, plain strings are fine; do not introduce l10n unasked.

### RTL (only if the project supports RTL locales)

Use directional APIs so layouts mirror:

```dart
padding: EdgeInsetsDirectional.only(start: 16.w, end: 8.w)   // not EdgeInsets.only(left:, right:)
PositionedDirectional(top: 0, start: 0, end: 0)
BorderRadiusDirectional.only(topStart: Radius.circular(10.r))
AlignmentDirectional.topStart
```

### Images

Use the project's image widgets (cached network image, rounded image, SVG asset wrapper). Decode at display size (`cacheWidth` / `memCacheWidth`) for list thumbnails and avatars.

### Status-driven UI

```dart
viewModel.status.maybeWhen(
  loading: () => const LoadingIndicator(),
  success: (data) => FooBody(data: data),
  failure: (reason) => ErrorView(message: reason),
  orElse: () => const SizedBox.shrink(),
)
```

Views render success data only; the ViewModel owns the `Status`.

### MVVM boundaries

**Views and widgets must not** call repositories or services, make API calls, or contain business rules (expiry checks, filter logic).
**They should** read state from `viewModel`, call `viewModel.someMethod()` on actions, and map model fields to constructor params in `itemBuilder`.

```dart
// GOOD
onTap: () => viewModel.onTapTrail(item.id)
// BAD
onTap: () async { final r = await repo.getTrail(); }
```

## File size

Keep view files around 90-110 lines; extract sections as you approach ~110 (a guideline, not a hard cutoff). Reusable parts go to a `widget/` subfolder, feature sections to `widgets/`.

## Creation checklist

```
- [ ] Searched lib/base/widgets/ for an existing widget
- [ ] Chose StatelessWidget vs ViewModelWidget vs stacked view
- [ ] Placed the file in the right folder
- [ ] Used .w/.h/.r/.sp and color tokens only
- [ ] Used shared text/button/spacing widgets
- [ ] Strings localized (if the project uses l10n); directional APIs (if RTL)
- [ ] No API or business logic in view/widget
- [ ] File ≤ ~110 lines or sub-widgets extracted
```

## Quick templates

**Reusable widget**

```dart
class BaseFooWidget extends StatelessWidget {
  const BaseFooWidget({super.key, required this.title, this.onTap});
  final String title;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColor.surface,            // use a real token
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: BodyTextWidget(text: title, textType: TextType.medium),
    );
  }
}
```

**ViewModel-dependent section**

```dart
class FooSection extends ViewModelWidget<FooViewModel> {
  const FooSection({super.key});

  @override
  Widget build(BuildContext context, FooViewModel viewModel) {
    return Column(children: [
      BodyTextWidget(text: viewModel.sectionTitle, textType: TextType.large),
      verticalSpaceSmall,
      // ...
    ]);
  }
}
```

A full screen skeleton and larger templates are in [reference.md](reference.md).

## Anti-patterns

| Avoid | Do instead |
|---|---|
| Raw `Text`, `ElevatedButton`, `Scaffold` | the base kit's text, button and scaffold widgets |
| `EdgeInsets.only(left: …)` in an RTL project | `EdgeInsetsDirectional.only(start: …)` |
| Hardcoded user-facing strings in a localized project | `S.of(context)` / `S.current` |
| API calls in a view | a ViewModel method |
| Passing a ViewModel to a constructor | `ViewModelWidget<T>` |
| Monolithic 200+ line view files | extract to `widgets/` |
| New color constants inside UI files | add to the color token file |
