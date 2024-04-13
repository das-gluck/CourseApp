import 'dart:async';

import 'package:course_app/pages/Home/bloc/home_page_event.dart';
import 'package:course_app/pages/Home/bloc/home_page_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePageBloc extends Bloc<HomePageEvents, HomePageState> {
  HomePageBloc() : super(const HomePageState()) {
    on<HomePageDotsEvent>(homePageDotsEvent);
    on<HomePageCourseItem>(homePageCourseItem);
  }

  FutureOr<void> homePageDotsEvent(
      HomePageDotsEvent event, Emitter<HomePageState> emit) {
    emit(state.copyWith(index: event.index));
  }

  FutureOr<void> homePageCourseItem(
      HomePageCourseItem event, Emitter<HomePageState> emit) {
    emit(state.copyWith(courseItem: event.courseItem));
  }
}
