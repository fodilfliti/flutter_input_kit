import 'package:flutter_input_kit/flutter_input_kit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('required', () {
    test('empty → required', () {
      expect(Validators.required(''), ErrorCodes.required);
      expect(Validators.required('  '), ErrorCodes.required);
    });
    test('non-empty → null', () {
      expect(Validators.required('a'), isNull);
    });
  });

  group('email', () {
    test('empty is optional', () {
      expect(Validators.email(''), isNull);
    });
    test('invalid', () {
      expect(Validators.email('bad'), ErrorCodes.email);
      expect(Validators.email('a@b'), ErrorCodes.email);
      expect(Validators.email('not-an-email'), ErrorCodes.email);
    });
    test('valid', () {
      expect(Validators.email('user@example.com'), isNull);
      expect(Validators.email('  user@example.com  '), isNull);
    });
  });

  group('minLength / maxLength', () {
    test('minLength', () {
      expect(Validators.minLength(2)('a'), ErrorCodes.minLength);
      expect(Validators.minLength(2)('ab'), isNull);
    });
    test('maxLength', () {
      expect(Validators.maxLength(3)('abcd'), ErrorCodes.maxLength);
      expect(Validators.maxLength(3)('abc'), isNull);
    });
  });

  group('name / fullName', () {
    test('name', () {
      expect(Validators.name(''), ErrorCodes.required);
      expect(Validators.name('A'), ErrorCodes.minLength);
      expect(Validators.name('Al'), isNull);
    });
    test('fullName', () {
      expect(Validators.fullName(''), ErrorCodes.required);
      expect(Validators.fullName('Ada'), ErrorCodes.minLength);
      expect(Validators.fullName('Ada Lovelace'), isNull);
    });
  });

  group('password', () {
    test('empty → required', () {
      expect(Validators.password(''), ErrorCodes.required);
    });
    test('short → minLength', () {
      expect(Validators.password('Ab1!x'), ErrorCodes.minLength);
    });
    test('missing complexity → password', () {
      expect(Validators.password('abcdefgh'), ErrorCodes.password);
      expect(Validators.password('Abcdefgh'), ErrorCodes.password);
      expect(Validators.password('Abcdefg1'), ErrorCodes.password);
    });
    test('valid strict password', () {
      expect(Validators.password('Abcdefg1!'), isNull);
    });
    test('passwordLogin', () {
      expect(Validators.passwordLogin(''), ErrorCodes.required);
      expect(Validators.passwordLogin('123456'), ErrorCodes.passwordLogin);
      expect(Validators.passwordLogin('1234567'), isNull);
    });
  });

  group('phone', () {
    test('empty is optional', () {
      expect(Validators.phone(''), isNull);
    });
    test('national', () {
      expect(Validators.phone('0123456789'), isNull);
      expect(Validators.phone('0612345678'), isNull);
    });
    test('e164', () {
      expect(Validators.phone('+33612345678'), isNull);
      expect(Validators.phone('33612345678'), isNull);
    });
    test('invalid', () {
      expect(Validators.phone('abc'), ErrorCodes.phone);
      expect(Validators.phone('000'), ErrorCodes.phone);
    });
  });

  group('money', () {
    test('empty / zero', () {
      expect(Validators.money(''), ErrorCodes.required);
      expect(Validators.money('0'), ErrorCodes.money);
      expect(Validators.money('0.0'), ErrorCodes.money);
    });
    test('positive', () {
      expect(Validators.money('10'), isNull);
      expect(Validators.money('10,5'), isNull);
    });
  });

  group('match / digits / all', () {
    test('match', () {
      expect(Validators.match(() => 'secret')('secret'), isNull);
      expect(Validators.match(() => 'secret')('nope'), ErrorCodes.match);
    });
    test('digits', () {
      expect(Validators.digits(''), isNull);
      expect(Validators.digits('12'), isNull);
      expect(Validators.digits('1a'), ErrorCodes.digits);
    });
    test('all first failure wins', () {
      expect(
        Validators.all('', [Validators.required, Validators.email]),
        ErrorCodes.required,
      );
      expect(
        Validators.all('bad', [Validators.required, Validators.email]),
        ErrorCodes.email,
      );
      expect(
        Validators.all('a@b.c', [Validators.required, Validators.email]),
        isNull,
      );
    });
  });

  group('minAge', () {
    final now = DateTime(2026, 9, 12);
    test('null → required', () {
      expect(Validators.minAge(null, now: now), ErrorCodes.required);
    });
    test('under 18', () {
      expect(
        Validators.minAge(DateTime(2016, 9, 13), now: now),
        ErrorCodes.minAge,
      );
    });
    test('18 or older', () {
      expect(Validators.minAge(DateTime(2008, 9, 12), now: now), isNull);
    });
  });
}
