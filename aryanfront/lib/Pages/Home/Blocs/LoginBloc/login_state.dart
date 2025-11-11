part of 'login_bloc.dart';

@immutable
sealed class LoginStates {}

final class LoginInitialState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates {}

class LoginErrorState extends LoginStates {}

class LoginUsernameState extends LoginStates {
  final String username;
  LoginUsernameState(this.username);
}

class LoginPasswordState extends LoginStates {
  final String password;
  LoginPasswordState(this.password);
}

class LoginRecoverPasswordState extends LoginStates {
  // final String password;
  // final String rePassword;
  // LoginRecoverPasswordState(this.password, this.rePassword);
}

class LoginSignUpState extends LoginStates {}

class LoginOtpValidationState extends LoginStates {
  final String otpCode;
  LoginOtpValidationState(this.otpCode);
}
