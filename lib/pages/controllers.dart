import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:portfolio/client_api.dart';
import 'package:portfolio/pages/models.dart';
import 'package:portfolio/utils.dart';
import 'package:vibration/vibration.dart';

class Controller {

  static void onSignUp(
    BuildContext context, formKey,
    TextEditingController emailController,
    TextEditingController phoneNumberController,
    TextEditingController password1Controller,
    TextEditingController password2Controller,
  ) {
    final String email = emailController.text.trim();
    final String phoneNumber = phoneNumberController.text.trim();
    final String password1 = password1Controller.text.trim();
    final String password2 = password2Controller.text.trim();

    // bool isError = false;
    //
    // if (email.isEmpty) {
    //   log('Email field can\'t be empty');
    //   isError = true;
    // }
    //
    // if (email.isNotEmail) {
    //   log('The entered email is not a valid email');
    //   isError = true;
    // }
    //
    // if (phoneNumber.isEmpty) {
    //   log('Phone number field can\'t be empty');
    //   isError = true;
    // }
    //
    // if (phoneNumber.length != 11) {
    //   log('Phone number must be 11 in length');
    //   isError = true;
    // }
    //
    // if (password1.isEmpty) {
    //   log('Password field can\'t be empty');
    //   isError = true;
    // }
    //
    // if (password2.isEmpty) {
    //   log('Confirm password field can\'t be empty');
    //   isError = true;
    // }
    //
    // if (password1 != password2) {
    //   log('Password mismatch');
    //   isError = true;
    // }

    if (formKey.currentState?.validate() ?? false) {
      final RegisterModel signupModel = RegisterModel(
        email: email,
        phoneNumber: phoneNumber,
        password: password1
      );
      _signIn(context, signupModel);
    } else {
      Vibration.vibrate(duration: 100);
    }
  }

  static Future<void> _signIn(
    BuildContext context,
    RegisterModel signupModel
  ) async {
    final response = await ClientApi.register(signupModel);

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
    if (value.length != 11) {
      return 'Phone number can not be more than or less than 11';
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