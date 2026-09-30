# Changelog

## [1.1.0] - 2026-09-30

### Added

- Country data: `Country` (ISO alpha-2, dial code, English name, flag
  emoji), `Countries.all` / `byIso` / `byDialCode` / `search`, `flagEmoji`.
- `showCountryPicker` bottom sheet and embeddable `CountryPickerList`
  (search by name/ISO/dial code, pinned favorites, localized names via
  `nameOf`).

### Changed

- `CountryField` renders the ISO `code` as a flag emoji prefix.

## [1.0.1] - 2026-09-13

### Changed

- Depend on `flutter_scale_theme_kit ^1.0.3` (theme mode constructor fix).
- Example uses hosted kit deps so `pub get` works outside the monorepo.

## [1.0.0] - 2026-09-13

### Added

- First stable pub.dev release.

## [0.0.1] - 2026-09-12

### Added

- Initial local package surface (pre-publish).
