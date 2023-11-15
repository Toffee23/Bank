import 'package:flutter/material.dart';

class LoginField extends StatelessWidget {
  const LoginField({
    Key? key,
    this.hintText,
  }) : super(key: key);
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: TextField(
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
          ),
        ),
      ),
    );
  }
}

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    Key? key,
    required this.hintText,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.obscureText = false,
    this.prefixText,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
  }) : super(key: key);
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final String hintText;
  final String? prefixText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final FormFieldValidator<String>? validator;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool isFocused = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Stack(
        children: <Widget>[
          TextFormField(
            controller: widget.controller,
            keyboardType: widget.keyboardType,
            textInputAction: widget.textInputAction,
            validator: widget.validator,
            obscureText: widget.obscureText,
            onChanged: (value) {
              setState(() {
                isFocused = value.isNotEmpty;
              });
            },
            decoration: InputDecoration(
              fillColor: Colors.grey.shade200,
              filled: true,
              hintText: widget.hintText,
              prefixText: widget.prefixText,
              prefixIcon: widget.prefixIcon == null ? null :
                Padding(
                  padding: const EdgeInsets.only(left: 4.0),
                  child: widget.prefixIcon,
                ),
              suffixIcon: widget.suffixIcon == null ? null :
                Card(
                  margin: const EdgeInsets.only(right: 4.0),
                  color: Colors.transparent,
                  elevation: 0.0,
                  shape: const CircleBorder(),
                  clipBehavior: Clip.hardEdge,
                  child: widget.suffixIcon,
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
                isFocused ? 28.0 : 20.0,
                18.0,
                isFocused ? 14.0 : 20.0,
              )
            ),
          ),
          if (isFocused) Positioned(
            top: 7,
            left: 45,
            child: Text(
              widget.hintText,
              style: const TextStyle(
                fontSize: 12
              ),
            )
          )
        ],
      ),
    );
  }
}
