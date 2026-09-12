import 'package:flutter/material.dart';
import 'package:flutter_input_kit/flutter_input_kit.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support.dart';

void main() {
  testWidgets('add and remove rows', (tester) async {
    final items = ['a'];
    await tester.pumpWidget(
      wrapWithKits(
        StatefulBuilder(
          builder: (context, setState) {
            return ListField<String>(
              items: items,
              title: 'Names',
              addLabel: 'Add',
              itemBuilder: (context, item, index) => Text(item),
              onAdd: () => setState(() => items.add('b')),
              onRemove: (i) => setState(() => items.removeAt(i)),
            );
          },
        ),
      ),
    );

    expect(find.text('Names'), findsOneWidget);
    expect(find.text('a'), findsOneWidget);

    await tester.tap(find.text('Add'));
    await tester.pump();
    expect(find.text('b'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.remove_circle_outline).first);
    await tester.pump();
    expect(items.length, 1);
  });
}
