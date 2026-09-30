import 'package:flutter/foundation.dart';

/// Country record: ISO 3166-1 alpha-2 code, E.164 dial code (digits only,
/// NANP territories include their area code), and English name.
///
/// Names in other languages are app data — pass `nameOf` to the picker
/// (e.g. a `Map<String, String>` from your translations).
@immutable
class Country {
  const Country(this.iso2, this.dialCode, this.name);

  /// Upper-case ISO 3166-1 alpha-2, e.g. `DZ`.
  final String iso2;

  /// Digits only, e.g. `213`. Use [dialCodeWithPlus] for display.
  final String dialCode;

  /// English short name.
  final String name;

  String get dialCodeWithPlus => '+$dialCode';

  /// Regional-indicator flag emoji (no image assets).
  String get flag => flagEmoji(iso2);

  @override
  bool operator ==(Object other) => other is Country && other.iso2 == iso2;

  @override
  int get hashCode => iso2.hashCode;

  @override
  String toString() => 'Country($iso2, +$dialCode, $name)';
}

/// Flag emoji for an ISO alpha-2 code; empty string when [iso2] is invalid.
String flagEmoji(String iso2) {
  final code = iso2.trim().toUpperCase();
  if (code.length != 2) {
    return '';
  }
  const base = 0x1F1E6;
  final a = code.codeUnitAt(0);
  final b = code.codeUnitAt(1);
  if (a < 0x41 || a > 0x5A || b < 0x41 || b > 0x5A) {
    return '';
  }
  return String.fromCharCodes([base + a - 0x41, base + b - 0x41]);
}

/// Lookup helpers over [Countries.all].
abstract final class Countries {
  static final Map<String, Country> _byIso = {
    for (final c in all) c.iso2: c,
  };

  /// Case-insensitive ISO lookup.
  static Country? byIso(String? iso2) =>
      iso2 == null ? null : _byIso[iso2.trim().toUpperCase()];

  /// All countries sharing a dial code (`+1`, `1`, `213` …). Leading `+`,
  /// `00`, and spaces are ignored.
  static List<Country> byDialCode(String dialCode) {
    final digits = normalizeDialCode(dialCode);
    return [
      for (final c in all)
        if (c.dialCode == digits) c,
    ];
  }

  /// Strips `+`, a leading `00`, spaces and dashes.
  static String normalizeDialCode(String input) {
    var digits = input.replaceAll(RegExp(r'[\s\-+()]'), '');
    if (digits.startsWith('00')) {
      digits = digits.substring(2);
    }
    return digits;
  }

  /// Filters by name (via [nameOf]), ISO code, or dial code.
  static List<Country> search(
    String query, {
    Iterable<Country>? from,
    String Function(Country)? nameOf,
  }) {
    final source = from ?? all;
    final q = query.trim().toLowerCase();
    if (q.isEmpty) {
      return List.of(source);
    }
    final digits = normalizeDialCode(q);
    final isDial = digits.isNotEmpty && RegExp(r'^\d+$').hasMatch(digits);
    return [
      for (final c in source)
        if ((nameOf?.call(c) ?? c.name).toLowerCase().contains(q) ||
            c.name.toLowerCase().contains(q) ||
            c.iso2.toLowerCase() == q ||
            (isDial && c.dialCode.startsWith(digits)))
          c,
    ];
  }

  static const List<Country> all = [
    Country('AF', '93', 'Afghanistan'),
    Country('AX', '358', 'Åland Islands'),
    Country('AL', '355', 'Albania'),
    Country('DZ', '213', 'Algeria'),
    Country('AS', '1684', 'American Samoa'),
    Country('AD', '376', 'Andorra'),
    Country('AO', '244', 'Angola'),
    Country('AI', '1264', 'Anguilla'),
    Country('AQ', '672', 'Antarctica'),
    Country('AG', '1268', 'Antigua and Barbuda'),
    Country('AR', '54', 'Argentina'),
    Country('AM', '374', 'Armenia'),
    Country('AW', '297', 'Aruba'),
    Country('AU', '61', 'Australia'),
    Country('AT', '43', 'Austria'),
    Country('AZ', '994', 'Azerbaijan'),
    Country('BS', '1242', 'Bahamas'),
    Country('BH', '973', 'Bahrain'),
    Country('BD', '880', 'Bangladesh'),
    Country('BB', '1246', 'Barbados'),
    Country('BY', '375', 'Belarus'),
    Country('BE', '32', 'Belgium'),
    Country('BZ', '501', 'Belize'),
    Country('BJ', '229', 'Benin'),
    Country('BM', '1441', 'Bermuda'),
    Country('BT', '975', 'Bhutan'),
    Country('BO', '591', 'Bolivia'),
    Country('BQ', '599', 'Caribbean Netherlands'),
    Country('BA', '387', 'Bosnia and Herzegovina'),
    Country('BW', '267', 'Botswana'),
    Country('BV', '47', 'Bouvet Island'),
    Country('BR', '55', 'Brazil'),
    Country('IO', '246', 'British Indian Ocean Territory'),
    Country('VG', '1284', 'British Virgin Islands'),
    Country('BN', '673', 'Brunei'),
    Country('BG', '359', 'Bulgaria'),
    Country('BF', '226', 'Burkina Faso'),
    Country('BI', '257', 'Burundi'),
    Country('CV', '238', 'Cabo Verde'),
    Country('KH', '855', 'Cambodia'),
    Country('CM', '237', 'Cameroon'),
    Country('CA', '1', 'Canada'),
    Country('KY', '1345', 'Cayman Islands'),
    Country('CF', '236', 'Central African Republic'),
    Country('TD', '235', 'Chad'),
    Country('CL', '56', 'Chile'),
    Country('CN', '86', 'China'),
    Country('CX', '61', 'Christmas Island'),
    Country('CC', '61', 'Cocos (Keeling) Islands'),
    Country('CO', '57', 'Colombia'),
    Country('KM', '269', 'Comoros'),
    Country('CG', '242', 'Congo'),
    Country('CD', '243', 'Congo (DRC)'),
    Country('CK', '682', 'Cook Islands'),
    Country('CR', '506', 'Costa Rica'),
    Country('CI', '225', "Côte d'Ivoire"),
    Country('HR', '385', 'Croatia'),
    Country('CU', '53', 'Cuba'),
    Country('CW', '599', 'Curaçao'),
    Country('CY', '357', 'Cyprus'),
    Country('CZ', '420', 'Czechia'),
    Country('DK', '45', 'Denmark'),
    Country('DJ', '253', 'Djibouti'),
    Country('DM', '1767', 'Dominica'),
    Country('DO', '1809', 'Dominican Republic'),
    Country('EC', '593', 'Ecuador'),
    Country('EG', '20', 'Egypt'),
    Country('SV', '503', 'El Salvador'),
    Country('GQ', '240', 'Equatorial Guinea'),
    Country('ER', '291', 'Eritrea'),
    Country('EE', '372', 'Estonia'),
    Country('SZ', '268', 'Eswatini'),
    Country('ET', '251', 'Ethiopia'),
    Country('FK', '500', 'Falkland Islands'),
    Country('FO', '298', 'Faroe Islands'),
    Country('FJ', '679', 'Fiji'),
    Country('FI', '358', 'Finland'),
    Country('FR', '33', 'France'),
    Country('GF', '594', 'French Guiana'),
    Country('PF', '689', 'French Polynesia'),
    Country('TF', '262', 'French Southern Territories'),
    Country('GA', '241', 'Gabon'),
    Country('GM', '220', 'Gambia'),
    Country('GE', '995', 'Georgia'),
    Country('DE', '49', 'Germany'),
    Country('GH', '233', 'Ghana'),
    Country('GI', '350', 'Gibraltar'),
    Country('GR', '30', 'Greece'),
    Country('GL', '299', 'Greenland'),
    Country('GD', '1473', 'Grenada'),
    Country('GP', '590', 'Guadeloupe'),
    Country('GU', '1671', 'Guam'),
    Country('GT', '502', 'Guatemala'),
    Country('GG', '44', 'Guernsey'),
    Country('GN', '224', 'Guinea'),
    Country('GW', '245', 'Guinea-Bissau'),
    Country('GY', '592', 'Guyana'),
    Country('HT', '509', 'Haiti'),
    Country('HM', '672', 'Heard Island and McDonald Islands'),
    Country('HN', '504', 'Honduras'),
    Country('HK', '852', 'Hong Kong'),
    Country('HU', '36', 'Hungary'),
    Country('IS', '354', 'Iceland'),
    Country('IN', '91', 'India'),
    Country('ID', '62', 'Indonesia'),
    Country('IR', '98', 'Iran'),
    Country('IQ', '964', 'Iraq'),
    Country('IE', '353', 'Ireland'),
    Country('IM', '44', 'Isle of Man'),
    Country('IL', '972', 'Israel'),
    Country('IT', '39', 'Italy'),
    Country('JM', '1876', 'Jamaica'),
    Country('JP', '81', 'Japan'),
    Country('JE', '44', 'Jersey'),
    Country('JO', '962', 'Jordan'),
    Country('KZ', '7', 'Kazakhstan'),
    Country('KE', '254', 'Kenya'),
    Country('KI', '686', 'Kiribati'),
    Country('XK', '383', 'Kosovo'),
    Country('KW', '965', 'Kuwait'),
    Country('KG', '996', 'Kyrgyzstan'),
    Country('LA', '856', 'Laos'),
    Country('LV', '371', 'Latvia'),
    Country('LB', '961', 'Lebanon'),
    Country('LS', '266', 'Lesotho'),
    Country('LR', '231', 'Liberia'),
    Country('LY', '218', 'Libya'),
    Country('LI', '423', 'Liechtenstein'),
    Country('LT', '370', 'Lithuania'),
    Country('LU', '352', 'Luxembourg'),
    Country('MO', '853', 'Macao'),
    Country('MG', '261', 'Madagascar'),
    Country('MW', '265', 'Malawi'),
    Country('MY', '60', 'Malaysia'),
    Country('MV', '960', 'Maldives'),
    Country('ML', '223', 'Mali'),
    Country('MT', '356', 'Malta'),
    Country('MH', '692', 'Marshall Islands'),
    Country('MQ', '596', 'Martinique'),
    Country('MR', '222', 'Mauritania'),
    Country('MU', '230', 'Mauritius'),
    Country('YT', '262', 'Mayotte'),
    Country('MX', '52', 'Mexico'),
    Country('FM', '691', 'Micronesia'),
    Country('MD', '373', 'Moldova'),
    Country('MC', '377', 'Monaco'),
    Country('MN', '976', 'Mongolia'),
    Country('ME', '382', 'Montenegro'),
    Country('MS', '1664', 'Montserrat'),
    Country('MA', '212', 'Morocco'),
    Country('MZ', '258', 'Mozambique'),
    Country('MM', '95', 'Myanmar'),
    Country('NA', '264', 'Namibia'),
    Country('NR', '674', 'Nauru'),
    Country('NP', '977', 'Nepal'),
    Country('NL', '31', 'Netherlands'),
    Country('NC', '687', 'New Caledonia'),
    Country('NZ', '64', 'New Zealand'),
    Country('NI', '505', 'Nicaragua'),
    Country('NE', '227', 'Niger'),
    Country('NG', '234', 'Nigeria'),
    Country('NU', '683', 'Niue'),
    Country('NF', '672', 'Norfolk Island'),
    Country('KP', '850', 'North Korea'),
    Country('MK', '389', 'North Macedonia'),
    Country('MP', '1670', 'Northern Mariana Islands'),
    Country('NO', '47', 'Norway'),
    Country('OM', '968', 'Oman'),
    Country('PK', '92', 'Pakistan'),
    Country('PW', '680', 'Palau'),
    Country('PS', '970', 'Palestine'),
    Country('PA', '507', 'Panama'),
    Country('PG', '675', 'Papua New Guinea'),
    Country('PY', '595', 'Paraguay'),
    Country('PE', '51', 'Peru'),
    Country('PH', '63', 'Philippines'),
    Country('PN', '64', 'Pitcairn Islands'),
    Country('PL', '48', 'Poland'),
    Country('PT', '351', 'Portugal'),
    Country('PR', '1787', 'Puerto Rico'),
    Country('QA', '974', 'Qatar'),
    Country('RE', '262', 'Réunion'),
    Country('RO', '40', 'Romania'),
    Country('RU', '7', 'Russia'),
    Country('RW', '250', 'Rwanda'),
    Country('BL', '590', 'Saint Barthélemy'),
    Country('SH', '290', 'Saint Helena'),
    Country('KN', '1869', 'Saint Kitts and Nevis'),
    Country('LC', '1758', 'Saint Lucia'),
    Country('MF', '590', 'Saint Martin'),
    Country('PM', '508', 'Saint Pierre and Miquelon'),
    Country('VC', '1784', 'Saint Vincent and the Grenadines'),
    Country('WS', '685', 'Samoa'),
    Country('SM', '378', 'San Marino'),
    Country('ST', '239', 'São Tomé and Príncipe'),
    Country('SA', '966', 'Saudi Arabia'),
    Country('SN', '221', 'Senegal'),
    Country('RS', '381', 'Serbia'),
    Country('SC', '248', 'Seychelles'),
    Country('SL', '232', 'Sierra Leone'),
    Country('SG', '65', 'Singapore'),
    Country('SX', '1721', 'Sint Maarten'),
    Country('SK', '421', 'Slovakia'),
    Country('SI', '386', 'Slovenia'),
    Country('SB', '677', 'Solomon Islands'),
    Country('SO', '252', 'Somalia'),
    Country('ZA', '27', 'South Africa'),
    Country('GS', '500', 'South Georgia and the South Sandwich Islands'),
    Country('KR', '82', 'South Korea'),
    Country('SS', '211', 'South Sudan'),
    Country('ES', '34', 'Spain'),
    Country('LK', '94', 'Sri Lanka'),
    Country('SD', '249', 'Sudan'),
    Country('SR', '597', 'Suriname'),
    Country('SJ', '47', 'Svalbard and Jan Mayen'),
    Country('SE', '46', 'Sweden'),
    Country('CH', '41', 'Switzerland'),
    Country('SY', '963', 'Syria'),
    Country('TW', '886', 'Taiwan'),
    Country('TJ', '992', 'Tajikistan'),
    Country('TZ', '255', 'Tanzania'),
    Country('TH', '66', 'Thailand'),
    Country('TL', '670', 'Timor-Leste'),
    Country('TG', '228', 'Togo'),
    Country('TK', '690', 'Tokelau'),
    Country('TO', '676', 'Tonga'),
    Country('TT', '1868', 'Trinidad and Tobago'),
    Country('TN', '216', 'Tunisia'),
    Country('TR', '90', 'Türkiye'),
    Country('TM', '993', 'Turkmenistan'),
    Country('TC', '1649', 'Turks and Caicos Islands'),
    Country('TV', '688', 'Tuvalu'),
    Country('UG', '256', 'Uganda'),
    Country('UA', '380', 'Ukraine'),
    Country('AE', '971', 'United Arab Emirates'),
    Country('GB', '44', 'United Kingdom'),
    Country('US', '1', 'United States'),
    Country('UM', '1', 'U.S. Minor Outlying Islands'),
    Country('VI', '1340', 'U.S. Virgin Islands'),
    Country('UY', '598', 'Uruguay'),
    Country('UZ', '998', 'Uzbekistan'),
    Country('VU', '678', 'Vanuatu'),
    Country('VA', '39', 'Vatican City'),
    Country('VE', '58', 'Venezuela'),
    Country('VN', '84', 'Vietnam'),
    Country('WF', '681', 'Wallis and Futuna'),
    Country('EH', '212', 'Western Sahara'),
    Country('YE', '967', 'Yemen'),
    Country('ZM', '260', 'Zambia'),
    Country('ZW', '263', 'Zimbabwe'),
  ];
}
