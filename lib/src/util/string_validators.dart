import 'package:flutter/services.dart';

/// This file contains some helper functions used for string validation.
abstract class StringValidator {
  const StringValidator();
  bool isValid(String value);
}

class RegexValidator implements StringValidator {
  const RegexValidator({required this.regexSource});
  final String regexSource;

  @override
  bool isValid(String value) {
    try {
      // https://regex101.com/
      final RegExp regex = RegExp(regexSource);
      final Iterable<Match> matches = regex.allMatches(value);
      for (final match in matches) {
        if (match.start == 0 && match.end == value.length) {
          return true;
        }
      }
      return false;
    } catch (e) {
      // Invalid regex
      assert(false, e.toString());
      return true;
    }
  }
}

class ValidatorInputFormatter implements TextInputFormatter {
  const ValidatorInputFormatter({required this.editingValidator});
  final StringValidator editingValidator;

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final bool oldValueValid = editingValidator.isValid(oldValue.text);
    final bool newValueValid = editingValidator.isValid(newValue.text);

    if (oldValueValid && !newValueValid) return oldValue;
    return newValue;
  }
}

class EmailEditingRegexValidator extends RegexValidator {
  const EmailEditingRegexValidator() : super(regexSource: '^(|\\S)+\$');
}

class EmailSubmitRegexValidator extends RegexValidator {
  const EmailSubmitRegexValidator() : super(regexSource: '^\\S+@\\S+\\.\\S+\$');
}

class NonEmptyStringValidator extends StringValidator {
  const NonEmptyStringValidator();
  @override
  bool isValid(String value) => value.isNotEmpty;
}

class MinLengthStringValidator extends StringValidator {
  const MinLengthStringValidator(this.minLength);
  final int minLength;

  @override
  bool isValid(String value) => value.length >= minLength;
}
