import 'package:flutter/material.dart';
import 'package:flutter_input_kit/src/fields/input_field.dart';
import 'package:flutter_input_kit/src/spec/field_spec.dart';
import 'package:flutter_input_kit/src/spec/field_style.dart';
import 'package:flutter_page_kit/flutter_page_kit.dart' hide Validators;
import 'package:flutter_scale_kit/flutter_scale_kit.dart';

/// Read-only address trigger. The app supplies the map/picker via `onTap`.
class AddressField extends StatelessWidget {
  AddressField(
    FieldText field, {
    super.key,
    String? label,
    String? hint,
    FieldStyle style = FieldStyle.outline,
    bool showErrors = false,
    ErrorTextMapper? errorText,
    VoidCallback? onTap,
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

  const AddressField.spec(this.spec, {super.key});

  final FieldSpec spec;

  @override
  Widget build(BuildContext context) {
    return InputField(
      spec: spec.copyWith(
        suffix: spec.suffix ?? Icon(Icons.place_outlined, size: 22.r),
      ),
    );
  }
}
