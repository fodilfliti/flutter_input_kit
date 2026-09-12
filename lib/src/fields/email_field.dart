import 'package:flutter/material.dart';
import 'package:flutter_input_kit/src/fields/input_field.dart';
import 'package:flutter_input_kit/src/spec/field_spec.dart';
import 'package:flutter_input_kit/src/spec/field_style.dart';
import 'package:flutter_page_kit/flutter_page_kit.dart' hide Validators;

class EmailField extends StatelessWidget {
  EmailField(
    FieldText field, {
    super.key,
    String? label,
    String? hint,
    FieldStyle style = FieldStyle.outline,
    bool showErrors = false,
    ErrorTextMapper? errorText,
    ValueChanged<String>? onChanged,
    bool enabled = true,
    bool readOnly = false,
    TextInputAction? textInputAction,
  }) : spec = FieldSpec(
         field: field,
         label: label,
         hint: hint,
         style: style,
         keyboardType: TextInputType.emailAddress,
         textInputAction: textInputAction ?? TextInputAction.next,
         autofillHints: const [AutofillHints.email],
         showErrors: showErrors,
         errorText: errorText,
         onChanged: onChanged,
         enabled: enabled,
         readOnly: readOnly,
       );

  const EmailField.spec(this.spec, {super.key});

  final FieldSpec spec;

  @override
  Widget build(BuildContext context) => InputField(spec: spec);
}
