import 'dart:async';

import 'package:course_app/pages/sign_in/bloc/sign_in_event.dart';
import 'package:course_app/pages/sign_in/bloc/sign_in_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(const SignInState()) {
    on<EmailEvent>(emailEvent);
    on<PasswordEvent>(passwordEvent);
  }

  FutureOr<void> emailEvent(
      EmailEvent event, Emitter<SignInState> emit) {
    //print("my email is ${event.email}");
    emit(state.copWith(email: event.email));
  }

  FutureOr<void> passwordEvent(
      PasswordEvent event, Emitter<SignInState> emit) {
    //print("my password is ${event.password}");
    emit(state.copWith(password: event.password));
  }


}
