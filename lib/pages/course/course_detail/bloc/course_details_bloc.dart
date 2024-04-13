import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'course_details_event.dart';
import 'course_details_state.dart';



class CourseDetailBloc extends Bloc<CourseDetailEvents, CourseDetailStates> {
  CourseDetailBloc() : super(const CourseDetailStates()) {
    on<TriggerCourseDetail>(triggerCourseDetail);
  }

  FutureOr<void> triggerCourseDetail(
      TriggerCourseDetail event, Emitter<CourseDetailStates> emit) {
    emit(state.copyWith(courseItem: event.courseItem));
  }
}
