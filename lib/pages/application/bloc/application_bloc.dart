import 'dart:async';

import 'package:course_app/pages/application/bloc/application_event.dart';
import 'package:course_app/pages/application/bloc/application_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(const AppState()) {
    on<TriggeredAppEvent>(triggeredAppEvent);
  }

  FutureOr<void> triggeredAppEvent(
      TriggeredAppEvent event, Emitter<AppState> emit) {
    print("index is ${event.index}");
    emit(AppState(index: event.index));
  }
}
