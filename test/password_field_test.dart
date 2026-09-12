import 'package:flutter/material.dart';
import 'package:flutter_input_kit/flutter_input_kit.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support.dart';

void main() {
  late TextEditingController controller;
  late ValueNotifier<bool> hide;
  late FieldText password;
  late FieldFlag obscure;

  setUp(() {
    controller = TextEditingController();
    hide = ValueNotifier(true);
    password = FieldText(controller, validators: [Validators.password]);
    obscure = FieldFlag(hide);
  });

  tearDown(() {
    controller.dispose();
    hide.dispose();
  });

  testWidgets('empty with showErrors shows required', (tester) async {
    await tester.pumpWidget(
      wrapWithKits(
        PasswordField(
          password,
          obscure: obscure,
          label: 'Password',
          showErrors: true,
        ),
      ),
    );
    expect(find.text(ErrorCodes.required), findsOneWidget);
    final field = tester.widget<TextField>(find.byType(TextField));
    expect(field.obscureText, isTrue);
  });

  testWidgets('toggles visibility', (tester) async {
    await tester.pumpWidget(
      wrapWithKits(
        PasswordField(password, obscure: obscure, label: 'Password'),
      ),
    );
    expect(
      tester.widget<TextField>(find.byType(TextField)).obscureText,
      isTrue,
    );

    await tester.tap(find.byIcon(Icons.visibility_off_outlined));
    await tester.pump();
    expect(hide.value, isFalse);
    expect(
      tester.widget<TextField>(find.byType(TextField)).obscureText,
      isFalse,
    );
  });

  testWidgets('short password shows minLength', (tester) async {
    await tester.pumpWidget(
      wrapWithKits(
        PasswordField(
          password,
          obscure: obscure,
          label: 'Password',
          showErrors: true,
        ),
      ),
    );
    await tester.enterText(find.byType(TextField), 'Ab1!');
    await tester.pump();
    expect(find.text(ErrorCodes.minLength), findsOneWidget);
  });
}
