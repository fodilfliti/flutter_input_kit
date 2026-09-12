import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_input_kit/src/fields/input_field.dart';
import 'package:flutter_input_kit/src/spec/field_spec.dart';
import 'package:flutter_input_kit/src/spec/field_style.dart';
import 'package:flutter_input_kit/src/validators/validatable_adapters.dart';
import 'package:flutter_input_kit/src/validators/validators.dart';
import 'package:flutter_page_kit/flutter_page_kit.dart' hide Validators;
import 'package:flutter_scale_kit/flutter_scale_kit.dart';

class DateField extends StatefulWidget {
  const DateField(
    this.date, {
    super.key,
    this.label,
    this.hint,
    this.style = FieldStyle.outline,
    this.showErrors = false,
    this.errorText,
    this.onChanged,
    this.enabled = true,
    this.firstDate,
    this.lastDate,
    this.format,
    this.validators,
  });

  final FieldDate date;
  final String? label;
  final String? hint;
  final FieldStyle style;
  final bool showErrors;
  final ErrorTextMapper? errorText;
  final ValueChanged<DateTime>? onChanged;
  final bool enabled;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final String Function(DateTime date)? format;
  final List<DateValidator>? validators;

  @override
  State<DateField> createState() => _DateFieldState();
}

class _DateFieldState extends State<DateField> {
  late final TextEditingController _display = TextEditingController(
    text: _label(widget.date.value),
  );
  late final FieldText _handle = FieldText(
    _display,
    validators: const [],
  );

  @override
  void initState() {
    super.initState();
    widget.date.notifier.addListener(_sync);
  }

  @override
  void didUpdateWidget(DateField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.date != widget.date) {
      oldWidget.date.notifier.removeListener(_sync);
      widget.date.notifier.addListener(_sync);
      _sync();
    }
  }

  @override
  void dispose() {
    widget.date.notifier.removeListener(_sync);
    _display.dispose();
    super.dispose();
  }

  void _sync() {
    _display.text = _label(widget.date.value);
    if (mounted) {
      setState(() {});
    }
  }

  String _label(DateTime? value) {
    if (value == null) {
      return '';
    }
    final format = widget.format;
    if (format != null) {
      return format(value);
    }
    final y = value.year.toString().padLeft(4, '0');
    final m = value.month.toString().padLeft(2, '0');
    final d = value.day.toString().padLeft(2, '0');
    return '$y-$m-$d';
  }

  Future<void> _pick() async {
    if (!widget.enabled) {
      return;
    }
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: widget.date.value ?? now,
      firstDate: widget.firstDate ?? DateTime(1850),
      lastDate: widget.lastDate ?? DateTime(2200),
    );
    if (!mounted || picked == null) {
      return;
    }
    widget.date.value = picked;
    widget.onChanged?.call(picked);
  }

  @override
  Widget build(BuildContext context) {
    final adapter = DateValidatable(
      widget.date,
      validators: widget.validators,
    );
    return InputField(
      spec: FieldSpec(
        field: _handle,
        label: widget.label,
        hint: widget.hint,
        style: widget.style,
        readOnly: true,
        enabled: widget.enabled,
        onTap: () => unawaited(_pick()),
        suffix: Icon(Icons.calendar_today_outlined, size: 20.r),
        showErrors: widget.showErrors,
        errorText: widget.errorText,
        errorCodeOverride: adapter.errorCode,
      ),
    );
  }
}
