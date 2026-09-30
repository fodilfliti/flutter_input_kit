---
name: flutter-input-kit
description: >
  Use flutter_input_kit for semantic fields (EmailField, PasswordField,
  PhoneField, MoneyField, DateField, SearchField, CountryField), FieldSpec,
  ListField, country data + showCountryPicker, and code-only Validators.
  Activate for form inputs, error codes, FieldStyle, country/dial-code pickers —
  not for slang inside the kit, CustomTextField 40-param APIs, Dio, Riverpod,
  maps, or intl_phone_field.
license: MIT
metadata:
  author: fodilfliti
  version: "1.1.0"
  homepage: https://pub.dev/packages/flutter_input_kit
---

# flutter_input_kit (consumer)

## When to import

```dart
import 'package:flutter_page_kit/flutter_page_kit.dart' hide Validators;
import 'package:flutter_input_kit/flutter_input_kit.dart';
```

Use this package for:

- Semantic fields bound to `PageData.text()` / `money()` / `date()` / `flag()`
- `Validators` that return **codes** (`required`, `email`, `minLength`, …)
- `FieldSpec` + `FieldStyle` (outline / underline / corner)
- `ListField<T>` dynamic rows
- Mapping codes → copy at the **call site** (`errorText: (code) => t.error(code)`)
- Countries: `Countries.all` / `byIso` / `byDialCode` / `search`, `Country.flag`
  (emoji, no assets), `showCountryPicker` / `CountryPickerList`

## Country + dial code

Do not copy country lists into apps. Use the kit data and picker:

```dart
CountryField(
  c.country,
  code: c.countryIso,
  label: t.country,
  onTap: () async {
    final picked = await showCountryPicker(
      context,
      selected: c.countryIso.value,
      favorites: const ['DZ', 'FR'],
      searchHint: t.search,
      emptyText: t.noResults,
      nameOf: (country) => t.countries[country.iso2] ?? country.name,
    );
    if (picked == null) return;
    c.country.controller.text = picked.name;
    c.countryIso.controller.text = picked.iso2;
    c.dial.controller.text = picked.dialCodeWithPlus; // PhoneField dialCode
  },
)
```

## Rules

- Do **not** call slang / `.tr()` inside fields. Pass already-translated `label` / `hint` / `errorText`.
- Put validators on the `FieldText` in the controller, not as 40 widget params.
- Invalid form → inline `showErrors` / `errorText` only. Never toast “check the form”.
- Hide page_kit `Validators` when both barrels are imported; this kit owns the rich set.

## Do not put in input_kit

| Concern | Where |
| --- | --- |
| PageData / shells / busy / Notices | `flutter_page_kit` |
| AppFailure / Disposables | `lemsa_core_kit` |
| Dio / Supabase / Firebase / Drift | `flutter_data_kit_*` |
| auto_route | `flutter_nav_kit` |
| slang strings / `.tr()` | app |
| `intl_phone_field`, maps | app (`AddressField` / `PhoneField` are plain text) |
| Country names in other languages | app (`nameOf:` from your translations) |
| Riverpod | app / page_kit riverpod barrel |

## Quick example

```dart
late final email = text(
  validators: [Validators.required, Validators.email],
);

EmailField(
  email,
  label: t.email,
  showErrors: showFieldErrors,
  errorText: (code) => t.error(code),
)
```
