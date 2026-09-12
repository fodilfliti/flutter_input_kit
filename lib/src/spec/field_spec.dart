import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_input_kit/src/spec/field_style.dart';
import 'package:flutter_page_kit/flutter_page_kit.dart' hide Validators;

/// Maps an error **code** to call-site copy (slang / app mapper).
typedef ErrorTextMapper = String Function(String code);

/// Binds a [FieldText] handle to presentation. Not a 40-parameter widget.
class FieldSpec implements Validatable {
  const FieldSpec({
    required this.field,
    this.label,
    this.hint,
    this.style = FieldStyle.outline,
    this.keyboardType,
    this.textInputAction,
    this.obscureText = false,
    this.obscureFlag,
    this.maxLines = 1,
    this.minLines,
    this.enabled = true,
    this.readOnly = false,
    this.autofocus = false,
    this.prefix,
    this.suffix,
    this.onChanged,
    this.onTap,
    this.onTapOutside,
    this.showErrors = false,
    this.errorText,
    this.errorCodeOverride,
    this.autofillHints,
    this.inputFormatters,
    this.textCapitalization = TextCapitalization.none,
  });

  final FieldText field;
  final String? label;
  final String? hint;
  final FieldStyle style;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final FieldFlag? obscureFlag;
  final int maxLines;
  final int? minLines;
  final bool enabled;
  final bool readOnly;
  final bool autofocus;
  final Widget? prefix;
  final Widget? suffix;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final TapRegionCallback? onTapOutside;
  final bool showErrors;
  final ErrorTextMapper? errorText;

  /// When set (dates, etc.), used instead of `field.errorCode`.
  final String? errorCodeOverride;
  final Iterable<String>? autofillHints;
  final List<TextInputFormatter>? inputFormatters;
  final TextCapitalization textCapitalization;

  @override
  String? get errorCode => errorCodeOverride ?? field.errorCode;

  @override
  bool get isValid => errorCode == null;

  /// Localized (or raw code) error when [showErrors] is true.
  String? get resolvedError {
    if (!showErrors) {
      return null;
    }
    final code = errorCode;
    if (code == null) {
      return null;
    }
    return errorText?.call(code) ?? code;
  }

  FieldSpec copyWith({
    FieldText? field,
    String? label,
    String? hint,
    FieldStyle? style,
    TextInputType? keyboardType,
    TextInputAction? textInputAction,
    bool? obscureText,
    FieldFlag? obscureFlag,
    int? maxLines,
    int? minLines,
    bool? enabled,
    bool? readOnly,
    bool? autofocus,
    Widget? prefix,
    Widget? suffix,
    ValueChanged<String>? onChanged,
    VoidCallback? onTap,
    TapRegionCallback? onTapOutside,
    bool? showErrors,
    ErrorTextMapper? errorText,
    String? errorCodeOverride,
    Iterable<String>? autofillHints,
    List<TextInputFormatter>? inputFormatters,
    TextCapitalization? textCapitalization,
  }) {
    return FieldSpec(
      field: field ?? this.field,
      label: label ?? this.label,
      hint: hint ?? this.hint,
      style: style ?? this.style,
      keyboardType: keyboardType ?? this.keyboardType,
      textInputAction: textInputAction ?? this.textInputAction,
      obscureText: obscureText ?? this.obscureText,
      obscureFlag: obscureFlag ?? this.obscureFlag,
      maxLines: maxLines ?? this.maxLines,
      minLines: minLines ?? this.minLines,
      enabled: enabled ?? this.enabled,
      readOnly: readOnly ?? this.readOnly,
      autofocus: autofocus ?? this.autofocus,
      prefix: prefix ?? this.prefix,
      suffix: suffix ?? this.suffix,
      onChanged: onChanged ?? this.onChanged,
      onTap: onTap ?? this.onTap,
      onTapOutside: onTapOutside ?? this.onTapOutside,
      showErrors: showErrors ?? this.showErrors,
      errorText: errorText ?? this.errorText,
      errorCodeOverride: errorCodeOverride ?? this.errorCodeOverride,
      autofillHints: autofillHints ?? this.autofillHints,
      inputFormatters: inputFormatters ?? this.inputFormatters,
      textCapitalization: textCapitalization ?? this.textCapitalization,
    );
  }
}
