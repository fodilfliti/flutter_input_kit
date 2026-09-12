import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('lib has no forbidden imports or slang', () {
    final root = Directory('lib');
    final violations = <String>[];
    const banned = [
      'package:dio/',
      'package:supabase',
      'package:firebase_',
      'package:drift/',
      'package:flutter_riverpod/',
      'package:hooks_riverpod/',
      'package:riverpod/',
      'package:slang',
      'package:easy_localization/',
      '.tr(',
    ];

    for (final entity in root.listSync(recursive: true)) {
      if (entity is! File || !entity.path.endsWith('.dart')) {
        continue;
      }
      final text = entity.readAsStringSync();
      for (final needle in banned) {
        if (text.contains(needle)) {
          violations.add('${entity.path}: $needle');
        }
      }
    }

    expect(
      violations,
      isEmpty,
      reason: 'Forbidden imports in lib:\n${violations.join('\n')}',
    );
  });
}
