import 'package:Benefeer/component/defaultButton.dart';
import 'package:Benefeer/view/dashboard/screen.dart';
import 'package:Benefeer/view/posts/homepage.dart';
import 'package:flutter/material.dart';
import 'package:Benefeer/component/colors.dart';
import 'package:Benefeer/component/widgets/header.dart';
import 'package:Benefeer/component/texts.dart';
import 'package:Benefeer/controller/controllers.dart';
import 'package:Benefeer/extention/string_extention.dart';
import 'package:Benefeer/component/defaultTitleButtom.dart';
import 'package:Benefeer/component/inputdefault.dart';

import 'signup.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool checked = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightColor,
      body: ListView(
        children: [
          MainHeader(
              title: "Voltar",
              onClick: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DashboardScreen(),
                    ),
                  )),
          Padding(
            padding: const EdgeInsets.only(left: 40, right: 40, top: 75),
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Form(
                key: _formKey,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: PrimaryText(
                            text: 'Login',
                            color: nightColor,
                            align: TextAlign.start),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: InputTextField(
                          title: 'Email',
                          textEditingController: emailController,
                          validation: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "Esse campo não pode ficar vazio.";
                            } else if (!value.isValidEmail) {
                              return "Insira um email válido.";
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: InputTextField(
                          title: 'Password',
                          obsecureText: true,
                          maxLines: 1,
                          // icon: Icon(Icons.lock),
                          textEditingController: passwordController,
                          validation: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "Esse campo não pode ficar vazio.";
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 40),
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Defaultbutton(
                          iconColor: lightColor,
                          color: FourtyColor,
                          onClick: () {
                            if (_formKey.currentState!.validate()) {
                              // authController.signIn(
                              //     email: emailController.text,
                              //     password: passwordController.text);
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("É um novo usário? "),
                            InkWell(
                                onTap: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const SignUpScreen(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  "Crie uma conta.",
                                  style: TextStyle(
                                    color: Color.fromRGBO(19, 68, 90, 1),
                                  ),
                                ))
                          ],
                        ),
                      ),
                      const SizedBox(height: 10)
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
