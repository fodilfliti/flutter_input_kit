# flutter_input_kit

[![pub package](https://img.shields.io/pub/v/flutter_input_kit.svg)](https://pub.dev/packages/flutter_input_kit)

Semantic form fields and **code-only** validators for Lemsa apps.

**Platforms:** Android, iOS, Linux, macOS, Web, Windows  
**Requires:** Flutter `>=3.44.0`

## Install

```yaml
dependencies:
  flutter_input_kit: ^1.0.0
  flutter_page_kit: ^1.0.0
  lemsa_core_kit: ^1.0.0
  flutter_scale_kit: ^2.0.2
  flutter_scale_theme_kit: ^1.0.2
```

```dart
import 'package:flutter_page_kit/flutter_page_kit.dart' hide Validators;
import 'package:flutter_input_kit/flutter_input_kit.dart';
```

## Owns

- `Validators` / `ErrorCodes` — pure functions, machine codes only
- `FieldSpec` + `FieldStyle`
- Semantic fields: `EmailField`, `PasswordField`, `PhoneField`, `MoneyField`, `DateField`, `SearchField`, …
- `ListField<T>` — dynamic rows

Labels and `errorText` are localized at the **call site** (e.g. slang), not inside fields.

## Agent skill

```bash
npx skills add fodilfliti/flutter_input_kit
# or: npx skills add fodilfliti/lemsa-skills
```

## Links

- [GitHub](https://github.com/fodilfliti/flutter_input_kit)
- [Lemsa skills](https://github.com/fodilfliti/lemsa-skills)
