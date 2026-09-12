import 'package:flutter/material.dart';
import 'package:flutter_input_kit/src/fields/input_field.dart';
import 'package:flutter_input_kit/src/spec/field_spec.dart';
import 'package:flutter_input_kit/src/spec/field_style.dart';
import 'package:flutter_page_kit/flutter_page_kit.dart' hide Validators;
import 'package:flutter_scale_kit/flutter_scale_kit.dart';

class PhoneField extends StatelessWidget {
  PhoneField(
    FieldText field, {
    super.key,
    this.dialCode,
    String? label,
    String? hint,
    FieldStyle style = FieldStyle.outline,
    bool showErrors = false,
    ErrorTextMapper? errorText,
    ValueChanged<String>? onChanged,
    bool enabled = true,
    bool readOnly = false,
    String? dialHint,
  })  : spec = FieldSpec(
          field: field,
          label: label,
          hint: hint,
          style: style,
          keyboardType: TextInputType.phone,
          textInputAction: TextInputAction.next,
          autofillHints: const [AutofillHints.telephoneNumber],
          showErrors: showErrors,
          errorText: errorText,
          onChanged: onChanged,
          enabled: enabled,
          readOnly: readOnly,
        ),
        _dialHint = dialHint;

  const PhoneField.spec(
    this.spec, {
    super.key,
    this.dialCode,
    String? dialHint,
  }) : _dialHint = dialHint;

  final FieldSpec spec;
  final FieldText? dialCode;
  final String? _dialHint;

  @override
  Widget build(BuildContext context) {
    final code = dialCode;
    if (code == null) {
      return InputField(spec: spec);
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 88.w,
          child: InputField(
            spec: FieldSpec(
              field: code,
              hint: _dialHint ?? '+33',
              style: spec.style,
              keyboardType: TextInputType.phone,
              enabled: spec.enabled,
              readOnly: spec.readOnly,
            ),
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(child: InputField(spec: spec)),
      ],
    );
  }
}
