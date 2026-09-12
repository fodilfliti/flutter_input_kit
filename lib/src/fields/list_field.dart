import 'package:flutter/material.dart';
import 'package:flutter_scale_kit/flutter_scale_kit.dart';
import 'package:flutter_scale_theme_kit/flutter_scale_theme_kit.dart';

/// Dynamic rows (phones, names, …). Add/remove stay in the controller.
class ListField<T> extends StatelessWidget {
  const ListField({
    required this.items,
    required this.itemBuilder,
    required this.onAdd,
    required this.onRemove,
    super.key,
    this.title,
    this.addLabel,
    this.minItems = 0,
    this.maxItems,
  });

  final List<T> items;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;
  final VoidCallback onAdd;
  final void Function(int index) onRemove;
  final String? title;
  final String? addLabel;
  final int minItems;
  final int? maxItems;

  @override
  Widget build(BuildContext context) {
    final st = Theme.of(context).extension<STThemeExtension>();
    final canAdd = maxItems == null || items.length < maxItems!;
    final canRemove = items.length > minItems;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Padding(
            padding: EdgeInsets.only(bottom: 4.h),
            child: Text(
              title!,
              style: st?.label ?? Theme.of(context).textTheme.labelMedium,
            ),
          ),
        for (var i = 0; i < items.length; i++)
          Padding(
            padding: EdgeInsets.only(bottom: 8.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: itemBuilder(context, items[i], i)),
                if (canRemove)
                  IconButton(
                    onPressed: () => onRemove(i),
                    icon: Icon(
                      Icons.remove_circle_outline,
                      size: 22.r,
                      color: st?.error ?? Theme.of(context).colorScheme.error,
                    ),
                  ),
              ],
            ),
          ),
        if (canAdd)
          addLabel == null
              ? IconButton(
                  onPressed: onAdd,
                  icon: Icon(Icons.add_circle_outline, size: 22.r),
                )
              : TextButton(
                  onPressed: onAdd,
                  child: Text(addLabel!),
                ),
      ],
    );
  }
}
