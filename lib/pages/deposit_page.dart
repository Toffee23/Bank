import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/utilities/my_button.dart';
import 'package:portfolio/utilities/text_field.dart';

import 'controllers.dart';

class DepositPage extends ConsumerStatefulWidget {
  const DepositPage({super.key});

  @override
  ConsumerState<DepositPage> createState() => _DepositPageState();
}

class _DepositPageState extends ConsumerState<DepositPage> {
  final _formKey = GlobalKey<FormState>();
  final _phoneNumberController = TextEditingController();
  final _amountController = TextEditingController();
  final _phoneNumberFocusNode = FocusNode();
  final _amountFocusNode = FocusNode();

  @override
  void dispose() {
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
          title: const Text('Add Money'),
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
                        Controller.onDeposit(
                          context,
                          ref,
                          _formKey,
                          _phoneNumberController,
                          _amountController,
                        );
                      },
                      text: 'Add money',
                      icon: const Icon(CupertinoIcons.arrow_down_right_square))
                ]),
          ),
        ),
      ),
    );
  }
}
