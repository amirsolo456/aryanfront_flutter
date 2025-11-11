part of 'login_bloc.dart';

@immutable
sealed class LoginEvents {}

class LoginInitialEvent extends LoginEvents {}

class LoginLoadingEvent extends LoginEvents {}

class LoginSuccessEvent extends LoginEvents {}

class LoginErrorEvent extends LoginEvents {}

class LoginUsernameEvent extends LoginEvents {}

class LoginPasswordEvent extends LoginEvents {}

class LoginRecoveryPasswordEvent extends LoginEvents {}

class LoginOtpEvent extends LoginEvents {}

class LoginSignUpEvent extends LoginEvents {}
