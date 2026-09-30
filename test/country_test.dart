import 'package:flutter/material.dart';
import 'package:flutter_input_kit/flutter_input_kit.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support.dart';

void main() {
  group('Countries data', () {
    test('ISO codes are unique, upper-case, 2 letters', () {
      final codes = Countries.all.map((c) => c.iso2).toList();
      expect(codes.toSet(), hasLength(codes.length));
      for (final c in Countries.all) {
        expect(RegExp(r'^[A-Z]{2}$').hasMatch(c.iso2), isTrue, reason: '$c');
        expect(RegExp(r'^\d{1,4}$').hasMatch(c.dialCode), isTrue, reason: '$c');
      }
      expect(Countries.all.length, greaterThan(240));
    });

    test('lookups', () {
      expect(Countries.byIso('dz')?.dialCode, '213');
      expect(Countries.byIso('zz'), isNull);
      expect(Countries.byDialCode('+33').single.iso2, 'FR');
      expect(Countries.byDialCode('0044').map((c) => c.iso2), contains('GB'));
    });

    test('flag emoji', () {
      expect(flagEmoji('fr'), '🇫🇷');
      expect(Countries.byIso('DZ')!.flag, '🇩🇿');
      expect(flagEmoji('1x'), isEmpty);
    });

    test('search by name, iso, dial code, localized name', () {
      expect(Countries.search('alger').single.iso2, 'DZ');
      expect(Countries.search('dz').single.iso2, 'DZ');
      expect(Countries.search('+213').map((c) => c.iso2), contains('DZ'));
      final fr = {'DE': 'Allemagne'};
      expect(
        Countries.search('allem', nameOf: (c) => fr[c.iso2] ?? c.name)
            .single
            .iso2,
        'DE',
      );
    });
  });

  testWidgets('picker pins favorites, filters, returns pick', (tester) async {
    Country? picked;
    await tester.pumpWidget(
      wrapWithKits(
        Builder(
          builder: (context) => TextButton(
            onPressed: () async {
              picked = await showCountryPicker(
                context,
                favorites: const ['DZ'],
                searchHint: 'Search',
              );
            },
            child: const Text('open'),
          ),
        ),
      ),
    );

    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();

    final firstTile = tester.widget<ListTile>(find.byType(ListTile).first);
    expect(firstTile.key, const ValueKey('country-DZ'));

    await tester.enterText(find.byType(TextField), 'fran');
    await tester.pumpAndSettle();
    expect(find.text('France'), findsOneWidget);
    expect(find.text('Algeria'), findsNothing);

    await tester.tap(find.text('France'));
    await tester.pumpAndSettle();
    expect(picked?.iso2, 'FR');
  });

  testWidgets('CountryField shows flag for ISO code', (tester) async {
    final name = TextEditingController(text: 'Algeria');
    final code = TextEditingController(text: 'DZ');
    addTearDown(name.dispose);
    addTearDown(code.dispose);

    await tester.pumpWidget(
      wrapWithKits(
        CountryField(
          FieldText(name),
          code: FieldText(code, validators: const []),
        ),
      ),
    );
    expect(find.text('🇩🇿'), findsOneWidget);
  });
}
