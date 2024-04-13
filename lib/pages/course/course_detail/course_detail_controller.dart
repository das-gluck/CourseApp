import 'package:course_app/common/apis/course_api.dart';
import 'package:course_app/common/entities/course.dart';
import 'package:course_app/common/widgets/flutter_toast.dart';
import 'package:course_app/pages/course/course_detail/bloc/course_details_bloc.dart';
import 'package:course_app/pages/course/course_detail/bloc/course_details_event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class CourseDetailController {
  final BuildContext context;

  CourseDetailController({required this.context});

  void init() async{
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    print(args["id"]);
    asyncLoadAllData(args["id"]);
  }

  // loading all course data
  asyncLoadAllData(int? id) async {
    CourseRequestEntity courseRequestEntity = CourseRequestEntity();
    courseRequestEntity.id = id;
    var result = await CourseAPI.courseDetail(params: courseRequestEntity);
    if(result.code == 200){
      if(context.mounted){
        context.read<CourseDetailBloc>().add(TriggerCourseDetail(result.data!));
      }else{
        print("------context is not available------");
      }

    }else{
      toastInfo(msg: "Something went wrong");
      print("------------Error Code ${result.code}--------------");
    }
  }

  // course Payment
  Future<void> goBuy(int? id) async {
    EasyLoading.show(
      indicator: CircularProgressIndicator(),
      maskType: EasyLoadingMaskType.clear,
      dismissOnTap: true,
    );
    CourseRequestEntity courseRequestEntity = CourseRequestEntity();
    courseRequestEntity.id = id;
    var result = await CourseAPI.coursePay(params: courseRequestEntity);
    EasyLoading.dismiss();

    if(result.code == 200){
      var url = Uri.decodeFull(result.data!);
      print("-----my stripe URL is $url");
    }else{
      print("-----Payment failed -------");
    }
  }



}
