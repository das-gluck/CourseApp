import 'package:course_app/common/values/constant.dart';
import 'package:course_app/common/widgets/flutter_toast.dart';
import 'package:course_app/pages/register/bloc/register_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterController {
  final BuildContext context;
  const RegisterController({required this.context});

  Future<void> handleEmailRegister() async {
    //RegisterBloc registerBloc = RegisterBloc(); // this can be also used
    // final states = registerBloc.state;
    final state = context.read<RegisterBloc>().state;
    String username = state.username;
    String email = state.email;
    String password = state.password;
    String rePassword = state.rePassword;

    if (username.isEmpty) {
      toastInfo(msg: "username cannot be empty");
      return;
    }
    if (email.isEmpty) {
      toastInfo(msg: "email cannot be empty");
      return;
    }
    if (password.isEmpty) {
      toastInfo(msg: "password cannot be empty");
      return;
    }
    if (rePassword.isEmpty) {
      toastInfo(msg: "rePassword cannot be empty");
      return;
    }

    try {
      final credentials = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      if (credentials.user != null) {
        await credentials.user!.sendEmailVerification();
        await credentials.user!.updateDisplayName(username);
        String photoUrl = "uploads/default.png";
        await credentials.user!.updatePhotoURL(photoUrl);
        toastInfo(
            msg:
                "An email has been sent to your registered email. To activate it please your email box and click on the link ");
        Navigator.of(context).pop();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        toastInfo(msg: "Password is too weak");
      } else if (e.code == 'email-already-in-use') {
        toastInfo(msg: "The email is already is used");
      } else if (e.code == 'invalid-email') {
        toastInfo(msg: "Invalid Email");
      }
    }
  }
}
