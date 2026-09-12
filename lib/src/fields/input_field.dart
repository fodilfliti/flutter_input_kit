import 'package:flutter/material.dart';
import 'package:flutter_input_kit/src/spec/field_spec.dart';
import 'package:flutter_input_kit/src/spec/field_style.dart';
import 'package:flutter_scale_kit/flutter_scale_kit.dart';
import 'package:flutter_scale_theme_kit/flutter_scale_theme_kit.dart';

/// Shared text field. Semantic widgets are thin wrappers around this tree.
class InputField extends StatefulWidget {
  const InputField({required this.spec, super.key});

  final FieldSpec spec;

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  FieldSpec get spec => widget.spec;

  @override
  void initState() {
    super.initState();
    spec.field.controller.addListener(_rebuild);
  }

  @override
  void didUpdateWidget(InputField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.spec.field.controller != spec.field.controller) {
      oldWidget.spec.field.controller.removeListener(_rebuild);
      spec.field.controller.addListener(_rebuild);
    }
  }

  @override
  void dispose() {
    spec.field.controller.removeListener(_rebuild);
    super.dispose();
  }

  void _rebuild() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final flag = spec.obscureFlag;
    if (flag != null) {
      return ValueListenableBuilder<bool>(
        valueListenable: flag.notifier,
        builder: (context, hidden, _) => _buildField(context, hidden),
      );
    }
    return _buildField(context, spec.obscureText);
  }

  Widget _buildField(BuildContext context, bool obscure) {
    final st = _maybeSt(context);
    final scheme = Theme.of(context).colorScheme;
    final field = TextField(
      controller: spec.field.controller,
      enabled: spec.enabled,
      readOnly: spec.readOnly,
      obscureText: obscure,
      keyboardType: spec.keyboardType,
      textInputAction: spec.textInputAction,
      maxLines: obscure ? 1 : spec.maxLines,
      minLines: spec.minLines,
      autofocus: spec.autofocus,
      autofillHints: spec.autofillHints,
      inputFormatters: spec.inputFormatters,
      textCapitalization: spec.textCapitalization,
      onChanged: spec.onChanged,
      onTap: spec.onTap,
      onTapOutside: spec.onTapOutside,
      cursorColor: st?.primary ?? scheme.primary,
      style: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: st?.text ?? scheme.onSurface,
      ),
      textAlignVertical: TextAlignVertical.center,
      decoration: _decoration(context, st, scheme, obscure),
    );

    final label = spec.label;
    if (spec.style == FieldStyle.corner && label != null) {
      return _CornerLabel(
        label: label,
        color: st?.surface ?? scheme.surface,
        textStyle: st?.label ?? Theme.of(context).textTheme.labelMedium,
        child: field,
      );
    }
    if (label != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: st?.label ??
                Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: st?.textSecondary ?? scheme.onSurfaceVariant,
                    ),
          ),
          SizedBox(height: 4.h),
          field,
        ],
      );
    }
    return field;
  }

  InputDecoration _decoration(
    BuildContext context,
    STResolved? st,
    ColorScheme scheme,
    bool obscure,
  ) {
    final radius = (st?.input.radius ?? st?.radius.mdValue ?? 10).rSafe;
    final borderColor = st?.input.border ?? st?.border ?? scheme.outline;
    final errorColor = st?.error ?? scheme.error;
    final fill = st?.input.fill;
    final isOutline = spec.style != FieldStyle.underline;

    InputBorder border({required Color color, double width = 1.3}) {
      if (isOutline) {
        return OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide(color: color, width: width),
        );
      }
      return UnderlineInputBorder(
        borderSide: BorderSide(color: color, width: width),
      );
    }

    var suffix = spec.suffix;
    if (suffix == null && spec.obscureFlag != null) {
      suffix = IconButton(
        onPressed: spec.enabled
            ? () => spec.obscureFlag!.value = !obscure
            : null,
        icon: Icon(
          obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
          size: 22.r,
          color: st?.textSecondary ?? scheme.onSurfaceVariant,
        ),
      );
    }

    return InputDecoration(
      hintText: spec.hint,
      filled: fill != null || (st?.input.filled ?? false),
      fillColor: fill,
      prefixIcon: spec.prefix,
      suffixIcon: suffix,
      errorText: spec.resolvedError,
      errorMaxLines: 2,
      hintStyle: TextStyle(
        fontSize: 14.sp,
        color: (st?.textSecondary ?? scheme.onSurfaceVariant)
            .withValues(alpha: 0.7),
      ),
      errorStyle: TextStyle(
        fontSize: 10.sp,
        fontWeight: FontWeight.w500,
        color: errorColor,
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      enabledBorder: border(color: borderColor),
      disabledBorder: border(
        color: borderColor.withValues(alpha: 0.4),
      ),
      focusedBorder: border(
        color: st?.primary ?? scheme.primary,
        width: 2,
      ),
      errorBorder: border(color: errorColor, width: 2),
      focusedErrorBorder: border(color: errorColor, width: 2),
    );
  }
}

STResolved? _maybeSt(BuildContext context) {
  final scoped = STScope.maybeOf(context);
  if (scoped != null) {
    return scoped.resolved;
  }
  final ext = Theme.of(context).extension<STThemeExtension>();
  if (ext != null) {
    return STResolved(ext);
  }
  return null;
}

class _CornerLabel extends StatelessWidget {
  const _CornerLabel({
    required this.label,
    required this.color,
    required this.child,
    this.textStyle,
  });

  final String label;
  final Color color;
  final TextStyle? textStyle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        child,
        PositionedDirectional(
          top: -8.h,
          start: 12.w,
          child: ColoredBox(
            color: color,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Text(label, style: textStyle),
            ),
          ),
        ),
      ],
    );
  }
}
