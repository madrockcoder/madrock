abstract class StringValidator {
  bool isValid(String value);
  bool isValidEmail(String value);
  bool isValidPhone(String value);
  bool isValidPassword(String value);
  bool isValidAddress(String value);
  bool isValidPostCode(String value);
  bool isValidReferralCode(String value);
  bool isValidAlphabetText(String value);
}

class NonEmptyStringValidator implements StringValidator {
  @override
  bool isValid(String value) {
    return value.isNotEmpty && value.length >= 2 && value.length <= 50;
  }

  @override
  bool isValidEmail(String value) {
    return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value);
  }

  @override
  bool isValidPassword(String value) {
    return value.isNotEmpty && value.length >= 8 && value.length <= 64;
  }

  @override
  bool isValidAddress(String value) {
    return value.isNotEmpty && value.length >= 2 && value.length <= 75;
  }

  @override
  bool isValidPostCode(String value) {
    return value.isNotEmpty && value.length >= 2 && value.length <= 10;
  }

  @override
  bool isValidReferralCode(String value) {
    final hasSpace = RegExp(r'(\s)');
    final invalidSymbols = RegExp(r"[!@#$%^&*(),\|=;.?':{}|<>]");
    if (value.isEmpty) {
      return false;
    } else if (value.length > 15) {
      return false;
    } else if (invalidSymbols.hasMatch(value)) {
      return false;
    } else if (hasSpace.hasMatch(value)) {
      return false;
    } else {
      return true;
    }
  }

  @override
  bool isValidAlphabetText(String value) {
    final invalidSymbols = RegExp(r"[!@#$%^&*(),\|=;.?':{}|<>]");
    final containsNumbers = RegExp(r"[0-9]");
    if (value.isEmpty) {
      return false;
    } else if (value.length < 2) {
      return false;
    } else if (!invalidSymbols.hasMatch(value)) {
      return false;
    } else if (!containsNumbers.hasMatch(value)) {
      return false;
    } else {
      return true;
    }
  }

  @override
  bool isValidPhone(String value) {
    final hasUpperCase = RegExp('(?:[A-Z])');
    final hasLowerCase = RegExp('(?:[a-z])');
    final invaldSymbols = RegExp(r"[!@#$%^&*(),\|=;.?':{}|<>]");
    if (value.isEmpty) {
      return false;
    } else if (value.length < 9) {
      return false;
    } else if (invaldSymbols.hasMatch(value)) {
      return false;
    } else if (hasLowerCase.hasMatch(value)) {
      return false;
    } else if (hasUpperCase.hasMatch(value)) {
      return false;
    } else {
      return true;
    }
  }
}

mixin SignInValidators {
  final StringValidator nameValidator = NonEmptyStringValidator();
  final StringValidator emailValidator = NonEmptyStringValidator();
  final StringValidator passwordValidator = NonEmptyStringValidator();
  final StringValidator confirmPasswordValidator = NonEmptyStringValidator();

  static const String invalidNameErrorText = 'Invalid input';
  static const String invalidEmailErrorText = 'Email is invalid';
  static const String invalidPasswordErrorText = 'Password must be at least 8 characters long';
  static const String invalidConfirmPasswordErrorText = 'Password must match ';
}

mixin AddressValidators {
  final StringValidator addressValidator = NonEmptyStringValidator();
  final StringValidator addressLine1Validator = NonEmptyStringValidator();
  final StringValidator cityValidator = NonEmptyStringValidator();
  final StringValidator stateValidator = NonEmptyStringValidator();
  final StringValidator postCodeValidator = NonEmptyStringValidator();
}

mixin PaymentValidators {
  final StringValidator emailValidator = NonEmptyStringValidator();
  final StringValidator referenceValidator = NonEmptyStringValidator();
}
