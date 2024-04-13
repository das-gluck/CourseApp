
import '../../../common/entities/course.dart';

abstract class HomePageEvents{
  const HomePageEvents();
}

class HomePageDotsEvent extends HomePageEvents{
  final int index;
  const HomePageDotsEvent(this.index);
}

class HomePageCourseItem extends HomePageEvents{
  final List<CourseItem> courseItem;
  const HomePageCourseItem(this.courseItem);

}