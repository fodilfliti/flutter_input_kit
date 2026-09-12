/// Semantic form fields and code-only validators.
///
/// Import only this library:
/// ```dart
/// import 'package:flutter_input_kit/flutter_input_kit.dart';
/// ```
library;

export 'package:flutter_page_kit/flutter_page_kit.dart'
    show
        FieldDate,
        FieldFlag,
        FieldItems,
        FieldMoney,
        FieldText,
        FieldValidator,
        Validatable;

export 'src/fields/address_field.dart';
export 'src/fields/country_field.dart';
export 'src/fields/date_field.dart';
export 'src/fields/email_field.dart';
export 'src/fields/input_field.dart';
export 'src/fields/list_field.dart';
export 'src/fields/money_field.dart';
export 'src/fields/password_field.dart';
export 'src/fields/phone_field.dart';
export 'src/fields/search_field.dart';
export 'src/spec/field_spec.dart';
export 'src/spec/field_style.dart';
export 'src/validators/error_codes.dart';
export 'src/validators/validatable_adapters.dart';
export 'src/validators/validators.dart';
