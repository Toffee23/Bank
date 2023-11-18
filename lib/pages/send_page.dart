import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:portfolio/pages/controllers.dart';
import 'package:portfolio/utilities/text_field.dart';

class SendPage extends StatefulWidget {
  const SendPage({super.key});

  @override
  State<SendPage> createState() => _SendPageState();
}

class _SendPageState extends State<SendPage> {
  final _formKey = GlobalKey<FormState>();
  final _phoneNumberController = TextEditingController();
  final _emailController = TextEditingController();
  final _amountController = TextEditingController();
  final _phoneNumberFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
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
    return Scaffold(
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
                      CustomTextFormField(
                        controller: _emailController,
                        focusNode: _emailFocusNode,
                        keyboardType: TextInputType.text,
                        hintText: 'Email',

                        // validator: Controller.phoneNumberValidator,
                      ),
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
                ElevatedButton(
                  onPressed: () {
                    Controller.onSend(
                      context,
                      _formKey,
                      _emailController,
                      _phoneNumberController,
                      _amountController,
                    );
                  },
                  style: ButtonStyle(
                      minimumSize: const MaterialStatePropertyAll(
                          Size(double.infinity, 42)),
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)))),
                  child: const Text(
                    'Withdraw',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
