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
      elevation: 0,
      color: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0)
      ),
      child: Column(
        children: <Widget>[
          Card(
            elevation: 6,
            child: Container(
              height: 70,
              color: Theme.of(context).primaryColor.withOpacity(.07),
              padding: const EdgeInsets.all(15.0),
              child: Image.asset(iconImagePath),
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            buttonText,
            style: TextStyle(
              letterSpacing: .6,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    Key? key,
    this.onPressed,
    required this.text,
    this.icon,
  }) : super(key: key);
  final VoidCallback? onPressed;
  final String text;
  final Icon? icon;

  @override
  Widget build(BuildContext context) {
    return
      ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          textStyle: const MaterialStatePropertyAll(
            TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            )
          ),
          minimumSize: const MaterialStatePropertyAll(
            Size(double.infinity, 42)),
          shape: MaterialStatePropertyAll(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0)))),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(text),
            if (icon != null) const SizedBox(width: 10),
            if (icon != null) icon!,
          ],
        ),
      );
  }
}

