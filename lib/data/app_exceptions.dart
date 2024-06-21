class AppExceptions implements Exception{

  final _message;
  final _prefix;


  AppExceptions([this._message,this._prefix]);

  String toString(){
    return '$_prefix$_message';
  }
  
  

}

class FetchDataException extends AppExceptions{
  FetchDataException([String? message]) : super(message,"Error During Communication\n");
}

class BadRequestException extends AppExceptions {
  BadRequestException([String? message]) : super(message, 'Invalid Request ');
}

class UnAuthorizedException extends AppExceptions {
  UnAuthorizedException([String? message])
      : super(message, 'UnAuthorized Request Exception ');
}

class UserNotFoundException extends AppExceptions {
  UserNotFoundException([String? message])
      : super(message, 'User Not Found Exception ');
}
class InternalServerErrorException extends AppExceptions {
  InternalServerErrorException([String? message])
      : super(message, 'Internal Server Error Exception ');
}

class InvalidInputException extends AppExceptions {
  InvalidInputException([String? message]) : super(message, 'Invalid Input Exception ');
}