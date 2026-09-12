import 'package:flutter/material.dart';
import 'package:flutter_input_kit/flutter_input_kit.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support.dart';

void main() {
  late TextEditingController number;
  late TextEditingController code;
  late FieldText phone;
  late FieldText dial;

  setUp(() {
    number = TextEditingController();
    code = TextEditingController(text: '+33');
    phone = FieldText(
      number,
      validators: [Validators.required, Validators.phone],
    );
    dial = FieldText(code, validators: const []);
  });

  tearDown(() {
    number.dispose();
    code.dispose();
  });

  testWidgets('invalid phone shows phone code', (tester) async {
    number.text = 'abc';
    await tester.pumpWidget(
      wrapWithKits(
        PhoneField(
          phone,
          dialCode: dial,
          label: 'Phone',
          showErrors: true,
        ),
      ),
    );
    expect(find.text(ErrorCodes.phone), findsOneWidget);
    expect(find.byType(TextField), findsNWidgets(2));
  });

  testWidgets('valid e164 clears error', (tester) async {
    await tester.pumpWidget(
      wrapWithKits(
        PhoneField(phone, label: 'Phone', showErrors: true),
      ),
    );
    await tester.enterText(find.byType(TextField), '+33612345678');
    await tester.pump();
    expect(find.text(ErrorCodes.phone), findsNothing);
    expect(find.text(ErrorCodes.required), findsNothing);
  });

  testWidgets('uses phone keyboard', (tester) async {
    await tester.pumpWidget(wrapWithKits(PhoneField(phone, label: 'Phone')));
    final field = tester.widget<TextField>(find.byType(TextField));
    expect(field.keyboardType, TextInputType.phone);
  });
}
