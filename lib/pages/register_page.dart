import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/pages/controllers.dart';
import 'package:portfolio/utilities/text_field.dart';

final obscureText1Provider = StateProvider<bool>((ref) => true);
final obscureText2Provider = StateProvider<bool>((ref) => true);

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _password1Controller = TextEditingController();
  final _password2Controller = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _phoneNumberController.dispose();
    _password1Controller.dispose();
    _password2Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          backgroundColor: Colors.grey[300],
          body: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(height: 40),
                    const Icon(
                      Icons.phone_android,
                      size: 100,
                    ),
                    const SizedBox(height: 40),
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
                    Form(
                      key: _formKey,
                      child: Column(
                        children: <CustomTextFormField>[
                          CustomTextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            hintText: 'Email',
                            prefixIcon: const Icon(CupertinoIcons.mail),
                            validator: Controller.emailValidator,
                          ),
                          CustomTextFormField(
                            controller: _phoneNumberController,
                            keyboardType: TextInputType.phone,
                            hintText: 'Phone number',
                            prefixText: '+234 ',
                            prefixIcon: const Icon(CupertinoIcons.phone),
                            validator: Controller.phoneNumberValidator,
                          ),
                          CustomTextFormField(
                            controller: _password1Controller,
                            obscureText: ref.watch(obscureText1Provider),
                            hintText: 'Password',
                            prefixIcon: const Icon(CupertinoIcons.lock),
                            suffixIcon: IconButton(
                                onPressed: () => ref
                                    .read(obscureText1Provider.notifier)
                                    .update((state) => !state),
                                icon: Icon(ref.watch(obscureText1Provider)
                                    ? CupertinoIcons.eye_slash
                                    : CupertinoIcons.eye)),
                            validator: Controller.password1Validator,
                          ),
                          CustomTextFormField(
                            controller: _password2Controller,
                            textInputAction: TextInputAction.done,
                            hintText: 'Confirm password',
                            obscureText: ref.watch(obscureText2Provider),
                            prefixIcon: const Icon(CupertinoIcons.lock),
                            suffixIcon: IconButton(
                                onPressed: () => ref
                                    .read(obscureText2Provider.notifier)
                                    .update((state) => !state),
                                icon: Icon(ref.watch(obscureText2Provider)
                                    ? CupertinoIcons.eye_slash
                                    : CupertinoIcons.eye)),
                            validator: Controller.password2Validator,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Controller.onSignUp(
                          context,
                          _formKey,
                          _emailController,
                          _phoneNumberController,
                          _password1Controller,
                          _password2Controller,
                        );
                      },
                      style: ButtonStyle(
                          minimumSize: const MaterialStatePropertyAll(
                              Size(double.infinity, 42)),
                          shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0)))),
                      child: const Text(
                        'Sign In',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          'Already have an account?',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey),
                        ),
                        TextButton(
                          onPressed: () => Controller.onLoginNow(context),
                          child: const Text(
                            'Login Now',
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
          )),
    );
  }
}
