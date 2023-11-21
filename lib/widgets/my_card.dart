import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";

class MyCard extends StatelessWidget {
  final String balance;
  final int phoneNumber;
  final bool isVisible;
  final VoidCallback? onVisibility;

  const MyCard({
    Key? key,
    required this.balance,
    required this.phoneNumber,
    required this.isVisible,
    this.onVisibility,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 15.0, 20, 0),
      child: Container(
        height: 140,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[
              Colors.tealAccent,
              Colors.teal,
              Colors.tealAccent,
            ],
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Stack(
          children: <Widget>[
            Column(
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
                        isVisible ? '₦ $balance' : '*****',
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
                        onPressed: onVisibility,
                        color: Colors.white70,
                        icon: const Icon(CupertinoIcons.eye),
                      ),
                    )
                  ],
                ),
                Text(
                  phoneNumber.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Positioned(
              top: -8,
              right: 10,
              child: Image.asset('icons/visa.png', height: 54),
            ),
            const Positioned(
              left: 10,
              bottom: 8,
              child: Text(
                'Virtual Card',
                style: TextStyle(
                  color: Colors.white,
                  letterSpacing: .7,
                  fontWeight: FontWeight.bold
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
