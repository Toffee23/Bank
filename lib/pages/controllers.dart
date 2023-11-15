import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:portfolio/client_api.dart';
import 'package:portfolio/pages/models.dart';
import 'package:portfolio/utlis.dart';

class Controller {

  static void onSignUp(
    BuildContext context,
    // TextEditingController emailController,
    // TextEditingController phoneNumberController,
    // TextEditingController password1Controller,
    self
    // TextEditingController password2Controller,
  ) {
    final String email = self.emailController.text.trim();
    final String phoneNumber = self.phoneNumberController.text.trim();
    final String password1 = self.password1Controller.text.trim();
    final String password2 = self.password2Controller.text.trim();

    if (email.isEmpty) {
      log('Email field can\'t be empty');
    } else if (email.isNotEmail) {
      log('The entered email is not a valid email');
    } else if (phoneNumber.isEmpty) {
      log('Phone number field can\'t be empty');
    } else if (phoneNumber.length != 11) {
      log('Phone number must be 11 in length');
    } else if (password1.isEmpty) {
      log('Password field can\'t be empty');
    } else if (password2.isEmpty) {
      log('Confirm password field can\'t be empty');
    } else if (password1 != password2) {
      log('Password mismatch');
    } else {
      final RegisterModel signupModel = RegisterModel(
        email: email,
        phoneNumber: phoneNumber,
        password: password1
      );
      _signIn(context, signupModel);
    }
  }

  static Future<void> _signIn(
    BuildContext context,
    RegisterModel signupModel
  ) async {
    final response = await ClientApi.register(signupModel);

    // print(response);
  }
}