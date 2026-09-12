/// Machine error codes returned by `Validators`. Never user-facing copy.
abstract final class ErrorCodes {
  static const required = 'required';
  static const email = 'email';
  static const minLength = 'minLength';
  static const maxLength = 'maxLength';
  static const password = 'password';
  static const passwordLogin = 'passwordLogin';
  static const phone = 'phone';
  static const money = 'money';
  static const minAge = 'minAge';
  static const match = 'match';
  static const name = 'name';
  static const fullName = 'fullName';
  static const date = 'date';
  static const digits = 'digits';
}
