import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/pages/controllers.dart';
import 'package:portfolio/utilities/text_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _password1Controller = TextEditingController();
  final _password2Controller = TextEditingController();
  final _emailFocusNode = FocusNode();
  final _phoneNumberFocusNode = FocusNode();
  final _password1FocusNode = FocusNode();
  final _password2FocusNode = FocusNode();
  final _obscureText1Listener = ValueNotifier<bool>(true);
  final _obscureText2Listener = ValueNotifier<bool>(true);

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
        appBar: AppBar(
            elevation: 0,
            toolbarHeight: 0,
            backgroundColor: Colors.transparent,
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.dark,
            ),
          ),
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
                    children: <Widget>[
                      CustomTextFormField(
                        controller: _emailController,
                        focusNode: _emailFocusNode,
                        keyboardType: TextInputType.emailAddress,
                        hintText: 'Email',
                        prefixIcon: const Icon(CupertinoIcons.mail),
                        validator: Controller.emailValidator,
                      ),
                      CustomTextFormField(
                        controller: _phoneNumberController,
                        focusNode: _phoneNumberFocusNode,
                        keyboardType: TextInputType.phone,
                        hintText: 'Phone number',
                        prefixText: '+ 234 ',
                        inputFormatters: [CustomTextInputFormatter()],
                        prefixIcon: const Icon(CupertinoIcons.phone),
                        validator: Controller.phoneNumberValidator,
                      ),
                      ValueListenableBuilder<bool>(
                        valueListenable: _obscureText1Listener,
                        builder: (_, obscureText, __) {
                          return CustomTextFormField(
                            controller: _password1Controller,
                            focusNode: _password1FocusNode,
                            obscureText: obscureText,
                            hintText: 'Password',
                            prefixIcon: const Icon(Icons.lock_outline_rounded),
                            suffixIcon: IconButton(
                              onPressed: () => _obscureText1Listener.value = !obscureText,
                              icon: Icon(obscureText ?
                                CupertinoIcons.eye_slash : CupertinoIcons.eye
                              )
                            ),
                            validator: Controller.password1Validator,
                          );
                        }
                      ),
                      ValueListenableBuilder<bool>(
                        valueListenable: _obscureText2Listener,
                        builder: (_, obscureText, __) {
                          return CustomTextFormField(
                            controller: _password2Controller,
                            focusNode: _password2FocusNode,
                            textInputAction: TextInputAction.done,
                            hintText: 'Confirm password',
                            obscureText: obscureText,
                            prefixIcon: const Icon(Icons.lock_outline_rounded),
                            suffixIcon: IconButton(
                              onPressed: () => _obscureText2Listener.value = !obscureText,
                              icon: Icon(obscureText ?
                                CupertinoIcons.eye_slash : CupertinoIcons.eye
                              )
                            ),
                            validator: (value) => Controller.password2Validator(value, _password1Controller.text),
                          );
                        }
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
              ]
            ),
          ),
        )
      ),
    );
  }
}
