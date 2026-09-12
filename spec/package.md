# flutter_input_kit

Semantic form fields and composable validators. Replaces `CustomTextField` (~40 params) and per-type `*InputWidget` wrappers.

## Public surface

| Export | Contents |
| --- | --- |
| `flutter_input_kit.dart` | `Validators`, `ErrorCodes`, `FieldSpec`, `FieldStyle`, `InputField`, semantic fields, `ListField`, date/money validatable adapters |

Re-exports from `flutter_page_kit`: `FieldValidator`, `Validatable`, `FieldText`, `FieldFlag`, `FieldMoney`, `FieldDate`, `FieldItems`.

## Layers

| Layer | Path | Role |
| --- | --- | --- |
| Barrel | `lib/flutter_input_kit.dart` | Only public export |
| Validators | `lib/src/validators/` | Pure functions → error codes |
| Spec | `lib/src/spec/` | `FieldSpec` + `FieldStyle` |
| Fields | `lib/src/fields/` | One `InputField` tree; semantic wrappers; `ListField` |

## Depends on

`lemsa_core_kit`, `flutter_page_kit`, `flutter_scale_kit`, `flutter_scale_theme_kit`.

## Must not depend on

`dio`, `supabase_flutter`, `firebase_*`, `drift`, `flutter_riverpod`, `hooks_riverpod`, `slang`, `intl_phone_field`, maps SDKs.

## v1 fields

Shipped: `EmailField`, `PasswordField`, `PhoneField`, `MoneyField`, `DateField`, `SearchField`, `InputField` (general).

Stub (picker trigger, no vendor picker): `CountryField`, `AddressField`.

Deferred: `dart run flutter_input_kit:gen fields …`
