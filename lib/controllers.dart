import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/client_api.dart';
import 'package:portfolio/pages/home_page.dart';
import 'package:portfolio/models.dart';
import 'package:portfolio/pages/register_page.dart';
import 'package:portfolio/providers.dart';
import 'package:portfolio/widgets/dialogs.dart';
import 'package:portfolio/utils.dart';
import 'package:vibration/vibration.dart';
import 'pages/login_page.dart';

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
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Dismiss'),
          )
        ],
      )
    );
  }

  static void onFocusField() => FocusManager.instance.primaryFocus?.unfocus();

  static void onSignUp(
    BuildContext context,
    WidgetRef ref,
    GlobalKey<FormState> formKey,
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
      _signUp(context, ref, signupModel);
    } else {
      Vibration.vibrate(duration: 100);
    }
  }

  static Future<void> _signUp(
      BuildContext context, WidgetRef ref, signupModel) async {
    onFocusField();
    _startSpinner(context, 'Please wait while we\'re signing you up.');
    ClientApi.register(signupModel)
      .whenComplete(() => _stopSpinner(context))
        .then((response) {
      switch (response.runtimeType) {
        case UserModel:
          gotoHome(context, ref, response);
          break;
        default:
          switch (response) {
            case 'duplicate datas in the databse':
              return _showAlertDialog(
                context, 'Email or username already in use.');

            case RequestStatus.networkFailure:
              return _showAlertDialog(context,
                  'We couldn\'t sign you in due to network interruption.\n\nPlease check your network and try again.');

            case RequestStatus.unKnownError:
              return _showAlertDialog(context,
                  'We couldn\'t sign you in due to an unknown-error, please try again.\n\nIf error persists, please reach the admin for rectification.');

            default:
              return _showAlertDialog(context,
                  'We couldn\'t sign you in due to an unknown-error, please try again.\n\nIf error persists, please reach the admin for rectification.');
          }
      }
    });
  }

  static void onSignIn(
    BuildContext context,
    WidgetRef ref,
    GlobalKey<FormState> formKey,
    TextEditingController emailController,
    TextEditingController passwordController,
  ) {
    ref.read(isValidated.notifier).update((state) => true);
    final String email = emailController.text.trim();
    final String password = passwordController.text.trim();

    if (formKey.currentState?.validate() ?? false) {
      final LoginModel signInModel =
          LoginModel(email: email, password: password);
      _signIn(context, ref, signInModel);
    } else {
      Vibration.vibrate(duration: 100);
    }
  }

  static Future<void> _signIn(
      BuildContext context, WidgetRef ref, LoginModel signInModel) async {
    onFocusField();
    _startSpinner(context, 'Please wait while we check you in.');
    ClientApi.login(signInModel)
        .whenComplete(() => _stopSpinner(context))
        .then((response) {
      switch (response.runtimeType) {
        case UserModel:
          gotoHome(context, ref, response);
          break;
        default:
          switch (response) {
            case 'wrong credentilas':
              return _showAlertDialog(context,
                  'Incorrect email or password. Please cross check your credentials and try again.');

            case RequestStatus.networkFailure:
              return _showAlertDialog(context,
                  'We couldn\'t sign you in due to network interruption.\n\nPlease check your network and try again.');

            case RequestStatus.unKnownError:
              return _showAlertDialog(context,
                  'We couldn\'t sign you in due to an unknown-error, please try again.\n\nIf error persists, please reach the admin for rectification.');

            default:
              return _showAlertDialog(context,
                  'We couldn\'t sign you in due to an unknown-error, please try again.\n\nIf error persists, please reach the admin for rectification.');
          }
      }
    });
  }

  static gotoHome(BuildContext context, WidgetRef ref, UserModel loggedInUser) {
    ref.read(userModelStateNotifierProvider.notifier).updateUser(loggedInUser);

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const HomePage(),
      ),
      (route) => false);
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

  static String? amount(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a amount';
    }
    // if (value.length != 10) {
    //   return 'Phone number should be 11 in length';
    // }
    return null;
  }

  static updateNumber(TextEditingController amountController) {
    final amount = amountController.text;
    if (amount.endsWith('.')) {
      amountController.text += '00';
    }
  }

  static void onLoginNow(BuildContext context) => Navigator.pop(context);

  static void onRegisterNow(BuildContext context) => Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const RegisterPage(),
    ),
  );

  static void onDeposit(
    BuildContext context,
    WidgetRef ref,
    GlobalKey<FormState> formKey,
    TextEditingController phoneNumberController,
    TextEditingController amountController,
  ) {
    if (formKey.currentState?.validate() ?? false) {
      final int phoneNumber = int.parse(phoneNumberController.text.trim());
      final amount = num.parse(amountController.text.trim().formatToString);
      final DepositModel model = DepositModel(phone: phoneNumber, amount: amount);
      _deposit(context, ref, model);
    } else {
      Vibration.vibrate(duration: 100);
    }
  }

  static Future<void> _deposit(
      BuildContext context, WidgetRef ref, DepositModel model) async {
    onFocusField();
    _startSpinner(context, 'Please wait while we process your transaction');
    ClientApi.deposit(model)
      .whenComplete(() => _stopSpinner(context))
        .then((response) {
      switch (response) {
        case RequestStatus.success:
          final balance = ref.watch(userModelStateNotifierProvider).balance + model.amount;
          ref.read(userModelStateNotifierProvider.notifier).update(balance: balance);
          return _showAlertDialog(context,
            'Deposit of ₦${model.amount.toString().formatToPrice} was success and your new balance is ₦${balance.toString().formatToPrice}');
        default:
          switch (response) {
            case RequestStatus.failed:
              return _showAlertDialog(context,
                  'Your entered phone number did not match any of our account.\n\nPlease check the number and try again.');

            case RequestStatus.networkFailure:
              return _showAlertDialog(context,
                'The transaction could not be completed due to network interruption.\n\nPlease check your network and try again.');

            default:
              return _showAlertDialog(context,
                  'Process could not be be completed, please try again.\n\nIf error persists, please reach the admin for rectification.');
          }
      }
    });
  }

  static void onWithdraw(
    BuildContext context,
    WidgetRef ref,
    GlobalKey<FormState> formKey,
    TextEditingController phoneNumberController,
    TextEditingController amountController,
  ) {
    if (formKey.currentState?.validate() ?? false) {
      final int phoneNumber = int.parse(phoneNumberController.text.trim());
      final amount = num.parse(amountController.text.trim().formatToString);
      final WithdrawModel model = WithdrawModel(phone: phoneNumber, amount: amount);
      _withdraw(context, ref, model);
    } else {
      Vibration.vibrate(duration: 100);
    }
  }

  static Future<void> _withdraw(
      BuildContext context, WidgetRef ref, WithdrawModel model) async {
    onFocusField();
    _startSpinner(context, 'Please wait while we process your transaction');
    ClientApi.withdraw(model)
      .whenComplete(() => _stopSpinner(context))
        .then((response) {
      switch (response) {
        case RequestStatus.success:
          final balance = ref.watch(userModelStateNotifierProvider).balance - model.amount;
          ref.read(userModelStateNotifierProvider.notifier).update(balance: balance);
          return _showAlertDialog(context,
            'Withdrawal of ₦${model.amount.toString().formatToPrice} was success and your new balance is ₦${balance.toString().formatToPrice}');
        default:
          switch (response) {
            case RequestStatus.insufficientFunds:
              return _showAlertDialog(context,
                  'Insufficient Funds.\n\nPlease fund your wallet first by depositing from you local bank or ask a friend to transfer some funds to you.');

            case RequestStatus.failed:
              return _showAlertDialog(context,
                  'Your entered phone number did not match any of our account.\n\nPlease check the number and try again.');

            case RequestStatus.networkFailure:
              return _showAlertDialog(context,
                  'The transaction could not be completed due to network interruption.\n\nPlease check your network and try again.');

            default:
              return _showAlertDialog(context,
                  'Process could not be be completed, please try again.\n\nIf error persists, please reach the admin for rectification.');
          }
      }
    });
  }

  static void onSend(
    BuildContext context,
    WidgetRef ref,
    GlobalKey<FormState> formKey,
    TextEditingController emailController,
    TextEditingController phoneNumberController,
    TextEditingController amountController,
  ) {
    if (formKey.currentState?.validate() ?? false) {
      final int phoneNumber = int.parse(phoneNumberController.text.trim());
      final String email = emailController.text.trim();
      final amount = num.parse(amountController.text.trim().formatToString);

      final SendModel model =
          SendModel(email: email, amount: amount, receiverPhoneNumber: phoneNumber);
      _send(context, ref, model);
    } else {
      Vibration.vibrate(duration: 100);
    }
  }

  static Future<void> _send(
    BuildContext context, WidgetRef ref, SendModel model) async {
    onFocusField();
    _startSpinner(context, 'Please wait while we process your transaction');
    ClientApi.send(model)
        .whenComplete(() => _stopSpinner(context))
        .then((response) {
      switch (response) {
        case RequestStatus.success:
          final balance = ref.watch(userModelStateNotifierProvider).balance - model.amount;
          ref.read(userModelStateNotifierProvider.notifier).update(balance: balance);
          return _showAlertDialog(context,
              'Transfer of ₦${model.amount.toString().formatToPrice} was success and your new balance is ₦${balance.toString().formatToPrice}');

          case RequestStatus.insufficientFunds:
            return _showAlertDialog(context,
                'Insufficient Funds.\n\nPlease fund your wallet first by depositing from you local bank or ask a friend to transfer some funds to you.');

          case RequestStatus.failed:
            return _showAlertDialog(context,
                'Your entered phone number did not match any of our account.\n\nPlease check the number and try again.');

          case RequestStatus.networkFailure:
            return _showAlertDialog(context,
                'The transaction could not be completed due to network interruption.\n\nPlease check your network and try again.');

          default:
            return _showAlertDialog(context,
                'Process could not be be completed, please try again.\n\nIf error persists, please reach the admin for rectification.');
      }
    });
  }

  static onVisibility(WidgetRef ref) {
    ref.read(showBalanceProvider.notifier).update((state) {
      return !state;
    });
  }
}
