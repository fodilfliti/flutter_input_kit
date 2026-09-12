# Invariants

- Public export **only** via `lib/flutter_input_kit.dart`.
- Validators are pure; return **machine codes**; no `BuildContext`; no slang / `.tr()`.
- Labels and `errorText` are injected at the call site.
- Align with `Validatable.errorCode` / `FieldValidator` from `flutter_page_kit`.
- One visual language: `FieldStyle` variants share `InputField`. Do not fork widget trees per look.
- No Riverpod, Dio, Supabase, Firebase, Drift, or slang in `lib/`.
- Empty `catch` is banned (`empty_catches: error`).
- Controllers own `FieldText` via `PageData.text()`; widgets do not create undisposed controllers (except a display controller on `DateField`).
