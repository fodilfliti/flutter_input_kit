import 'package:flutter/material.dart';
import 'package:flutter_input_kit/src/fields/input_field.dart';
import 'package:flutter_input_kit/src/spec/field_spec.dart';
import 'package:flutter_input_kit/src/spec/field_style.dart';
import 'package:flutter_page_kit/flutter_page_kit.dart' hide Validators;
import 'package:flutter_scale_kit/flutter_scale_kit.dart';

/// Read-only country trigger. The app supplies the picker via `onTap`.
class CountryField extends StatelessWidget {
  CountryField(
    FieldText field, {
    super.key,
    this.code,
    this.flag,
    String? label,
    String? hint,
    FieldStyle style = FieldStyle.outline,
    bool showErrors = false,
    ErrorTextMapper? errorText,
    this.onTap,
    bool enabled = true,
  }) : spec = FieldSpec(
         field: field,
         label: label,
         hint: hint,
         style: style,
         readOnly: true,
         enabled: enabled,
         showErrors: showErrors,
         errorText: errorText,
         onTap: onTap,
       );

  const CountryField.spec(
    this.spec, {
    super.key,
    this.code,
    this.flag,
    this.onTap,
  });

  final FieldSpec spec;
  final FieldText? code;
  final Widget? flag;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final iso = code?.value;
    return InputField(
      spec: spec.copyWith(
        onTap: spec.onTap ?? onTap,
        prefix: spec.prefix ??
            flag ??
            (iso != null && iso.isNotEmpty
                ? Padding(
                    padding: EdgeInsets.all(12.r),
                    child: Text(iso),
                  )
                : null),
        suffix: spec.suffix ?? Icon(Icons.arrow_drop_down, size: 22.r),
      ),
    );
  }
}
