import 'dart:convert';

import 'package:course_app/common/apis/user_apis.dart';
import 'package:course_app/common/entities/entities.dart';
import 'package:course_app/common/values/constant.dart';
import 'package:course_app/common/widgets/flutter_toast.dart';
import 'package:course_app/global.dart';
import 'package:course_app/pages/Home/home_controller.dart';
import 'package:course_app/pages/sign_in/bloc/sign_in_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class SignInController {
  final BuildContext context;

  const SignInController({required this.context});

  Future<void> handleSignIn(String type) async {
    try {
      if (type == "email") {
        //BlocProvider.of<SignInBloc>(context).state
        final state = context.read<SignInBloc>().state;
        String emailAddress = state.email;
        String password = state.password;

        if (emailAddress.isEmpty) {
          toastInfo(msg: "You need to fill email address");
          return;
        }

        if (password.isEmpty) {
          toastInfo(msg: "You need to fill password");
          return;
        }

        try {
          final credentials = await FirebaseAuth.instance
              .signInWithEmailAndPassword(
                  email: emailAddress, password: password);
          if (credentials.user == null) {
            toastInfo(msg: "You don't exist");
            return;
          }
          if (!credentials.user!.emailVerified) {
            toastInfo(msg: "You need to verify your email account");
            return;
          }

          var user = credentials.user;
          if (user != null) {

            String? displayName = user.displayName;
            String? email = user.email;
            String? id = user.uid;
            String? photoUrl = user.photoURL;

            LoginRequestEntity loginRequestEntity = LoginRequestEntity();
            loginRequestEntity.avatar = photoUrl;
            loginRequestEntity.email = email;
            loginRequestEntity.name = displayName;
            loginRequestEntity.open_id = id;
            //type 1 means email login 192.168.1.5
            loginRequestEntity.type = 1;

            // we got verified user from firebase
            print("user exist");
            await asyncPostAllData(loginRequestEntity);
            if(context.mounted){
              await HomeController(context: context).init();
            }

          } else {
            // we have error getting user from firebase
            toastInfo(msg: "Currently you are not a user of this app");
            return;
          }
        } on FirebaseAuthException catch (e) {
          if (e.code == 'user-not-found') {
            toastInfo(msg: "no user found for that email");
          } else if (e.code == 'wrong-password') {
            print("wrong pass");
            toastInfo(msg: "Wrong password is provided");
          } else if (e.code == 'invalid-email') {
            toastInfo(msg: "invalid email");
          }
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }


  Future<void> asyncPostAllData(LoginRequestEntity loginRequestEntity) async {
    EasyLoading.show(
      indicator: const CircularProgressIndicator(),
      maskType: EasyLoadingMaskType.clear,
      dismissOnTap: true,
    );
    var result = await UserAPI.login(params: loginRequestEntity);
    if(result.code == 200){
      try{
        Global.storageService.setString(AppConstants.STORAGE_USER_PROFILE_KEY, jsonEncode(result.data!));
        print(".....my token is ...... ${result.data!.access_token!}....");
        // used for authorization , that's why we saved it
        Global.storageService.setString(AppConstants.STORAGE_USER_TOKEN_KEY, result.data!.access_token!);
        EasyLoading.dismiss();
        if(context.mounted){
          Navigator.of(context).pushNamedAndRemoveUntil("/application", (route) => false);
        }

      }catch(e){
        print("saving local storage error ${e.toString()}");
      }
    }else{
      EasyLoading.dismiss();
      toastInfo(msg: "unknown error");
    }
  }

}

