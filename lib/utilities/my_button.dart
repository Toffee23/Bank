import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String iconImagePath;
  final String buttonText;
  final VoidCallback? onPressed;

  const MyButton({
    Key? key,
    required this.iconImagePath,
    required this.buttonText,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      padding: const EdgeInsets.all(12.0),
      minWidth: 0,
      elevation: 0,
      color: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0)
      ),
      child: Column(
        children: [
          Container(
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: Colors.white,
                  blurRadius: 30,
                  spreadRadius: 10,
                )
              ],
            ),
            child: Image.asset(iconImagePath),
          ),
          const SizedBox(height: 8.0),
          Text(
            buttonText, // Use the buttonText variable here
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold, // Corrected the typo here
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }
}
