class RemoteException implements Exception {
  String? errorCode;
  String? errorMessage;
  int? httpStatusCode;

  RemoteException({this.httpStatusCode, this.errorCode, this.errorMessage});
}

class CacheException implements Exception {
  String? errorMessage;
  CacheException({this.errorMessage});
}

class InputException implements Exception {
  String? errorMessage;
  InputException({this.errorMessage});
}

const socketException = "SOCKET_EXCEPTION";
const timeoutException = "TIMEOUT_EXCEPTION";
const unknownException = "UNKNOWN_EXCEPTION";
