import 'package:course_app/common/values/colors.dart';
import 'package:course_app/common/widgets/base_text_widget.dart';
import 'package:course_app/pages/course/course_detail/bloc/course_details_bloc.dart';
import 'package:course_app/pages/course/course_detail/bloc/course_details_state.dart';
import 'package:course_app/pages/course/course_detail/course_detail_controller.dart';
import 'package:course_app/pages/course/widgets/course_details_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CourseDetails extends StatefulWidget {
  const CourseDetails({Key? key}) : super(key: key);

  @override
  State<CourseDetails> createState() => _CourseDetailsState();
}

class _CourseDetailsState extends State<CourseDetails> {
  // late var id;
  late CourseDetailController _courseDetailController;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // id = ModalRoute.of(context)!.settings.arguments as Map;
    // print(id.values.toString());
    _courseDetailController = CourseDetailController(context: context);
    _courseDetailController.init();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourseDetailBloc, CourseDetailStates>(
        builder: (context, state) {
      return state.courseItem != null
          ? Container(
              color: Colors.white,
              child: SafeArea(
                child: Scaffold(
                  backgroundColor: Colors.white,
                  appBar: buildAppBar(),
                  body: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 15.h, horizontal: 25.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              thumbNail(state),
                              SizedBox(height: 15.h),

                              menuView(),
                              SizedBox(height: 15.h),

                              reusableText("Course Description"),
                              SizedBox(height: 15.h),

                              descriptionText(state.courseItem!.description.toString()),
                              SizedBox(height: 20.h),

                              GestureDetector(
                                onTap: (){
                                  _courseDetailController.goBuy(state.courseItem!.id);
                                },
                                child: goBuyButton("Go Buy"),
                              ),
                              SizedBox(height: 20.h),

                              courseSummaryTitle(),
                              courseSummaryView(context,state),
                              SizedBox(height: 20.h),

                              reusableText("Lesson List"),
                              SizedBox(height: 20.h),

                              courseLessonList(state),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          : const Center(child: CircularProgressIndicator());
    });
  }
}
