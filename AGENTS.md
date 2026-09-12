# Agent instructions — Flutter Input Kit

This is a **Flutter package** (`flutter_input_kit`), not an application.

## Load context

1. Read `spec/README.md`, then `package.md` / `invariants.md` / `decisions.md`.
2. Use **code** under `lib/` as implementation truth.
3. Do **not** ingest `README.md` as working memory.

## Working rules

- Public export only via `lib/flutter_input_kit.dart`.
- Validators return **error codes** (`required`, `email`, …). Never translated strings, never `BuildContext`, never slang / `.tr()`.
- Labels and `errorText` are supplied at the call site.
- One visual language: `FieldStyle` enum, not duplicate widget trees.
- Fields bind `FieldText` / `FieldSpec` — not a 40-parameter `CustomTextField`.
- Forbidden in `lib/`: dio, supabase, firebase_*, drift, riverpod, slang.
- Empty catches are analyzer errors.
- Prefer `import 'package:flutter_page_kit/flutter_page_kit.dart' hide Validators` when both barrels are imported.

## Flutter SDK

Pinned in `.fvmrc` to **3.35.7**. Use `fvm flutter` / `fvm dart`. Never upgrade the shared Flutter SDK.

## Out of scope unless asked

Publishing, `dart run flutter_input_kit:gen` (deferred), data_kit / nav_kit / app_kit, migrating lab or reference apps.
