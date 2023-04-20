import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterdemo/util/extension.dart';
import 'package:flutterdemo/values/app_colors.dart';

import '../../../views/my_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController textEditingController = TextEditingController(text: '');
  final GlobalKey<FormState> _formGlobalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorPrimary,
      body: SafeArea(
        child: Form(
          key: _formGlobalKey,
          autovalidateMode: AutovalidateMode.always,
          onChanged: () {
            _formGlobalKey.currentState?.validate();
            setState(() {});
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Image.asset('assets/images/logo.png'),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 22,
                    fontFamily: 'MyFont',
                    fontStyle: FontStyle.normal,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      MyTextField(
                        hint: 'Email',
                        icon: 'assets/images/email.png',
                        isPassword: false,
                        validator: (String? arg) {
                          if (arg == null || arg.isEmpty) {
                            return "Please enter email";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      MyTextField(
                          hint: 'Password',
                          icon: 'assets/images/password.png',
                          isPassword: true,
                          validator: (String? arg) {
                            if (arg == null || arg.isEmpty) {
                              return "Please enter password";
                            }
                            return null;
                          }),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        child: const Text('Forgot Password?'),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      MaterialButton(
                        elevation: 0,
                        onPressed: (_formGlobalKey.currentState != null &&
                                _formGlobalKey.currentState!.validate())
                            ? () {
                                context.hideKeyboard();
                                Navigator.of(context).pushNamed("intro");
                              }
                            : null,
                        disabledColor: Colors.grey,
                        color: Colors.orange,
                        textColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 50,
                              vertical: 8,
                            ),
                            child: Text('Login'),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: const [
                          Expanded(
                            child: Divider(color: Colors.black, thickness: 1),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: Text('OR'),
                          ),
                          Expanded(
                            child: Divider(
                              color: Colors.black,
                              thickness: 1,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/images/facebook.png'),
                          Image.asset('assets/images/google.png')
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("don't have an account? "),
                          GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                  "signup",
                                );
                              },
                              child: Text(
                                'Signup',
                                style: TextStyle(
                                    fontFamily: 'MyFont',
                                    fontStyle: FontStyle.italic),
                              ))
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool validEmail() {
    return false;
  }

  bool validPassword() {
    return false;
  }
}
