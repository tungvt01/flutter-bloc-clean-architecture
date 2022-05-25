import 'package:todos/presentation/base/index.dart';

class LoginEvent extends BaseEvent {}

class OnLoginEvent extends LoginEvent {
  String phone;
  // String? pass;
  OnLoginEvent({required this.phone});
}

class LoginBiometricCLickedEvent extends LoginEvent {}

class NotMeButtonCLickEvent extends BaseEvent {}

class BiometrictButtonClickEvent extends BaseEvent {}

class RequestLoginEvent extends BaseEvent {
  String pass;
  RequestLoginEvent({required this.pass});
}

class OnForgotPasswordClickEvent extends BaseEvent {}
