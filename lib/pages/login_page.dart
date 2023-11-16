import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/pages/controllers.dart';
import 'package:portfolio/pages/register_page.dart';

import '../utilities/text_field.dart';

final obscureTextProvider = StateProvider<bool>((ref) => true);

class LoginPage extends ConsumerStatefulWidget {
  final Function()? onTap;

  const LoginPage({Key? key, required this.onTap}) : super(key: key);

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          CustomTextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            hintText: 'Email',
                            prefixIcon: const Icon(CupertinoIcons.mail),
                            validator: Controller.emailValidator,
                          ),
                          CustomTextFormField(
                            controller: _passwordController,
                            obscureText: ref.watch(obscureText1Provider),
                            hintText: 'Password',
                            prefixIcon: const Icon(CupertinoIcons.lock),
                            suffixIcon: IconButton(
                                onPressed: () => ref
                                    .read(obscureTextProvider.notifier)
                                    .update((state) => !state),
                                icon: Icon(ref.watch(obscureTextProvider)
                                    ? CupertinoIcons.eye_slash
                                    : CupertinoIcons.eye)),
                            validator: Controller.password1Validator,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 10),

                    // sign in button
                    ElevatedButton(
                      onPressed: () {
                        Controller.onSignIn(
                          context,
                          _formKey,
                          _emailController,
                          _passwordController,
                        );
                      },
                      style: ButtonStyle(
                          shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
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
                              builder: (context) => const RegisterPage(),
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
      ),
    );
  }
}
