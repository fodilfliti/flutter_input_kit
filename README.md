# flutter_input_kit

Semantic form fields and **code-only** validators for Lemsa apps. Depends on [`flutter_page_kit`](../flutter_page_kit), [`lemsa_core_kit`](../lemsa_core_kit), [`flutter_scale_kit`](../flutter_scale_kit), and [`flutter_scale_theme_kit`](../flutter_scale_theme_kit).

## Install

Path dependency while siblings are unpublished:

```yaml
dependencies:
  flutter_input_kit:
    path: ../flutter_input_kit
```

```dart
import 'package:flutter_page_kit/flutter_page_kit.dart' hide Validators;
import 'package:flutter_input_kit/flutter_input_kit.dart';
```

## Owns

- `Validators` / `ErrorCodes` — pure functions, machine codes only
- `FieldSpec` + `FieldStyle` — bind a `FieldText` to label, keyboard, obscure, look
- Semantic fields: `EmailField`, `PasswordField`, `PhoneField`, `MoneyField`, `DateField`, `SearchField`
- `InputField` — general text field (one visual tree)
- `ListField<T>` — dynamic rows
- Stubs: `CountryField`, `AddressField` (read-only + `onTap`; app supplies the picker)

## Does not own

Page controllers (`flutter_page_kit`), failures (`lemsa_core_kit`), slang, country/phone vendor widgets, maps, Riverpod, Dio.

## Validation / i18n

```dart
late final email = text(
  validators: [Validators.required, Validators.email],
);

EmailField(
  email,
  label: t.email, // already translated
  showErrors: showFieldErrors,
  errorText: (code) => t.error(code), // map code → string at call site
)
```

Fields never call `.tr()` / slang.

## Schema gen

`dart run flutter_input_kit:gen fields …` is **deferred**. Hand-write `FieldText` + semantic widgets for v1.
