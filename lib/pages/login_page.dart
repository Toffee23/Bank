import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/pages/home_page.dart';
import 'package:portfolio/pages/register_page.dart';

import '../utilities/text_field.dart';

class LoginPage extends StatelessWidget {
  final Function()? onTap;

  const LoginPage({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Icon(
                Icons.phone_android,
                size: 100,
              ),
              const SizedBox(height: 75),
              // Hello again!
              Text(
                'Hello Again!',
                style: GoogleFonts.bebasNeue(
                  fontSize: 52,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Welcome back',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 50),

              // email textfield

              const LoginField(hintText: "Email"),
              const LoginField(hintText: "Password"),

              const SizedBox(height: 10),

              // sign in button
              ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ),
                ),
                style: ButtonStyle(
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0))),
                    minimumSize: const MaterialStatePropertyAll(
                        Size(double.infinity, 42))),
                child: const SizedBox(
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      'Sign In',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 25),
              // not a member? register now
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Not a member?',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RegisterPage(
                          onTap: () {},
                        ),
                      ),
                    ),
                    child: const Text(
                      'Register Now',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
