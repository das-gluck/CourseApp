import '../../../common/entities/course.dart';

class HomePageState {
  const HomePageState({
    this.index = 0,
    this.courseItem = const <CourseItem>[],
  });

  final int index;
  final List<CourseItem> courseItem;

  HomePageState copyWith({int? index, List<CourseItem>? courseItem}){
    return HomePageState(
        index: index ?? this.index,
        courseItem: courseItem ?? this.courseItem,
    );
  }
}