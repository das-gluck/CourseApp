

import 'package:course_app/common/apis/course_api.dart';
import 'package:course_app/global.dart';
import 'package:course_app/pages/Home/bloc/home_page_bloc.dart';
import 'package:course_app/pages/Home/bloc/home_page_event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/entities/entities.dart';

class HomeController{
  late BuildContext context;
  UserItem get userProfile => Global.storageService.getUserProfile();
  static final HomeController _singleton = HomeController._internal();

  HomeController._internal();

  // this is a factory constructor
  // which make sure you have the original only one instance
  factory HomeController({required BuildContext context}){
    _singleton.context = context;
    return _singleton;
  }




  Future<void> init() async{
    if(Global.storageService.getUserToken().isNotEmpty){
      var result = await CourseAPI.courseList();
      if(result.code == 200){
        if(context.mounted){
          context.read<HomePageBloc>().add(HomePageCourseItem(result.data!));
        }
        print("perfect");
      }else{
        print(result.code);
      }
    }else{
      print("user has logged out");
    }


  }

}