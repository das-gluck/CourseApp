

import 'package:course_app/pages/register/bloc/register_bloc.dart';
import 'package:course_app/pages/register/bloc/register_event.dart';
import 'package:course_app/pages/register/bloc/register_state.dart';
import 'package:course_app/pages/register/register_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../common_widgets.dart';
import '../sign_in/bloc/sign_in_bloc.dart';
import '../sign_in/bloc/sign_in_state.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  RegisterBloc registerBloc = RegisterBloc();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc,RegisterStates>(
      bloc: registerBloc,
        builder: (context,state){
      return Container(
        color: Colors.white,
        child: SafeArea(
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: buildAppBar("Sign Up"),
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.h,),
                    Center(
                        child:
                        reusableText("Enter Your details below and free sign up")),
                    Container(
                      margin: EdgeInsets.only(top: 60.h),
                      padding: EdgeInsets.only(left: 25.w, right: 25.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          reusableText("User name"),
                          buildTextField(
                              "Enter your user name", "name", "user",
                                  (value) {
                                //registerBloc.add(UserNameEvent(value));  // this is also ture
                                context.read<RegisterBloc>().add(UserNameEvent(value));
                              }),
                          reusableText("Email"),
                          buildTextField(
                              "Enter your email address", "email", "user",
                                  (value) {
                                context.read<RegisterBloc>().add(EmailEvent(value));
                              }),
                          reusableText("Password"),
                          buildTextField(
                              "Enter your password ", "password", "lock",
                                  (value) {
                                context.read<RegisterBloc>().add(PasswordEvent(value));
                              }),
                          reusableText("Re-enter password"),
                          buildTextField(
                              "Re-enter your password ", "password", "lock",
                                  (value) {
                                context.read<RegisterBloc>().add(RePasswordEvent(value));
                              }),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 25.w,right: 60.w),
                      child: reusableText("By creating an account you have to agree with our them & condition."),
                    ),
                    buildButton("Sign Up", "login",(){
                      //Navigator.of(context).pushNamed("register");
                      RegisterController(context: context).handleEmailRegister();
                    }),
                    SizedBox(height: 50.h),
                  ],
                ),
              ),
            )),
      );
    });
  }
}
