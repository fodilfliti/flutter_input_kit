# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.0.1] - 2026-09-12

### Added

- `Validators` / `ErrorCodes` — code-only rules (required, email, password, phone, money, minAge, …).
- `FieldSpec`, `FieldStyle`, and `InputField` (outline / underline / corner).
- Semantic fields: `EmailField`, `PasswordField`, `PhoneField`, `MoneyField`, `DateField`, `SearchField`.
- Stubs: `CountryField`, `AddressField` (picker trigger).
- `ListField<T>` for dynamic rows.
- `DateValidatable` / `MoneyValidatable` adapters for `PageData.validated`.
- Example form using `PageData` + scale/theme kits.

### Deferred

- `dart run flutter_input_kit:gen fields …`
