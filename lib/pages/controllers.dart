import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/client_api.dart';
import 'package:portfolio/pages/models.dart';
import 'package:portfolio/pages/register_page.dart';
import 'package:portfolio/utils.dart';
import 'package:vibration/vibration.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({
    Key? key,
    required this.message,
  }) : super(key: key);
  final String message;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const CupertinoActivityIndicator(
            radius: 16.0,
          ),
          const SizedBox(height: 15.0),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.blueGrey.shade600,
              letterSpacing: .6
            ),
          ),
        ],
      ),
    );
  }
}

class Controller {

  static void _startSpinner(BuildContext context, String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => WillPopScope(
        onWillPop: () async => false,
        child: LoadingDialog(message: message)
      )
    );
  }

  static void _stopSpinner(BuildContext context) => Navigator.of(context).pop();

  static void onSignUp(
    BuildContext context,
    formKey,
    TextEditingController emailController,
    TextEditingController phoneNumberController,
    TextEditingController password1Controller,
    TextEditingController password2Controller,
  ) {
    final String email = emailController.text.trim();
    final String phoneNumber = phoneNumberController.text.trim();
    final String password1 = password1Controller.text.trim();
    final String password2 = password2Controller.text.trim();

    if (formKey.currentState?.validate() ?? false) {
      final RegisterModel signupModel = RegisterModel(
        email: email, phoneNumber: phoneNumber, password: password1);
      _signUp(context, signupModel);
    } else {
      Vibration.vibrate(duration: 100);
    }
  }

  static Future<void> _signUp(
    BuildContext context,
    RegisterModel signupModel
  ) async {
    _startSpinner(context, 'Please wait while we\'re signing you up.');
    ClientApi.register(signupModel)
      .whenComplete(() => _stopSpinner(context))
        .then((response) => log(response.toString()));
  }

  static void onSignIn(
    BuildContext context,
    formKey,
    TextEditingController emailController,
    TextEditingController passwordController,
  ) {
    final String email = emailController.text.trim();
    final String password = passwordController.text.trim();

    if (formKey.currentState?.validate() ?? false) {
      final LoginModel signInModel = LoginModel(
        email: email, password: password
      );
      _signIn(context, signInModel);
    } else {
      Vibration.vibrate(duration: 100);
    }
  }

  static Future<void> _signIn(
      BuildContext context, LoginModel signInModel) async {
    _startSpinner(context, 'Please wait while we check you in.');
    ClientApi.login(signInModel)
      .whenComplete(() => _stopSpinner(context))
        .then((response) => log(response.toString()));
  }

  static String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email';
    }
    if (value.isNotEmail) {
      return 'Please enter a valid email';
    }
    return null;
  }

  static String? phoneNumberValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a phone number';
    }
    if (value.length != 10) {
      return 'Phone number can not be more than or less than 10';
    }
    return null;
  }

  static String? password1Validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 6) {
      return 'Password length must be more than 6';
    }
    return null;
  }

  static String? password2Validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    return null;
  }

  static void onLoginNow(BuildContext context) => Navigator.pop(context);

  static void onRegisterNow(BuildContext context) => Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const RegisterPage(),
    ),
  );
}
