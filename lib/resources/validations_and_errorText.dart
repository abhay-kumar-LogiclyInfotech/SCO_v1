import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';




// *---------------------------------------------------------------- Creating Validations for the particular field start ----------------------------------------------------------------***
class Validations {
  //Clean the Html Tags:
  static String stripHtml(String html) {
    // Define a map for common HTML entities
    final Map<String, String> htmlEntities = {
      '&nbsp;': ' ',
      '&amp;': '&',
      '&lt;': '<',
      '&gt;': '>',
      '&quot;': '"',
      '&apos;': "'",
    };

    // Replace HTML entities with their characters
    String cleanedHtml = html;
    htmlEntities.forEach((entity, character) {
      cleanedHtml = cleanedHtml.replaceAll(entity, character);
    });

    // Remove HTML tags
    final RegExp exp = RegExp(r'<[^>]*>');
    return cleanedHtml.replaceAll(exp, '');
  }


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

  // arabic name validation
  static bool isArabicNameValid(String name) {
    // Regex to allow only Arabic letters and spaces
    final regex = RegExp(r'^[\u0600-\u06FF\s]+$');

    // Check if the name matches the regex
    return regex.hasMatch(name);
  }

  // English name validation
  static bool isEnglishNameValid(String name) {
    // Regex to allow only English letters and spaces
    final regex = RegExp(r'^[a-zA-Z\s]+$');

    // Check if the name matches the regex
    return regex.hasMatch(name);
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

  // Passport Number Validation
  static bool isPassportNumberValid(String passportNumber) {
    // Check if the passport number is empty
    if (passportNumber.isEmpty) {
      return false;
    }

    // Check if passport number has valid length (assuming a length of 6-9 characters is typical)
    if (passportNumber.length < 6 || passportNumber.length > 9) {
      return false;
    }

    // Check if it contains only alphanumeric characters (no spaces or special characters)
    final RegExp passportRegex = RegExp(r'^[a-zA-Z0-9]+$');
    return passportRegex.hasMatch(passportNumber);
  }

  // Unified Number Validation
  static bool isUnifiedNumberValid(String unifiedNumber) {
    // Check if the unified number is empty
    if (unifiedNumber.isEmpty) {
      return false;
    }

    // Check if unified number has exactly 12 digits
    final RegExp unifiedNumberRegex = RegExp(r'^\d{12}$');
    return unifiedNumberRegex.hasMatch(unifiedNumber);
  }

  // Validation function to allow only English, Arabic characters, and numbers
  static bool isValidEnglishArabicNumber(String input) {
    // Check if the input is empty
    if (input.isEmpty) {
      return false;
    }

    // Regular expression to allow only English letters, Arabic letters, and numbers
    final RegExp validInputRegex = RegExp(r'^[a-zA-Z0-9\u0600-\u06FF\s]+$');

    // Return true if the input matches the pattern
    return validInputRegex.hasMatch(input);
  }

  // Name Validation: Allows empty input, but only Arabic and English letters if entered
  static bool isNameArabicEnglishValid(String name) {
    if (name.isEmpty) {
      return true; // Return true if the name is empty
    }

    // Regular expression to allow only English and Arabic letters
    final RegExp nameRegex = RegExp(r'^[a-zA-Z\u0600-\u06FF\s]+$');
    return nameRegex.hasMatch(name);
  }



}
// *---------------------------------------------------------------- Creating Validations for the particular field end ----------------------------------------------------------------***





/// *---------------------------------------------------------------- Creating Error Texts Based on Validations start ----------------------------------------------------------------****
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

  // Arabic name error validation
  static String? getArabicNameError({
    required String name,
    required BuildContext context,
  }) {
    if (name.isEmpty) {
      return AppLocalizations.of(context)!.nameCantBeEmpty;
    } else if (!Validations.isArabicNameValid(name)) {
      return AppLocalizations.of(context)!.invalidArabicName; // Adjust this key to match your localization
    }
    return null;
  }

  // English name error validation
  static String? getEnglishNameError({
    required String name,
    required BuildContext context,
  }) {
    if (name.isEmpty) {
      return AppLocalizations.of(context)!.nameCantBeEmpty;
    } else if (!Validations.isEnglishNameValid(name)) {
      return AppLocalizations.of(context)!.invalidEnglishName; // Adjust this key to match your localization
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

  //Name error:
  static String? getEmptyFieldError({required String name, required BuildContext context}) {
    if (name.isEmpty) {
      return AppLocalizations.of(context)!.fieldCantBeEmpty;
    } else if (!Validations.isEmpty(name)) {
      return AppLocalizations.of(context)!.invalidName;
    }
    return null;
  }


  // Passport Number Error Text
  static String? getPassportNumberError({
    required String passportNumber, required BuildContext context
  }) {
    if (passportNumber.isEmpty) {
      return 'Passport number cannot be empty.';
    } else if (!Validations.isPassportNumberValid(passportNumber)) {
      return 'Invalid passport number. Must be 6-9 characters long and contain only letters and numbers.';
    }
    return null;
  }

  // Unified Number Error
  static String? getUnifiedNumberError({
  required String unifiedNumber,required BuildContext context
  }) {
  if (unifiedNumber.isEmpty) {
  return 'Unified number cannot be empty.';
  } else if (!Validations.isUnifiedNumberValid(unifiedNumber)) {
  return 'Unified number must be exactly 12 digits.';
  }
  return null;
  }

  // English, Arabic Characters and Number Error
  static String? getEnglishArabicNumberError({
    required String input,
    required BuildContext context,
  }) {
    if (input.isEmpty) {
      return 'This field cannot be empty.';
    } else if (!Validations.isValidEnglishArabicNumber(input)) {
      return 'Only English, Arabic characters,\nand numbers are allowed.';
    }
    return null;
  }


  // Name Error Text
  static String? getNameArabicEnglishValidationError({
    required String name,
    required BuildContext context,
  }) {
    if (name.isEmpty) {
      return null; // No error if the name is empty
    } else if (!Validations.isNameArabicEnglishValid(name)) {
      return 'Only Arabic and English characters are allowed.';
    }
    return null; // Return null if validation passes
  }


}
/// *---------------------------------------------------------------- Creating Error Texts Based on Validations end ----------------------------------------------------------------****

