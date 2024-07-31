import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class Validations {



  static bool containsUppercase(String password) {
    return password.contains(RegExp(r'[A-Z]'));
  }

  static bool containsLowercase(String password) {
    return password.contains(RegExp(r'[a-z]'));
  }

  static bool containsDigit(String password) {
    return password.contains(RegExp(r'\d'));
  }

  static bool containsSpecialCharacter(String password) {
    return password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
  }

  //Name Validation:
  static bool isNameValid(String name) {
    // Check for English and Arabic characters only, with spaces
    final regex = RegExp(r'^[a-zA-Z\u0600-\u06FF ]+$');
    if (!regex.hasMatch(name)) {
      return false;
    }

    // Check for extra spaces
    if (name.trim().split(' ').length != name.split(' ').length) {
      return false;
    }

    return true;
  }

  // Email Validation:
  static bool isEmailValid(String email) {
    // Use a regex for standard email validation
    final regex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return regex.hasMatch(email);
  }

  // Password Validation:
  static bool isPasswordValid(String password) {
    // Check for at least one uppercase letter, one lowercase letter, one digit, and one special character
    final regex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');
    return regex.hasMatch(password);
  }

  //emiratesId validation:
  static bool isValidEmirateId(String? emirateId) {
    bool isValid = false;
    try {
      if (emirateId != null && emirateId.isNotEmpty) {
        // Remove dashes if present
        emirateId = emirateId.replaceAll('-', '');

        // Validate if it's a valid number
        int.parse(emirateId);

        List<String> chars = emirateId.split('');
        int numberMultiSum = 0;
        int remainingDigitSum = 0;

        // Calculate sums
        for (int i = 1; i < chars.length; i += 2) {
          int num = int.parse(chars[i]) * 2;
          if (num > 9) {
            String numString = num.toString();
            int tempSum = 0;
            for (int j = 0; j < numString.length; j++) {
              tempSum += int.parse(numString[j]);
            }
            numberMultiSum += tempSum;
          } else {
            numberMultiSum += num;
          }
        }

        for (int i = chars.length - 3; i >= 0; i -= 2) {
          remainingDigitSum += int.parse(chars[i]);
        }

        int totalSum = numberMultiSum + remainingDigitSum;
        int nextHighestNumber = totalSum % 10 == 0 ? totalSum : totalSum + (10 - totalSum % 10);

        if (nextHighestNumber - totalSum == int.parse(chars[chars.length - 1])) {
          isValid = true;
        }
      }
    } catch (e) {
      isValid = false;
    }
    return isValid;
  }


  // Phone Number Validation:
  static bool isPhoneNumberValid(String phoneNumber) {
    // Check for digits and optional + sign only
    final regex = RegExp(r'^\+?\d+$');
    return regex.hasMatch(phoneNumber);
  }


  //security answer validation:
  static bool isSecurityAnswerValid(String answer) {
    // Check if answer is not empty
    return answer.isNotEmpty;
  }

  //Name Validation:
  static bool isEmpty(String string) {

    if (string.isEmpty) {
      return false;
    }

    // Check for extra spaces
    if (string.trim().split(' ').length != string.split(' ').length) {
      return false;
    }

    return true;
  }
}

class ErrorText {

  //Name error:
  static String? getNameError({required String name, required BuildContext context}) {
    if (name.isEmpty) {
      return AppLocalizations.of(context)!.nameCantBeEmpty;
    } else if (!Validations.isNameValid(name)) {
      return AppLocalizations.of(context)!.invalidName;
    }
    return null;
  }

  //Email error:
  static String? getEmailError({required String email, required BuildContext context}) {
    if (email.isEmpty) {
      return AppLocalizations.of(context)!.emailCantBeEmpty;
    } else if (!Validations.isEmailValid(email)) {
      return AppLocalizations.of(context)!.invalidEmailAddress;
    }
    return null;
  }

  // Password error:
  static String? getPasswordError({required String password, required BuildContext context}) {
    if (password.isEmpty) {
      return AppLocalizations.of(context)!.passwordCantBeEmpty;
    } else if (password.length < 8) {
      return AppLocalizations.of(context)!.passwordTooShort;
    } else if (!Validations.containsUppercase(password)) {
      return AppLocalizations.of(context)!.passwordUppercase;
    } else if (!Validations.containsLowercase(password)) {
      return AppLocalizations.of(context)!.passwordLowercase;
    } else if (!Validations.containsDigit(password)) {
      return AppLocalizations.of(context)!.passwordDigit;
    } else if (!Validations.containsSpecialCharacter(password)) {
      return AppLocalizations.of(context)!.passwordSpecialCharacter;
    }
    return null;
  }

  // Emirates ID error:
  static String? getEmirateIdError({required String emirateId, required BuildContext context}) {
    if (emirateId.isEmpty) {
      return AppLocalizations.of(context)!.emirateIdCantBeEmpty;
    } else if (!Validations.isValidEmirateId(emirateId)) {
      return AppLocalizations.of(context)!.invalidEmirateId;
    }
    return null;
  }

  // Phone Number error:
  static String? getPhoneNumberError({required String phoneNumber, required BuildContext context}) {
    if (phoneNumber.isEmpty) {
      return AppLocalizations.of(context)!.phoneNumberCantBeEmpty;
    } else if (!Validations.isPhoneNumberValid(phoneNumber)) {
      return AppLocalizations.of(context)!.invalidPhoneNumber;
    }
    return null;
  }

  //Security answer error:
  static String? getSecurityAnswerError({required String answer, required BuildContext context}) {
    if (answer.isEmpty) {
      return AppLocalizations.of(context)!.answerCantBeEmpty;
    } else if (!Validations.isSecurityAnswerValid(answer)) {
      return AppLocalizations.of(context)!.invalidSecurityAnswer;
    }
    return null;
  }

  //Empty Field Error:
  //Name error:
  static String? getEmptyFieldError({required String name, required BuildContext context}) {
    if (name.isEmpty) {
      return AppLocalizations.of(context)!.fieldCantBeEmpty;
    } else if (!Validations.isEmpty(name)) {
      return AppLocalizations.of(context)!.invalidName;
    }
    return null;
  }

}
