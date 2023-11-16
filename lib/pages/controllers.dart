import 'package:flutter/cupertino.dart';
import 'package:portfolio/client_api.dart';
import 'package:portfolio/pages/models.dart';
import 'package:portfolio/utils.dart';
import 'package:vibration/vibration.dart';

class Controller {
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
      BuildContext context, RegisterModel signupModel) async {
    final response = await ClientApi.register(signupModel);

    // print(response);
  }

  static void onSignIn(
    BuildContext context,
    formKey,
    TextEditingController usernameController,
    TextEditingController passwordController,
  ) {
    final String username = usernameController.text.trim();
    final String password = passwordController.text.trim();

    if (formKey.currentState?.validate() ?? false) {
      final LoginModel signInModel =
          LoginModel(username: username, password: password);
      _signIn(context, signInModel);
    } else {
      Vibration.vibrate(duration: 100);
    }
  }

  static Future<void> _signIn(
      BuildContext context, LoginModel signInModel) async {
    final response = await ClientApi.login(signInModel);

    // print(response);
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
}
