# Decisions

## D1 — FieldSpec, not a 40-parameter widget

**Choice:** Semantic fields take `FieldText` (or `FieldSpec`) plus a short presentation set (label, hint, style, showErrors, errorText mapper).

**Why:** `CustomTextField` in the reference apps grew ~40 optional params. Binding lives on `PageData` handles; look is `FieldStyle`.

**Do not:** Recreate `CustomTextField` with every decoration flag as a constructor argument.

## D2 — Error codes, not messages

**Choice:** `Validators` return codes (`required`, `email`, `minLength`, …). Apps map codes to slang at the call site.

**Why:** Kits never localize (family rule). Page_kit already stores `Validatable.errorCode`.

**Do not:** Import slang or call `.tr()` inside this package.

## D3 — One InputField tree

**Choice:** `FieldStyle.outline` / `underline` / `corner` are variants of `InputField`.

**Why:** Corner-label in the reference apps was a separate `LabelCorner` tree. An enum keeps one decoration path.

## D4 — No vendor pickers in v1

**Choice:** `PhoneField` is a phone keyboard + optional dial-code prefix. `CountryField` / `AddressField` are read-only triggers with `onTap`. `DateField` uses Material `showDatePicker`.

**Why:** `intl_phone_field`, `country_code_picker`, and Google Maps belong in the app, not this kit.

## D5 — Schema gen deferred

**Choice:** `dart run flutter_input_kit:gen fields …` is documented, not shipped in v1.

**Why:** Core fields + validators are the T12 acceptance bar. CLI follows the `generate_core.dart` (no `dart:io`) pattern when it lands.

## D6 — Rich Validators live here

**Choice:** This package owns the expanded `Validators` surface. `flutter_page_kit` keeps a thin copy for `validateForm` until apps switch imports.

**Why:** Page_kit D4 explicitly parked rich rules here. Import with `hide Validators` on the page_kit barrel when both are used.
