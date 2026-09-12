import 'package:flutter/material.dart';
import 'package:flutter_input_kit/flutter_input_kit.dart';
import 'package:flutter_page_kit/flutter_page_kit.dart' hide Validators;
import 'package:flutter_scale_kit/flutter_scale_kit.dart';
import 'package:flutter_scale_theme_kit/flutter_scale_theme_kit.dart';
import 'package:lemsa_core_kit/lemsa_core_kit.dart';

void main() {
  runApp(const ExampleApp());
}

final STTheme _look = STTheme(
  colors: STColors(
    primary: const STColor(light: Color(0xFF6750A4), dark: Color(0xFFD0BCFF)),
    surface: const STColor(light: Color(0xFFFFFFFF), dark: Color(0xFF1E1E1E)),
    background: const STColor(
      light: Color(0xFFF7F7F7),
      dark: Color(0xFF121212),
    ),
    text: const STColor(light: Color(0xFF1C1B1F), dark: Color(0xFFE6E1E5)),
  ),
);

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaleKitBuilder(
      designWidth: 375,
      designHeight: 812,
      child: MaterialApp(
        title: 'flutter_input_kit',
        theme: _look.light,
        darkTheme: _look.dark,
        home: DemoPage(
          notices: ExampleNotices(_messengerKey),
        ),
        scaffoldMessengerKey: _messengerKey,
      ),
    );
  }
}

final GlobalKey<ScaffoldMessengerState> _messengerKey =
    GlobalKey<ScaffoldMessengerState>();

class ExampleNotices implements Notices {
  ExampleNotices(this._key);

  final GlobalKey<ScaffoldMessengerState> _key;

  void _show(String message) {
    _key.currentState
      ?..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  void info(String message) => _show(message);

  @override
  void warn(String message) => _show(message);

  @override
  void error(String message) => _show(message);

  @override
  void success(String message) => _show(message);

  @override
  void showFailure(AppFailure? failure) {
    if (failure == null || failure is CancelledFailure) {
      return;
    }
    error(failure.runtimeType.toString());
  }
}

/// Call-site mapper — kits never localize.
String mapError(String code) {
  return switch (code) {
    ErrorCodes.required => 'Required',
    ErrorCodes.email => 'Enter a valid email',
    ErrorCodes.minLength => 'Too short',
    ErrorCodes.password => 'Use upper, lower, digit, and a symbol',
    ErrorCodes.phone => 'Enter a valid phone',
    ErrorCodes.money => 'Enter an amount',
    ErrorCodes.minAge => 'Must be 18 or older',
    _ => code,
  };
}

class DemoPage extends StatefulWidget {
  const DemoPage({required this.notices, super.key});

  final Notices notices;

  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage>
    with PageData<DemoPage>, _DemoData {
  @override
  Notices get notices => widget.notices;

  @override
  Widget build(BuildContext context) {
    return PageScope(
      data: this,
      child: FormPage(
        title: 'Input kit',
        actions: actions,
        failure: failure,
        child: ListView(
          padding: EdgeInsets.all(16.r),
          children: [
            EmailField(
              email,
              label: 'Email',
              hint: 'you@example.com',
              showErrors: showFieldErrors,
              errorText: mapError,
              onChanged: (_) => setState(() {}),
            ),
            SKit.vSpaceSize(SKSize.md),
            PasswordField(
              password,
              obscure: obscure,
              label: 'Password',
              hint: '*******',
              showErrors: showFieldErrors,
              errorText: mapError,
              onChanged: (_) => setState(() {}),
            ),
            SKit.vSpaceSize(SKSize.md),
            PhoneField(
              phone,
              dialCode: dialCode,
              label: 'Phone',
              hint: '612345678',
              showErrors: showFieldErrors,
              errorText: mapError,
              onChanged: (_) => setState(() {}),
            ),
            SKit.vSpaceSize(SKSize.md),
            MoneyField(
              amount,
              currency: currency,
              label: 'Amount',
              showErrors: showFieldErrors,
              errorText: mapError,
            ),
            SKit.vSpaceSize(SKSize.md),
            DateField(
              birth,
              label: 'Date of birth',
              hint: 'Select a date',
              showErrors: showFieldErrors,
              errorText: mapError,
              validators: [Validators.dateRequired, Validators.ageAtLeast()],
              onChanged: (_) => setState(() {}),
            ),
            SKit.vSpaceSize(SKSize.md),
            SearchField(search, hint: 'Search'),
            SKit.vSpaceSize(SKSize.md),
            CountryField(
              country,
              code: countryCode,
              label: 'Country',
              hint: 'Select',
              showErrors: showFieldErrors,
              errorText: mapError,
              onTap: () {
                country.controller.text = 'France';
                countryCode.controller.text = 'FR';
                setState(() {});
              },
            ),
            SKit.vSpaceSize(SKSize.md),
            AddressField(
              address,
              label: 'Address',
              hint: 'Pick a place',
              showErrors: showFieldErrors,
              errorText: mapError,
              onTap: () {
                address.controller.text = '12 Rue Example';
                setState(() {});
              },
            ),
            SKit.vSpaceSize(SKSize.md),
            ListField<FieldText>(
              items: extras.value,
              title: 'Extra emails',
              addLabel: 'Add email',
              itemBuilder: (context, item, index) => EmailField(
                item,
                label: 'Email ${index + 1}',
                showErrors: showFieldErrors,
                errorText: mapError,
              ),
              onAdd: addExtra,
              onRemove: removeExtra,
            ),
          ],
        ),
      ),
    );
  }
}

mixin _DemoData on State<DemoPage>, PageData<DemoPage> {
  Notices get notices;

  late final FieldText email = text(
    validators: [Validators.required, Validators.email],
  );
  late final FieldText password = text(validators: [Validators.password]);
  late final FieldFlag obscure = flag(initial: true);
  late final FieldText phone = text(
    validators: [Validators.required, Validators.phone],
  );
  late final FieldText dialCode = text(initial: '+33', validators: const []);
  late final FieldMoney amount = money();
  late final MoneyValidatable amountValid = MoneyValidatable(amount);
  late final FieldText currency = text(initial: 'EUR', validators: const []);
  late final FieldDate birth = date();
  late final DateValidatable birthValid = DateValidatable(
    birth,
    validators: [Validators.dateRequired, Validators.ageAtLeast()],
  );
  late final FieldText search = text(validators: const []);
  late final FieldText country = text();
  late final FieldText countryCode = text(validators: const []);
  late final FieldText address = text();
  late final FieldItems<FieldText> extras = items();

  @override
  List<Validatable> get validated => [
        email,
        password,
        phone,
        amountValid,
        birthValid,
        country,
        address,
        ...extras.value,
      ];

  List<PageAction> get actions => [
        PageAction(
          id: 'save',
          label: 'Save',
          busyKey: 'save',
          isPrimary: true,
          onPressed: submit,
        ),
      ];

  void addExtra() {
    extras.value = [
      ...extras.value,
      text(validators: [Validators.email]),
    ];
    setState(() {});
  }

  void removeExtra(int index) {
    extras.value = [...extras.value]..removeAt(index);
    setState(() {});
  }

  Future<void> submit() => run(
        key: 'save',
        action: () async {
          if (!await validateForm()) {
            return;
          }
          notices.success('Saved');
        },
      );
}
