import 'package:course_app/pages/sign_in/bloc/sign_in_bloc.dart';
import 'package:course_app/pages/sign_in/bloc/sign_in_event.dart';
import 'package:course_app/pages/sign_in/bloc/sign_in_state.dart';
import 'package:course_app/pages/sign_in/sign_in_controller.dart';
//import 'package:course_app/pages/sign_in/widgets/sign_in_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../common_widgets.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  SignInBloc signInBloc = SignInBloc();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInBloc, SignInState>(
      bloc: signInBloc,
      builder: (context, state) {
        return Container(
          color: Colors.white,
          child: SafeArea(
              child: Scaffold(
            backgroundColor: Colors.white,
            appBar: buildAppBar("Log In"),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildThirdPartyLogIn(context),
                  Center(
                      child:
                          reusableText("Or use your email account to login")),
                  Container(
                    margin: EdgeInsets.only(top: 36.h),
                    padding: EdgeInsets.only(left: 25.w, right: 25.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        reusableText("Email"),
                        SizedBox(height: 5.h),
                        buildTextField(
                            "Enter your email address", "email", "user",
                            (value) {
                          //signInBloc.add(EmailEvent(value));
                          context.read<SignInBloc>().add(EmailEvent(value));
                        }),
                        reusableText("password"),
                        SizedBox(height: 5.h),
                        buildTextField(
                            "Enter your password ", "password", "lock",
                            (value) {
                          //signInBloc.add(PasswordEvent(value));
                          context.read<SignInBloc>().add(PasswordEvent(value));
                        }),
                      ],
                    ),
                  ),
                  forgetPassword(),
                  SizedBox(height: 70.h),
                  buildButton("Log In", "login", (){
                    SignInController(context: context).handleSignIn("email");
                  }),
                  buildButton("Sign Up", "register",(){
                    //SignInController(context: context).handleSignIn("register");
                    Navigator.of(context).pushNamed("/register");
                  }),
                ],
              ),
            ),
          )),
        );
      },
    );
  }
}
