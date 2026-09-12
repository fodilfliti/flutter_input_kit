import 'package:flutter/material.dart';
import 'package:flutter_input_kit/src/fields/input_field.dart';
import 'package:flutter_input_kit/src/spec/field_spec.dart';
import 'package:flutter_input_kit/src/spec/field_style.dart';
import 'package:flutter_page_kit/flutter_page_kit.dart' hide Validators;

class PasswordField extends StatelessWidget {
  PasswordField(
    FieldText field, {
    required FieldFlag obscure,
    super.key,
    String? label,
    String? hint,
    FieldStyle style = FieldStyle.outline,
    bool showErrors = false,
    ErrorTextMapper? errorText,
    ValueChanged<String>? onChanged,
    bool enabled = true,
    TextInputAction? textInputAction,
  }) : spec = FieldSpec(
         field: field,
         label: label,
         hint: hint,
         style: style,
         keyboardType: TextInputType.visiblePassword,
         textInputAction: textInputAction ?? TextInputAction.done,
         obscureText: true,
         obscureFlag: obscure,
         autofillHints: const [AutofillHints.password],
         showErrors: showErrors,
         errorText: errorText,
         onChanged: onChanged,
         enabled: enabled,
       );

  const PasswordField.spec(this.spec, {super.key});

  final FieldSpec spec;

  @override
  Widget build(BuildContext context) => InputField(spec: spec);
}
