import 'package:flutter_input_kit/src/validators/error_codes.dart';
import 'package:flutter_page_kit/flutter_page_kit.dart' show FieldValidator;
import 'package:lemsa_core_kit/lemsa_core_kit.dart';

typedef DateValidator = String? Function(DateTime? value);

/// Pure field validators. Returns an error **code**, never a translated string.
///
/// Compose with [all]. Empty optional fields return `null` unless the rule
/// itself requires a value (`required`, `name`, `password`, …).
abstract final class Validators {
  static String? required(String v) =>
      v.trim().isEmpty ? ErrorCodes.required : null;

  static FieldValidator minLength(int n) =>
      (v) => v.trim().length < n ? ErrorCodes.minLength : null;

  static FieldValidator maxLength(int n) =>
      (v) => v.trim().length > n ? ErrorCodes.maxLength : null;

  static final RegExp _email = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+\/=?^_`{|}~-]+@"
    r'[a-zA-Z0-9]+\.[a-zA-Z]+$',
  );

  /// Invalid when non-empty and not an email. Compose with [required].
  static String? email(String v) {
    final trimmed = v.trim();
    if (trimmed.isEmpty) {
      return null;
    }
    return _email.hasMatch(trimmed) ? null : ErrorCodes.email;
  }

  static final RegExp _password = RegExp(
    r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)'
    r'(?=.*[@$!%*?&#^()\-_=+\[\]{}|;:,.<>~`/\\])'
    r'[A-Za-z\d@$!%*?&#^()\-_=+\[\]{}|;:,.<>~`/\\]{8,}$',
  );

  /// Strict password (signup / change): min 8, upper, lower, digit, special.
  static String? password(String v) {
    if (v.isEmpty) {
      return ErrorCodes.required;
    }
    if (v.length < 8) {
      return ErrorCodes.minLength;
    }
    return _password.hasMatch(v) ? null : ErrorCodes.password;
  }

  /// Relaxed password (login): min 7 characters.
  static String? passwordLogin(String v) {
    if (v.isEmpty) {
      return ErrorCodes.required;
    }
    return v.length < 7 ? ErrorCodes.passwordLogin : null;
  }

  static final RegExp _nationalPhone = RegExp(r'^(0[1-9][0-9]{7,9})$');
  static final RegExp _e164Phone = RegExp(r'^\+?[1-9]\d{1,14}$');

  /// National (`0…`) or E.164. Empty is valid; compose with [required].
  static String? phone(String v) {
    final trimmed = v.trim();
    if (trimmed.isEmpty) {
      return null;
    }
    final compact = trimmed.replaceAll(RegExp(r'\s'), '');
    final ok =
        _nationalPhone.hasMatch(compact) || _e164Phone.hasMatch(compact);
    return ok ? null : ErrorCodes.phone;
  }

  static String? money(String v) {
    if (v.trim().isEmpty) {
      return ErrorCodes.required;
    }
    return v.toDoubleValue.isZero ? ErrorCodes.money : null;
  }

  static String? name(String v) {
    final trimmed = v.trim();
    if (trimmed.isEmpty) {
      return ErrorCodes.required;
    }
    return trimmed.length < 2 ? ErrorCodes.minLength : null;
  }

  static String? fullName(String v) {
    final trimmed = v.trim();
    if (trimmed.isEmpty) {
      return ErrorCodes.required;
    }
    return trimmed.length < 5 ? ErrorCodes.minLength : null;
  }

  static String? digits(String v) {
    final trimmed = v.trim();
    if (trimmed.isEmpty) {
      return null;
    }
    return RegExp(r'^\d+$').hasMatch(trimmed) ? null : ErrorCodes.digits;
  }

  /// Reads [other] on each call so confirm-password stays in sync.
  static FieldValidator match(String Function() other) =>
      (v) => v != other() ? ErrorCodes.match : null;

  static String? minAge(
    DateTime? date, {
    int years = 18,
    DateTime? now,
  }) {
    if (date == null) {
      return ErrorCodes.required;
    }
    final today = now ?? DateTime.now();
    var age = today.year - date.year;
    if (today.month < date.month ||
        (today.month == date.month && today.day < date.day)) {
      age--;
    }
    return age < years ? ErrorCodes.minAge : null;
  }

  static String? dateRequired(DateTime? date) =>
      date == null ? ErrorCodes.required : null;

  /// `DateValidator` tear-off for `DateValidatable` / `DateField`.
  static DateValidator ageAtLeast({int years = 18}) =>
      (date) => minAge(date, years: years);

  /// First failure wins.
  static String? all(String v, List<FieldValidator> rules) {
    for (final rule in rules) {
      final error = rule(v);
      if (error != null) {
        return error;
      }
    }
    return null;
  }
}
