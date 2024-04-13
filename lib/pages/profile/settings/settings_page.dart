import 'package:course_app/common/routes/names.dart';
import 'package:course_app/common/values/constant.dart';
import 'package:course_app/global.dart';
import 'package:course_app/pages/Home/bloc/home_page_bloc.dart';
import 'package:course_app/pages/Home/bloc/home_page_event.dart';
import 'package:course_app/pages/application/bloc/application_bloc.dart';
import 'package:course_app/pages/application/bloc/application_event.dart';
import 'package:course_app/pages/profile/settings/bloc/settings_bloc.dart';
import 'package:course_app/pages/profile/settings/bloc/settings_state.dart';
import 'package:course_app/pages/profile/settings/widgets/settings_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {


  void removeUserData(){
    context.read<AppBloc>().add(const TriggeredAppEvent(0));
    context.read<HomePageBloc>().add(const HomePageDotsEvent(0));
    Global.storageService.remove(AppConstants.STORAGE_USER_TOKEN_KEY);
    Global.storageService.remove(AppConstants.STORAGE_USER_PROFILE_KEY);
    Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.SIGN_IN, (route) => false);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        child: BlocBuilder<SettingsBloc,SettingsState>(
          builder: (context,state){
            return Container(
              child: Column(
                children: [
                  settingsButton(context,removeUserData),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
