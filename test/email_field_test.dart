import 'package:flutter/material.dart';
import 'package:flutter_input_kit/flutter_input_kit.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support.dart';

void main() {
  late TextEditingController controller;
  late FieldText email;

  setUp(() {
    controller = TextEditingController();
    email = FieldText(
      controller,
      validators: [Validators.required, Validators.email],
    );
  });

  tearDown(() {
    controller.dispose();
  });

  testWidgets('empty with showErrors shows required', (tester) async {
    await tester.pumpWidget(
      wrapWithKits(
        EmailField(email, label: 'Email', showErrors: true),
      ),
    );
    expect(find.text(ErrorCodes.required), findsOneWidget);
    expect(find.text('Email'), findsOneWidget);
  });

  testWidgets('invalid then valid email', (tester) async {
    controller.text = 'bad';
    await tester.pumpWidget(
      wrapWithKits(
        EmailField(email, label: 'Email', showErrors: true),
      ),
    );
    expect(find.text(ErrorCodes.email), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'user@example.com');
    await tester.pump();
    expect(find.text(ErrorCodes.email), findsNothing);
    expect(find.text(ErrorCodes.required), findsNothing);
  });

  testWidgets('uses email keyboard', (tester) async {
    await tester.pumpWidget(wrapWithKits(EmailField(email, label: 'Email')));
    final field = tester.widget<TextField>(find.byType(TextField));
    expect(field.keyboardType, TextInputType.emailAddress);
  });
}
