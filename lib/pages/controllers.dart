import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/client_api.dart';
import 'package:portfolio/pages/home_page.dart';
import 'package:portfolio/pages/models.dart';
import 'package:portfolio/pages/register_page.dart';
import 'package:portfolio/utilities/dialogs.dart';
import 'package:portfolio/utils.dart';
import 'package:vibration/vibration.dart';

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

  static void _showAlertDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Alert'),
        content: Text(message),
      )
    );
  }

  static void onSignUp(
    BuildContext context,
    formKey,
    TextEditingController emailController,
    TextEditingController phoneNumberController,
    TextEditingController password1Controller,
  ) {
    final String email = emailController.text.trim();
    final String phoneNumber = phoneNumberController.text.trim();
    final String password = password1Controller.text.trim();

    if (formKey.currentState?.validate() ?? false) {
      final RegisterModel signupModel = RegisterModel(
        email: email, phone: phoneNumber, password: password);
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
        .then((response) {

      switch(response.runtimeType) {
        case UserModel:
          gotoHome(context, response);
          break;
        default:
          switch(response['message']) {
            case 'Network interruption':
              return log('network problem');
            default:
              return log('Email or phone number already in use');
          }
      }
    });
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
        .then((response) {
          switch(response.runtimeType) {
            case UserModel:
              gotoHome(context, response);
              break;
            default:
              log(response);
              switch(response) {
                case 'wrong credentilas':
                  log('network problem');
                  return _showAlertDialog(context, 'Incorrect email or password. Please cross check your credentials and try again.');

                case 'Network interruption':
                  log('network problem');
                  return _showAlertDialog(context, 'We couldn\'t sign you in due to network interruption. Please check your network and try again.');
                default:
              }
          }
    });
  }

  static gotoHome(BuildContext context, UserModel user) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const HomePage(),
      ),
      (route) => false
    );
  }

  static String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
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
      return 'Phone number should be 11 in length';
    }
    return null;
  }

  static String? password1Validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    String msg = 'Password must contain ;';

    if (value.length < 6) msg += '\nat least 7 characters';
    if (!value.hasDigit) msg += '\nat least one digit';
    if (!value.hasLowercase) msg += '\nat least one lowercase';
    if (!value.hasUppercase) msg += '\nat least one uppercase';
    if (!value.hasSpecialCharacters) msg += '\nat least one special character';
    if (msg.contains('\n')) return msg;

    return null;
  }

  static String? password2Validator(String? value1, String value2) {
    if (value1 == null || value1.isEmpty) {
      return 'Please enter a password';
    }
    if (value1 != value2) {
      return 'Password mismatch';
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
