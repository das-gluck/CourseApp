import 'package:course_app/common/routes/names.dart';
import 'package:course_app/global.dart';
import 'package:course_app/pages/Home/bloc/home_page_bloc.dart';
import 'package:course_app/pages/Home/home_page.dart';
import 'package:course_app/pages/application/application_page.dart';
import 'package:course_app/pages/application/bloc/application_bloc.dart';
import 'package:course_app/pages/profile/settings/settings_page.dart';
import 'package:course_app/pages/register/bloc/register_bloc.dart';
import 'package:course_app/pages/register/register.dart';
import 'package:course_app/pages/sign_in/bloc/sign_in_bloc.dart';
import 'package:course_app/pages/sign_in/sign_in.dart';
import 'package:course_app/pages/welcome/bloc/welcome_bloc.dart';
import 'package:course_app/pages/welcome/welcome.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../pages/course/course_detail/bloc/course_details_bloc.dart';
import '../../pages/course/course_detail/course_details.dart';
import '../../pages/profile/settings/bloc/settings_bloc.dart';

//unify BlocProvider , routes and pages together
class PageEntity {
  String route;
  Widget page;
  dynamic bloc;
  PageEntity({required this.route, required this.page, required this.bloc});
}

class AppPages {
  static List<PageEntity> routes(){
    return [
      PageEntity(
        route: AppRoutes.INITIAL,
        page: const Welcome(),
        bloc: BlocProvider(create: (_) => WelcomeBloc()),
      ),
      PageEntity(
        route: AppRoutes.SIGN_IN,
        page: const SignIn(),
        bloc: BlocProvider(create: (_) => SignInBloc()),
      ),
      PageEntity(
        route: AppRoutes.REGISTER,
        page: const Register(),
        bloc: BlocProvider(create: (_) => RegisterBloc()),
      ),
      PageEntity(
        route: AppRoutes.APPLICATION,
        page: const ApplicationPage(),
        bloc: BlocProvider(create: (_) => AppBloc()),
      ),
      PageEntity(
        route: AppRoutes.HOME_PAGE,
        page: const HomePage(),
        bloc: BlocProvider(create: (_) => HomePageBloc()),
      ),
      PageEntity(
        route: AppRoutes.SETTINGS,
        page: const SettingsPage(),
        bloc: BlocProvider(create: (_) => SettingsBloc()),
      ),
      PageEntity(
          route: AppRoutes.COURSE_DETAIL,
          page: const CourseDetails(),
          bloc: BlocProvider(create: (_) => CourseDetailBloc()),
      ),
    ] ;
  }

  //return all the bloc provider
  static List<dynamic> allBlocProviders(BuildContext context){
    List<dynamic> blocProvider = <dynamic>[];
    for(var bloc in routes()){
      blocProvider.add(bloc.bloc);
    }
    return blocProvider;
  }

// a modal that cover an entire screen as we click on navigator object
  static MaterialPageRoute generateRouteSettings(RouteSettings settings){
    if(settings.name!=null){
      // check for route name matching when navigator gets triggered
      var result = routes().where((element) => element.route == settings.name);
      if(result.isNotEmpty){
        bool deviceFirstOpen = Global.storageService.getDeviceFirstOpen();
        if(result.first.route == AppRoutes.INITIAL && deviceFirstOpen){
          bool isLoggedIn = Global.storageService.getIsLoggedIn();
          if(isLoggedIn){
            return MaterialPageRoute(builder: (_)=> const ApplicationPage(),settings: settings);
          }

          return MaterialPageRoute(builder: (_) => const SignIn(),settings: settings);
        }
        return MaterialPageRoute(builder: (_) => result.first.page , settings: settings);
      }
    }
    print("invalid route name ${settings.name}");
    return MaterialPageRoute(builder: (_)=> const SignIn(), settings: settings);
  }




}
