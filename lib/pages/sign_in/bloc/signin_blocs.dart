import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ulearning_app/pages/sign_in/bloc/signin_events.dart';
import 'package:ulearning_app/pages/sign_in/bloc/signin_states.dart';



class SigninBlocs extends Bloc<SignInEvents, SigninStates> {
  SigninBlocs() : super(const SigninStates()) {
    on<EmailEvent>(_emailEvent);

    on<PassWordEvent>(_passwordEvent);
  }

  void _emailEvent(EmailEvent event, Emitter<SigninStates> emit) {
    emit(state.copyWith(email: event.email));
  }

  void _passwordEvent(PassWordEvent event, Emitter<SigninStates> emit) {
    emit(state.copyWith(password: event.password));
  }
}
