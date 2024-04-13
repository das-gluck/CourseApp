import 'dart:async';

import 'package:course_app/pages/register/bloc/register_event.dart';
import 'package:course_app/pages/register/bloc/register_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterBloc extends Bloc<RegisterEvents, RegisterStates> {
  RegisterBloc() : super(const RegisterStates()) {
    on<UserNameEvent>(userNameEvent);
    on<EmailEvent>(emailEvent);
    on<PasswordEvent>(passwordEvent);
    on<RePasswordEvent>(rePasswordEvent);
  }

  FutureOr<void> userNameEvent(
      UserNameEvent event, Emitter<RegisterStates> emit) {
    print("username : ${event.userName}");
    emit(state.copyWith(username: event.userName));

    // "We can also use this "
    //emit(RegisterStates(username: event.userName));
  }

  FutureOr<void> emailEvent(EmailEvent event, Emitter<RegisterStates> emit) {
    print("email : ${event.email}");
    emit(state.copyWith(email: event.email));
  }

  FutureOr<void> passwordEvent(
      PasswordEvent event, Emitter<RegisterStates> emit) {
    print("password : ${event.password}");
    emit(state.copyWith(password: event.password));
  }

  FutureOr<void> rePasswordEvent(
      RePasswordEvent event, Emitter<RegisterStates> emit) {
    print("rePassword : ${event.rePassword}");
    emit(state.copyWith(rePassword: event.rePassword));
  }
}
