

class AppExceptions implements Exception {
  final String message;
  final String prefix;

  AppExceptions(this.message, this.prefix);

  @override
  String toString() {
    return '$prefix$message';
  }
}

// class FetchDataException extends AppExceptions {
//   FetchDataException([String? message])
//       : super(message ?? 'Error During Communication', 'Fetch Data Exception: ');
// }
//
// class BadRequestException extends AppExceptions {
//   BadRequestException([String? message])
//       : super(message ?? 'Invalid Request', 'Bad Request: ');
// }
//
// class UnAuthorizedException extends AppExceptions {
//   UnAuthorizedException([String? message])
//       : super(message ?? 'Unauthorized Request', 'Unauthorized Exception: ');
// }
//
// class UserNotFoundException extends AppExceptions {
//   UserNotFoundException([String? message])
//       : super(message ?? 'User Not Found', 'User Not Found Exception: ');
// }
//
// class InternalServerErrorException extends AppExceptions {
//   InternalServerErrorException([String? message])
//       : super(message ?? 'Internal Server Error', 'Internal Server Exception: ');
// }
//
// class FormatException extends AppExceptions {
//   FormatException([String? message])
//       : super(message ?? 'Format Exception', 'Format Exception: ');
// }
//
// class InvalidInputException extends AppExceptions {
//   InvalidInputException([String? message])
//       : super(message ?? 'Invalid Input', 'Invalid Input Exception: ');
// }
// class ValidationException extends AppExceptions {
//   ValidationException(String message) : super(message,"");
// }
// class TooManyRequestsException extends AppExceptions {
//   TooManyRequestsException([String? message])
//       : super(message ?? '', '');
// }
class FetchDataException extends AppExceptions {
  FetchDataException([String? message])
      : super(message ?? 'Error During Communication', '');
}

class BadRequestException extends AppExceptions {
  BadRequestException([String? message])
      : super(message ?? 'Invalid Request', '');
}

class UnAuthorizedException extends AppExceptions {
  UnAuthorizedException([String? message])
      : super(message ?? 'Unauthorized Request', '');
}

class UserNotFoundException extends AppExceptions {
  UserNotFoundException([String? message])
      : super(message ?? 'User Not Found', '');
}

class InternalServerErrorException extends AppExceptions {
  InternalServerErrorException([String? message])
      : super(message ?? 'Internal Server Error', '');
}

class FormatException extends AppExceptions {
  FormatException([String? message])
      : super(message ?? 'Format Exception', '');
}

class InvalidInputException extends AppExceptions {
  InvalidInputException([String? message])
      : super(message ?? 'Invalid Input', '');
}
class ValidationException extends AppExceptions {
  ValidationException(String message) : super(message,"");
}
class TooManyRequestsException extends AppExceptions {
  TooManyRequestsException([String? message])
      : super(message ?? '', '');
}