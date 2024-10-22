import 'package:Benefeer/component/buttons.dart';
import 'package:Benefeer/component/defaultButton.dart';
import 'package:Benefeer/component/padding.dart';
import 'package:Benefeer/controller/auth.dart';
import 'package:Benefeer/controller/controllers.dart';
import 'package:Benefeer/view/dashboard/screen.dart';
import 'package:flutter/material.dart';
import 'package:Benefeer/component/colors.dart';
import 'package:Benefeer/component/widgets/header.dart';
import 'package:Benefeer/component/texts.dart';
import 'package:Benefeer/extention/string_extention.dart';
import 'package:Benefeer/component/inputdefault.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:get/get_navigation/src/routes/default_transitions.dart';

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
  final AuthController authController = Get.put(AuthController());

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

  final PageController _pageController = PageController();
  int _currentPage = 0;

  List<Widget> get _pages => [
        InputLogin(title: "CPF", controller: emailController),
        InputLogin(title: "Senha", controller: passwordController),
      ];

  

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: lightColor,
      body: Padding(
        padding: defaultPaddingHorizon,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              MainHeader(title: "Benefeer", onClick: () {}),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemCount: _pages.length,
                  itemBuilder: (context, index) {
                    return _pages[index];
                  },
                ),
              ),
              SizedBox(
                height: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Botão "Voltar"
                    // if (_currentPage > 0)
                    //   GestureDetector(
                    //     onTap: () {
                    //       _pageController.previousPage(
                    //         duration: Duration(milliseconds: 300),
                    //         curve: Curves.easeIn,
                    //       );
                    //     },
                    //     child: DefaultButton(
                    //       text: "Voltar",
                    //       color: PrimaryColor,
                    //       padding:
                    //           EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    //     ),
                    //   ),
                    // Spacer(),
                    // Botão "Próximo" ou "Concluir"
                    GestureDetector(
                        onTap: () {
                          if (_currentPage == _pages.length - 1) {
                            // Se for a última página, finalize o tutorial
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignInScreen(),
                              ),
                            );
                          } else {
                            // Caso contrário, vá para a próxima página
                            _pageController.nextPage(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeIn,
                            );
                          }
                        },
                        child: DefaultCircleButton(
                          color: PrimaryColor,
                          iconColor: lightColor,
                          onClick: () {
                            if (_currentPage == _pages.length - 1) {
                              // Se for a última página, finalize o tutorial
                              print(emailController.text);
                              print(passwordController.text);
                              if (_formKey.currentState!.validate()) {
                                authController.signIn(
                                    email: emailController.text,
                                    password: passwordController.text);
                              }
                            } else {
                              // Caso contrário, vá para a próxima página
                              _pageController.nextPage(
                                duration: Duration(milliseconds: 300),
                                curve: Curves.easeIn,
                              );
                            }
                          },
                        )),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

class InputLogin extends StatelessWidget {
  InputLogin({super.key, required this.title, required this.controller});

  String title;
  TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        PrimaryText(
          color: nightColor,
          text: title,
        ),
        const SizedBox(
          height: 25,
        ),
        Padding(
          padding: defaultPaddingHorizon,
          child: InputTextField(
            textEditingController: controller,
            title: "",
            fill: true,
          ),
        ),
      ],
    );
  }
}
