import 'package:todos/core/error/failures.dart';

enum LoadingStatus {
  none,
  loading,
  finish,
}

abstract class BaseState {
  final LoadingStatus loadingStatus;
  final Failure? failure;

  BaseState({this.loadingStatus = LoadingStatus.none, this.failure});
}

class IdlState extends BaseState {}

// class ErrorState extends BaseState {
//   String? messageError;
//   String? code;
//   ErrorState({this.messageError, this.code});
// }

// class ValidatedState extends BaseState {}

// class LoadingState extends BaseState {}
