import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({
    Key? key,
    required this.hintText,
    this.controller,
    this.focusNode,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.obscureText = false,
    this.prefixText,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.inputFormatters,
  }) : super(key: key);
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final String hintText;
  final String? prefixText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final FormFieldValidator<String>? validator;
  final List<TextInputFormatter>? inputFormatters;

  final textListener = ValueNotifier<bool>(false);
  final focusListener = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    textListener.value = controller?.text.isNotEmpty??false;
    focusListener.value = focusNode?.hasFocus??false;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: ValueListenableBuilder<bool>(
        valueListenable: textListener,
        builder: (context, hasText, child) {
          return Stack(
            children: <Widget>[
              ValueListenableBuilder<bool>(
                valueListenable: focusListener,
                builder: (context, isFocused, child) {
                  return Focus(
                    onFocusChange: (value) {
                      focusListener.value = value;
                      value ? focusNode?.requestFocus() : focusNode?.unfocus();
                    },
                    child: TextFormField(
                      controller: controller,
                      focusNode: focusNode,
                      keyboardType: keyboardType,
                      textInputAction: textInputAction,
                      inputFormatters: inputFormatters,
                      validator: validator,
                      obscureText: obscureText,
                      onChanged: (value) => textListener.value = value.isNotEmpty,
                      decoration: InputDecoration(
                        fillColor: Colors.grey.shade200,
                        filled: true,
                        hintText: hintText,
                        prefixText: isFocused || hasText ? prefixText : null,
                        prefixIcon: prefixIcon == null ? null :
                          Padding(
                            padding: const EdgeInsets.only(left: 4.0),
                            child: prefixIcon,
                          ),
                        suffixIcon: suffixIcon == null ? null :
                          Card(
                            margin: const EdgeInsets.only(right: 4.0),
                            color: Colors.transparent,
                            elevation: 0.0,
                            shape: const CircleBorder(),
                            clipBehavior: Clip.hardEdge,
                            child: suffixIcon,
                          ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey.shade400,
                            width: 1.5
                          ),
                          borderRadius: BorderRadius.circular(20.0)
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(
                            color: Colors.blue,
                            width: 2.0,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(
                            color: Colors.red,
                            width: 2.0,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(
                            color: Colors.blue,
                            width: 2.0,
                          ),
                        ),
                        isCollapsed: true,
                        contentPadding: EdgeInsets.fromLTRB(
                          18.0,
                          textListener.value ? 28.0 : 20.0,
                          18.0,
                          textListener.value ? 14.0 : 20.0,
                        )
                      ),
                    ),
                  );
                }
              ),
              if (hasText) Positioned(
                top: 8,
                left: 50,
                child: Text(
                  hintText,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade700
                  ),
                )
             ),
            ],
          );
        }
      ),
    );
  }
}

class CustomTextInputFormatter extends TextInputFormatter {

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (
      newValue.text.isEmpty ||
      RegExp(r'\d').hasMatch(newValue.text) &&
      newValue.text.length < 11
    ) {
      return TextEditingValue(text: newValue.text);
    }

    return TextEditingValue(text: oldValue.text);
  }
}