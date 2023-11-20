import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/controllers.dart';
import 'package:portfolio/widgets/text_field.dart';

import '../widgets/my_button.dart';

class SendPage extends ConsumerStatefulWidget {
  const SendPage({super.key});

  @override
  ConsumerState<SendPage> createState() => _SendPageState();
}

class _SendPageState extends ConsumerState<SendPage> {
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
      onTap: Controller.onFocusField,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Send Money'),
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
                      CustomTextFormField(
                        controller: _emailController,
                        focusNode: _emailFocusNode,
                        keyboardType: TextInputType.text,
                        hintText: 'Sender\'s Email',
                        prefixIcon: const Icon(CupertinoIcons.mail),
                        validator: Controller.emailValidator,
                      ),
                      CustomTextFormField(
                        controller: _phoneNumberController,
                        focusNode: _phoneNumberFocusNode,
                        keyboardType: TextInputType.phone,
                        hintText: 'Receiver\'s Phone number',
                        prefixText: '+ 234 ',
                        inputFormatters: [PhoneNumberInputFormatter()],
                        prefixIcon: const Icon(CupertinoIcons.phone),
                        validator: Controller.phoneNumberValidator,
                      ),
                      CustomTextFormField(
                        controller: _amountController,
                        focusNode: _amountFocusNode,
                        keyboardType: TextInputType.number,
                        inputFormatters: [NumberInputFormatter()],
                        hintText: 'Amount',
                        prefixIcon: const Icon(CupertinoIcons.money_dollar),
                        validator: Controller.amount,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20.0),
                CustomElevatedButton(
                  onPressed: () {
                    Controller.onSend(
                      context,
                      ref,
                      _formKey,
                      _emailController,
                      _phoneNumberController,
                      _amountController,
                    );
                  },
                  text: 'Send money',
                  icon: const Icon(CupertinoIcons.arrow_up_right_square)),
              ]
            ),
          ),
        ),
      ),
    );
  }
}
