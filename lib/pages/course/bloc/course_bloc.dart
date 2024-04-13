import 'dart:async';

import 'package:course_app/pages/course/bloc/course_event.dart';
import 'package:course_app/pages/course/bloc/course_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CourseBloc extends Bloc<CourseEvents, CourseStates> {
  CourseBloc() : super(const CourseStates()) {
    on<TriggerCourse>(triggerCourse);
  }

  FutureOr<void> triggerCourse(
      TriggerCourse event, Emitter<CourseStates> emit) {
    emit(state.copyWith(courseItem: event.courseItem));
  }
}
