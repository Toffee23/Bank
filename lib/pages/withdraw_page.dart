import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/controllers.dart';
import 'package:portfolio/widgets/my_button.dart';
import 'package:portfolio/widgets/text_field.dart';

class WithDrawPage extends ConsumerStatefulWidget {
  const WithDrawPage({super.key});

  @override
  ConsumerState<WithDrawPage> createState() => _WithDrawPageState();
}

class _WithDrawPageState extends ConsumerState<WithDrawPage> {
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
      onTap: Controller.onFocusField,
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
                      CustomTextFormField(
                        controller: _phoneNumberController,
                        focusNode: _phoneNumberFocusNode,
                        keyboardType: TextInputType.phone,
                        hintText: 'Phone number',
                        prefixText: '+ 234 ',
                        inputFormatters: [PhoneNumberInputFormatter()],
                        prefixIcon: const Icon(CupertinoIcons.phone),
                        validator: Controller.phoneNumberValidator,
                      ),
                      CustomTextFormField(
                        controller: _amountController,
                        focusNode: _amountFocusNode,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        inputFormatters: [NumberInputFormatter()],
                        hintText: 'Amount',
                        onEditingComplete: Controller.updateNumber(_amountController),
                        prefixIcon: const Icon(CupertinoIcons.money_dollar),
                        validator: Controller.amount,
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
                  icon: const Icon(CupertinoIcons.arrow_down_right_square)),
              ]),
          ),
        ),
      ),
    );
  }
}
