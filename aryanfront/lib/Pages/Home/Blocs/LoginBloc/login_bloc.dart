import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvents, LoginStates> {
  LoginBloc() : super(LoginInitialState()) {
    on<LoginInitialEvent>((event, emit) {
      emit(LoginUsernameState('a'));
    });

    on<LoginUsernameEvent>((event, emit) {
      emit(LoginPasswordState('a'));
    });

    on<LoginRecoveryPasswordEvent>((event, emit) {
      emit(LoginOtpValidationState(''));
    });

    on<LoginOtpEvent>((event, emit) {
      emit(LoginRecoverPasswordState());
    });

    on<LoginPasswordEvent>((event, emit) {
      // emit(LoginLoadingState());
      try {
        // final result = await loginApi(event.username, event.password);
        // if (result.success) {
        //   emit(LoginSuccessState());
        // } else {
        //   emit(LoginErrorState());
        // }
        // emit(LoginSuccessState());
        // emit(LoginSuccessState());
      } catch (e) {
        emit(LoginErrorState());
      }
    });

    // on<LoginRecoveryPasswordEvent>((event, emit) {
    //   // handle recovery password
    // });

    // on<LoginOtpEvent>((event, emit) {
    //   // handle OTP validation
    // });

    on<LoginSignUpEvent>((event, emit) {
      // emit(LoginSignUpState());
    });
  }
}
