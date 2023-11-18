import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/pages/controllers.dart';
import 'package:portfolio/utilities/my_button.dart';
import 'package:portfolio/utilities/text_field.dart';

class WithDrawPage extends ConsumerStatefulWidget {
  const WithDrawPage({super.key});

  @override
  ConsumerState<WithDrawPage> createState() => _WithDrawPageState();
}

class _WithDrawPageState extends ConsumerState<WithDrawPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _amountController = TextEditingController();
  final _emailFocusNode = FocusNode();
  final _phoneNumberFocusNode = FocusNode();
  final _amountFocusNode = FocusNode();

  @override
  void dispose() {
    _emailController.dispose();
    _phoneNumberController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Withdraw Money'),
        ),
        backgroundColor: Colors.grey.shade300,
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(25.0, 0, 25.0, 100.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Form(
                    key: _formKey,
                    child: Column(
                      children: <CustomTextFormField>[
                        // CustomTextFormField(
                        //   controller: _emailController,
                        //   focusNode: _emailFocusNode,
                        //   keyboardType: TextInputType.text,
                        //   hintText: 'Sender\'s Email',
                        //   prefixIcon: const Icon(CupertinoIcons.mail),

                        //   // validator: Controller.phoneNumberValidator,
                        // ),
                        CustomTextFormField(
                          controller: _phoneNumberController,
                          focusNode: _phoneNumberFocusNode,
                          keyboardType: TextInputType.phone,
                          hintText: 'Phone number',
                          prefixText: '+ 234 ',
                          inputFormatters: [CustomTextInputFormatter()],
                          prefixIcon: const Icon(CupertinoIcons.phone),
                          // validator: Controller.phoneNumberValidator,
                        ),
                        CustomTextFormField(
                          controller: _amountController,
                          focusNode: _amountFocusNode,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          hintText: 'Amount',
                          prefixIcon: const Icon(CupertinoIcons.money_dollar),
                          // validator: Controller.emailValidator,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  CustomElevatedButton(
                      onPressed: () {
                        Controller.onWithdraw(
                          context,
                          ref,
                          _formKey,
                          _phoneNumberController,
                          _amountController,
                        );
                      },
                      text: 'Withdraw money',
                      icon: const Icon(CupertinoIcons.arrow_up_right_square)),
                ]),
          ),
        ),
      ),
    );
  }
}
