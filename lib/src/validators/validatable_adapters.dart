import 'package:flutter_input_kit/src/validators/validators.dart';
import 'package:flutter_page_kit/flutter_page_kit.dart' hide Validators;

/// Wraps `FieldDate` so it can join `PageData.validated`.
class DateValidatable implements Validatable {
  DateValidatable(
    this.field, {
    List<DateValidator>? validators,
  }) : validators = validators ?? [Validators.dateRequired];

  final FieldDate field;
  final List<DateValidator> validators;

  @override
  String? get errorCode {
    for (final rule in validators) {
      final error = rule(field.value);
      if (error != null) {
        return error;
      }
    }
    return null;
  }

  @override
  bool get isValid => errorCode == null;
}

/// Wraps `FieldMoney` so it can join `PageData.validated`.
class MoneyValidatable implements Validatable {
  MoneyValidatable(
    this.field, {
    List<FieldValidator>? validators,
  }) : validators = validators ?? [Validators.money];

  final FieldMoney field;
  final List<FieldValidator> validators;

  @override
  String? get errorCode => Validators.all(field.text, validators);

  @override
  bool get isValid => errorCode == null;
}
