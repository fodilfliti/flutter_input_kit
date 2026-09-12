import 'package:flutter/material.dart';
import 'package:flutter_input_kit/src/fields/input_field.dart';
import 'package:flutter_input_kit/src/spec/field_spec.dart';
import 'package:flutter_input_kit/src/spec/field_style.dart';
import 'package:flutter_page_kit/flutter_page_kit.dart' hide Validators;
import 'package:flutter_scale_kit/flutter_scale_kit.dart';

class SearchField extends StatelessWidget {
  SearchField(
    FieldText field, {
    super.key,
    String? hint,
    FieldStyle style = FieldStyle.outline,
    ValueChanged<String>? onChanged,
    bool enabled = true,
    bool autofocus = false,
  }) : spec = FieldSpec(
         field: field,
         hint: hint,
         style: style,
         keyboardType: TextInputType.text,
         textInputAction: TextInputAction.search,
         onChanged: onChanged,
         enabled: enabled,
         autofocus: autofocus,
         onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
       );

  const SearchField.spec(this.spec, {super.key});

  final FieldSpec spec;

  @override
  Widget build(BuildContext context) {
    return InputField(
      spec: spec.copyWith(
        suffix: spec.suffix ?? Icon(Icons.search, size: 22.r),
      ),
    );
  }
}
