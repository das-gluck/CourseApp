import 'package:course_app/common/values/colors.dart';
import 'package:course_app/common/values/constant.dart';
import 'package:course_app/common/widgets/base_text_widget.dart';
import 'package:course_app/pages/course/course_detail/bloc/course_details_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

AppBar buildAppBar(){
  return AppBar(
    title: reusableText("Course Details"),
  );
}

Widget thumbNail(CourseDetailStates states){
  final thumb = states.courseItem?.thumbnail;
  // "${AppConstants.SERVER_UPLOADS}${states.courseItem?.thumbnail}"
  final imageUrl = thumb != null ? "${AppConstants.SERVER_UPLOADS}$thumb" : null;
  return Container(
    width: 325.w,
    height: 200.h,
    decoration: BoxDecoration(
        image: imageUrl!=null ? DecorationImage(
            fit: BoxFit.fitWidth,
            image: NetworkImage(imageUrl),
        ) : null,
    ),
    child: imageUrl == null ? const Center(child: CircularProgressIndicator()) : null,
  );
}

Widget menuView(){
  return SizedBox(
    width: 325.w,
    child: Row(
      children: [
        GestureDetector(
          onTap: (){},
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
            decoration: BoxDecoration(
              color: AppColors.primaryElement,
              borderRadius: BorderRadius.circular(7.w),
              border: Border.all(color: AppColors.primaryElement)
            ),
            child: reusableText("Author Page",
            color: AppColors.primaryElementText,
              fontSize: 10,
              fontWeight: FontWeight.normal
            ),
          ),
        ),
        _iconAndNum("assets/icons/people.png", 10),
        _iconAndNum("assets/icons/star.png", 0),
      ],
    ),
  );
}

Widget _iconAndNum(String iconPath, int num){
  return Container(
    margin: EdgeInsets.only(left: 30.w),
    child: Row(
      children: [
        Image(
            image: AssetImage(iconPath),
            width: 20.w,
            height: 20.h,
        ),
        reusableText(
            num.toString(),
            color: AppColors.primaryThirdElementText,
            fontWeight: FontWeight.normal,
            fontSize: 11
        ),
      ],
    ),
  );
}

Widget goBuyButton(String buttonName){
  return Container(
    width: 330.w,
    height: 50.h,
    decoration: BoxDecoration(
      color: AppColors.primaryElement,
      borderRadius: BorderRadius.all(Radius.circular(10.w)),
      border: Border.all(color: AppColors.primaryElement),
    ),
    child: Center(
        child: Text(
          buttonName,
          style: TextStyle(
          color: AppColors.primaryElementText,
          fontSize: 16.sp,
          fontWeight: FontWeight.normal,
          ),
        ),
    ),
  );
}

Widget descriptionText(String description){
  // return reusableText("Enter cross-platform app development with Flutter – a game-changing technology that lets you create apps for multiple platforms using a single codebase. With the advantages of Flutter, the code you used to build your Android app can be easily adapted and deployed on iOS, the web, or even as a desktop program with minimal modifications. The cherry on top? You’ll never have to maintain multiple codebases again!",
  //     color: AppColors.primaryThirdElementText,
  //     fontWeight: FontWeight.normal,
  //     fontSize: 11
  // );
  return reusableText(description,
      color: AppColors.primaryThirdElementText,
      fontWeight: FontWeight.normal,
      fontSize: 11
  );



}

Widget courseSummaryTitle(){
  return reusableText("The Course Includes");
}



Widget courseSummaryView(BuildContext context, CourseDetailStates states){

  var imageInfo = <String,String>{
    "${states.courseItem!.video_len??"0"} Hours Video" : "video_detail.png",
    "Total ${states.courseItem!.lesson_num??"0"} Lesson" : "file_detail.png",
    "${states.courseItem!.down_num??"0"} Downloadable Resources" : "download_detail.png",
  };

  return Column(
    children: [
      ...List.generate(imageInfo.length, (index) => GestureDetector(
        onTap: (){},
        child: Container(
          margin: EdgeInsets.only(top: 15.h),
          child: Row(
            children: [
              Container(
                alignment: Alignment.center,
                //padding: EdgeInsets.all(7.w),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.w),
                    color: AppColors.primaryElement
                ),
                child: Image.asset("assets/icons/${imageInfo.values.elementAt(index)}",
                    width: 30.w,
                    height: 30.h,
                ),
              ),
              SizedBox(width: 15.w),
              Text(
                imageInfo.keys.elementAt(index),
                style: TextStyle(
                  color: AppColors.primarySecondaryElementText,
                  fontWeight: FontWeight.bold,
                  fontSize: 11.sp,
                ),
              ),
            ],
          ),
        ),
      ) ),
    ],
  );
}

Widget courseLessonList(CourseDetailStates states){
  final thumb = states.courseItem?.thumbnail;
  final String imageUrl = "${AppConstants.SERVER_UPLOADS}$thumb" ;

  return Container(
    width: 325.w,
    height: 80.h,
    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
    decoration: BoxDecoration(
      color: const Color.fromRGBO(255, 255, 255, 1),
      borderRadius: BorderRadius.circular(10.w),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.1),
          blurRadius: 2,
          spreadRadius: 3,
          offset: const Offset(0, 1),
        ),
      ]
    ),
    child: InkWell(
      onTap: (){},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // for image and text
          Row(
            children: [
              Container(
                width: 60.w,
                height: 60.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.h),
                  image: DecorationImage(
                    fit: BoxFit.fill,
                      image: NetworkImage(imageUrl),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _listContainer("UI Design"),
                  _listContainer("effcvvv",fontSize: 10, color: AppColors.primaryThirdElementText, fontWeight: FontWeight.normal ),
                ],
              ),
            ],
          ),

          // for showing the right arrow
          Container(
            child: Image(
              width: 24.w,
              height: 24.h,
              image: AssetImage("assets/icons/arrow_right.png"),
            ),
          ),

        ],
      ),
    ),
  );
}

Widget _listContainer(String text, {double fontSize=13, Color color= AppColors.primaryText , FontWeight fontWeight = FontWeight.bold}){
  return Container(
    width: 200.w,
    margin: EdgeInsets.only(left: 6.w),
    child: Text(
      text,
      overflow: TextOverflow.clip,
      maxLines: 1,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    ),
  );
}
