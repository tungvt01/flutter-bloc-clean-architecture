abstract class Failure {
  String? message;
  int? code;
  Failure({this.message, this.code});
}

class RemoteFailure extends Failure {
  dynamic data;
  RemoteFailure({String? msg, this.data, int? code})
      : super(message: msg, code: code);
}

class CacheFailure extends Failure {
  CacheFailure({String? msg}) : super(message: msg);
}

class PlatformFailure extends Failure {
  PlatformFailure({String? msg}) : super(message: msg);
}

class UnknownFailure extends Failure {
  UnknownFailure({String? msg, int? code}) : super(message: msg, code: code);
}
const internetErrorMessage = 'internetErrorMessage';
const socketErrorMessage = 'socketErrorMessage';
const serverErrorMessage = 'server_error_message';
const unknownErrorMessage = 'serverErrorMessage';

const httpStatusServerMaintain = 520;
const httpStatusServerBadGateway = 502;
const accessTokenExpiredCode = 401;
