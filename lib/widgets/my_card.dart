import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";

class MyCard extends StatefulWidget {
  final String balance;
  final int phoneNumber;
  final Color color;

  const MyCard({
    Key? key,
    required this.balance,
    required this.phoneNumber,
    required this.color,
  }) : super(key: key);

  @override
  State<MyCard> createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {
  bool isVisible = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 15.0, 20, 0),
      child: Container(
        height: 140,
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Wallet Balance',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 48.0),
                  child: Text(
                    isVisible ? '\u20a6 ${widget.balance}' : '*****',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Material(
                  color: Colors.transparent,
                  clipBehavior: Clip.hardEdge,
                  shape: const CircleBorder(),
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        isVisible = !isVisible;
                      });
                    },
                    color: Colors.white70,
                    icon: const Icon(CupertinoIcons.eye),
                  ),
                )
              ],
            ),
            Text(
              widget.phoneNumber.toString(),
              style: const TextStyle(
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
