---
name: flutter-ui-conventions
description: UI conventions for Flutter apps with a shared design-token kit. Use when writing or editing widgets, screens, themes, colors, spacing or text styles in a Flutter project.
---

# Flutter UI conventions

- **Sizing**: use `flutter_screenutil` (`.w .h .r .sp`). Never raw pixel values in UI code.
- **Colors**: only from the project's color tokens (for example `AppColor`). Never hardcode `Color(0x…)` or `Colors.*` in UI.
- **Theme and layout tokens**: use the central theme and layout helpers (radii, side margins, button heights) instead of inventing values.
- **No logic in views or widgets**: read state from the ViewModel and call ViewModel methods.
- **Reuse first**: check `base/widgets/*` (buttons, fields, app bars, loaders, scaffolds) before creating anything. A new reusable widget goes into `base/widgets/` first, then features use it.
- **Fonts**: bundle fonts in assets; no runtime font fetching.
- **Maps and platform views**: keep platform views mounted (do not recreate on state changes) and avoid building them before the screen is needed, since native startup is costly.

If the project documents its own tokens in `CLAUDE.md`, follow those names and values.
