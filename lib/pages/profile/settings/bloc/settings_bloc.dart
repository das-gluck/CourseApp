import 'dart:async';

import 'package:course_app/pages/profile/settings/bloc/settings_event.dart';
import 'package:course_app/pages/profile/settings/bloc/settings_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(const SettingsState()) {
    on<TriggerSettings>(triggerSettings);
  }

  FutureOr<void> triggerSettings(
      TriggerSettings event, Emitter<SettingsState> emit) {
    emit(const SettingsState());
  }
}
