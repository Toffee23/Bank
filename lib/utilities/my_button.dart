import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String iconImagePath;
  final String buttonText;

  const MyButton({
    Key? key,
    required this.iconImagePath,
    required this.buttonText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // icon
        Container(
          height: 90,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            //color: Colors.grey[100],
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Colors.white,
                blurRadius: 30,
                spreadRadius: 10,
              )
            ],
          ),
          child: Center(
            child: Image.asset(iconImagePath),
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        // text
        Text(
          buttonText, // Use the buttonText variable here
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold, // Corrected the typo here
            color: Colors.grey[700],
          ),
        ),
      ],
    );
  }
}
