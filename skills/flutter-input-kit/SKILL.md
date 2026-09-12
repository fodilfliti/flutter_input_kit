---
name: flutter-input-kit
description: >
  Use flutter_input_kit for semantic fields (EmailField, PasswordField,
  PhoneField, MoneyField, DateField, SearchField), FieldSpec, ListField, and
  code-only Validators. Activate for form inputs, error codes, FieldStyle —
  not for slang inside the kit, CustomTextField 40-param APIs, Dio, Riverpod,
  maps, or intl_phone_field.
license: MIT
metadata:
  author: fodilfliti
  version: "0.0.1"
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
| `intl_phone_field`, maps, country picker UI | app (`CountryField` / `AddressField` / `PhoneField` are triggers or plain text) |
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
