import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_input_kit/src/fields/input_field.dart';
import 'package:flutter_input_kit/src/spec/field_spec.dart';
import 'package:flutter_input_kit/src/spec/field_style.dart';
import 'package:flutter_input_kit/src/validators/validators.dart';
import 'package:flutter_page_kit/flutter_page_kit.dart' hide Validators;
import 'package:flutter_scale_kit/flutter_scale_kit.dart';

class MoneyField extends StatelessWidget {
  const MoneyField(
    this.money, {
    super.key,
    this.label,
    this.hint,
    this.currency,
    this.currencies = const ['EUR', 'USD'],
    this.style = FieldStyle.outline,
    this.showErrors = false,
    this.errorText,
    this.onChanged,
    this.enabled = true,
    this.readOnly = false,
  });

  final FieldMoney money;
  final String? label;
  final String? hint;
  final FieldText? currency;
  final List<String> currencies;
  final FieldStyle style;
  final bool showErrors;
  final ErrorTextMapper? errorText;
  final ValueChanged<String>? onChanged;
  final bool enabled;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    final handle = FieldText(
      money.controller,
      validators: [Validators.money],
    );
    final code = currency;
    Widget? suffix;
    if (code != null && currencies.isNotEmpty) {
      suffix = _CurrencySuffix(
        currency: code,
        currencies: currencies,
        enabled: enabled && !readOnly,
        onChanged: onChanged,
      );
    }

    return InputField(
      spec: FieldSpec(
        field: handle,
        label: label,
        hint: hint,
        style: style,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp('[0-9.,]')),
        ],
        suffix: suffix,
        showErrors: showErrors,
        errorText: errorText,
        onChanged: onChanged,
        enabled: enabled,
        readOnly: readOnly,
      ),
    );
  }
}

class _CurrencySuffix extends StatelessWidget {
  const _CurrencySuffix({
    required this.currency,
    required this.currencies,
    required this.enabled,
    this.onChanged,
  });

  final FieldText currency;
  final List<String> currencies;
  final bool enabled;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    final current = currency.value;
    final value = currencies.contains(current)
        ? current
        : (current.isEmpty ? currencies.first : current);

    return Padding(
      padding: EdgeInsetsDirectional.only(end: 4.w),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: currencies.contains(value) ? value : currencies.first,
          items: [
            for (final code in currencies)
              DropdownMenuItem(value: code, child: Text(code)),
          ],
          onChanged: enabled
              ? (next) {
                  if (next == null) {
                    return;
                  }
                  currency.controller.text = next;
                  onChanged?.call(next);
                }
              : null,
        ),
      ),
    );
  }
}
