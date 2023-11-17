import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({
    Key? key,
    required this.message,
  }) : super(key: key);
  final String message;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const CupertinoActivityIndicator(
            radius: 16.0,
          ),
          const SizedBox(height: 15.0),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.blueGrey.shade600,
              letterSpacing: .6
            ),
          ),
        ],
      ),
    );
  }
}