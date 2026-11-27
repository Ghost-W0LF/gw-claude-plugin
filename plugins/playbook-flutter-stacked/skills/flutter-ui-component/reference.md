# Flutter UI component: reference

Class and token names below are illustrative. Match the names the project's base kit actually uses, and replace `<app>` with the project's package name (`package:<app>/...`).

## Folder layouts

### Reusable base widget (app-wide)

```
lib/base/widgets/<widget_name>/
├── <widget_name>.dart          # public widget (BaseFooWidget)
└── widget/                     # private sub-parts (optional)
    ├── <part_a>.dart
    └── <part_b>.dart
```

The parent composes its sub-parts; each sub-part lives in its own file.

### Feature screen (MVVM)

```
lib/ui/<area>/views/<feature>/
├── <feature>_view.dart
├── view_model/<feature>_viewmodel.dart
├── widgets/<section>_widget.dart      # feature-specific sections
├── model/<feature>_response.dart      # DTOs when needed
└── repository/                        # when the feature owns one
```

Some older screens may keep `view_model/` or widgets at the area level. Match the surrounding files when editing; do not relocate unless refactoring.

## Shared widget categories to look for

Reuse before creating new primitives. Find the concrete names with `ls lib/base/widgets` and grep.

| Category | Typical contents |
|---|---|
| Layout and shell | screen scaffold (SafeArea, optional padding), app bar, keyboard hider |
| Text | body text, title text, section title; a `TextType` size scale |
| Buttons | one `AppButton` with `.primary` / `.secondary` / `.border` variants |
| Images | network image, rounded image, SVG asset wrapper, cached image |
| Inputs | text field, dropdown, OTP input |
| State | loading indicator, empty state, error state, skeleton wrapper |
| Navigation | bottom nav bar, tab bar |
| Spacing helpers | `verticalSpaceTiny/Small/Medium/Large`, `horizontalSpace…`, `verticalSpace(h)` |

## Template: reusable widget with sub-parts

Parent, `lib/base/widgets/base_foo_widget/base_foo_widget.dart`:

```dart
import 'package:<app>/base/widgets/base_foo_widget/widget/foo_content.dart';
import 'package:<app>/base/widgets/base_foo_widget/widget/foo_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BaseFooWidget extends StatelessWidget {
  const BaseFooWidget({
    super.key,
    required this.title,
    required this.imageUrl,
    this.isDisabled = false,
    this.onTap,
  });

  final String title;
  final String imageUrl;
  final bool isDisabled;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final minHeight = 0.185.sh;
    return SizedBox(
      width: 1.sw,
      child: IntrinsicHeight(
        child: Row(
          children: [
            FooImage(imageUrl: imageUrl, minHeight: minHeight, isDisabled: isDisabled),
            Expanded(
              child: FooContent(
                title: title,
                minHeight: minHeight,
                isDisabled: isDisabled,
                onTap: onTap,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

Sub-part, `.../widget/foo_content.dart`:

```dart
class FooContent extends StatelessWidget {
  const FooContent({
    super.key,
    required this.title,
    required this.minHeight,
    required this.isDisabled,
    this.onTap,
  });

  final String title;
  final double minHeight;
  final bool isDisabled;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: minHeight),
      // Directional so it mirrors in RTL projects; plain symmetric/only is fine otherwise.
      padding: EdgeInsetsDirectional.only(start: 8.w, end: 12.w, top: 8.h),
      decoration: BoxDecoration(
        color: isDisabled ? AppColor.surfaceMuted : AppColor.surface,
        borderRadius: BorderRadiusDirectional.only(
          topEnd: Radius.circular(10.r),
          bottomEnd: Radius.circular(10.r),
        ),
        border: Border.all(color: AppColor.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BodyTextWidget(
            text: title,
            textType: TextType.medium,
            fontWeight: FontWeight.w600,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          verticalSpaceSmall,
          AppButton.primary(
            width: 100.w,
            height: 30.h,
            onTap: isDisabled ? () {} : (onTap ?? () {}),
            buttonText: 'Open',
            textType: TextType.small,
            borderRadius: 5.r,
          ),
        ],
      ),
    );
  }
}
```

## Template: feature screen with a list

Pattern: search, filters, paginated list, model mapped to a reusable widget. Logic stays in the ViewModel.

```dart
class FooView extends StackedView<FooViewModel> {
  const FooView({super.key});

  @override
  Widget builder(BuildContext context, FooViewModel viewModel, Widget? child) {
    return AppScaffold(
      addHorizontalPadding: false,
      appBar: BaseAppBar(title: 'Foo', centerTitle: true),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: AppSearchBar(
              controller: viewModel.searchController,
              onChanged: (v) => viewModel.onSearchChanged(v ?? ''),
            ),
          ),
          verticalSpaceSmall,
          Expanded(
            child: PagedListView.separated(
              pagingController: viewModel.pagingController,
              separatorBuilder: (_, __) => SizedBox(height: 16.h),
              builderDelegate: PagedChildBuilderDelegate(
                noItemsFoundIndicatorBuilder: (_) => const EmptyItemWidget(),
                itemBuilder: (context, item, index) => BaseFooWidget(
                  title: viewModel.titleText(item),   // text shaping lives in the VM
                  imageUrl: item.image ?? '',
                  isDisabled: viewModel.isExpired(item),
                  onTap: () => viewModel.onTapItem(item),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  FooViewModel viewModelBuilder(BuildContext context) => FooViewModel();
}
```

Key points:
- The view reads `viewModel` state and calls ViewModel methods on actions.
- Text transformation and rules (`titleText`, `isExpired`) live in the ViewModel.
- It reuses a base widget instead of an inline card layout.

## Template: ViewModelWidget section

A section that needs scroll controllers or ViewModel methods:

```dart
class FooRail extends ViewModelWidget<HomeViewModel> {
  const FooRail({super.key, required this.items});

  final List<Foo> items;

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    return SizedBox(
      height: 300.h,
      child: ListView.separated(
        controller: viewModel.railScrollController,
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        separatorBuilder: (_, __) => SizedBox(width: 8.w),
        itemBuilder: (context, i) => FooCard(
          title: viewModel.titleText(items[i]),
          onTap: () => viewModel.onTapItem(items[i]),
        ),
      ),
    );
  }
}
```

## Status-driven UI

```dart
viewModel.status.maybeWhen(
  loading: () => const Center(child: LoadingIndicator()),
  success: (data) => FooContent(data: data),
  failure: (reason) => ErrorView(message: reason),
  orElse: () => const SizedBox.shrink(),
)
```

Screens without an initial full-screen load should set `Status.idle()` in the ViewModel's `initialise()`.

## Common imports

```dart
import 'package:flutter_screenutil/flutter_screenutil.dart';   // sizing
import 'package:<app>/base/utils/app_color.dart';              // colors
import 'package:<app>/base/widgets/text/body_text.dart';       // text
import 'package:<app>/ui/common/ui_helpers.dart';              // spacing helpers
import 'package:stacked/stacked.dart';                         // ViewModelWidget, StackedView
// Only in localized projects:
import 'package:<app>/generated/l10n.dart';
// Only for locale checks in RTL projects:
import 'package:intl/intl.dart';
```
