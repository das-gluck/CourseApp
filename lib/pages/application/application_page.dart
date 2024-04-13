import 'package:course_app/common/values/colors.dart';
import 'package:course_app/pages/application/bloc/application_bloc.dart';
import 'package:course_app/pages/application/bloc/application_event.dart';
import 'package:course_app/pages/application/bloc/application_state.dart';
import 'package:course_app/pages/application/widgets/application_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ApplicationPage extends StatefulWidget {
  const ApplicationPage({Key? key}) : super(key: key);

  @override
  State<ApplicationPage> createState() => _ApplicationPageState();
}

class _ApplicationPageState extends State<ApplicationPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(builder: (context, state) {
      return Container(
        color: Colors.white,
        child: SafeArea(
          child: Scaffold(
            body: buildPage(state.index),
            bottomNavigationBar: Container(
              width: 375.w,
              height: 58.h,
              decoration: BoxDecoration(
                color: AppColors.primaryElement,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20.h),
                    topLeft: Radius.circular(20.h)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 1)
                ],
              ),
              child: BottomNavigationBar(
                currentIndex: state.index,
                elevation: 0,
                type: BottomNavigationBarType.fixed,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                selectedItemColor: AppColors.primaryElement,
                unselectedItemColor: AppColors.primaryFourthElementText,
                onTap: (value) {
                  context.read<AppBloc>().add(TriggeredAppEvent(value));
                  //print(_index);
                },
                items: bottomTabs,
              ),
            ),
          ),
        ),
      );
    });
  }
}
