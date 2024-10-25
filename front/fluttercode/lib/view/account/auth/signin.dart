import 'package:Benefeer/component/defaultButton.dart';
import 'package:Benefeer/component/padding.dart';
import 'package:Benefeer/controller/auth.dart';
import 'package:Benefeer/view/account/auth/signup.dart';
import 'package:flutter/material.dart';
import 'package:Benefeer/component/colors.dart';
import 'package:Benefeer/component/widgets/header.dart';
import 'package:Benefeer/component/texts.dart';
import 'package:Benefeer/component/inputdefault.dart';
import 'package:get/get.dart';

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
        InputLogin(
          title: "CPF",
          controller: emailController,
          keyboardType: TextInputType.number,
        ),
        InputLogin(
          title: "Senha",
          controller: passwordController,
          obsecureText: true,
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: lightColor,
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: defaultPaddingHorizon,
              child: MainHeader(title: "Benefeer", onClick: () {}),
            ),
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DefaultCircleButton(
                            color: PrimaryColor,
                            iconColor: lightColor,
                            onClick: () {
                              if (_currentPage == _pages.length - 1) {
                                // Se for a última página, finalize o tutorial
                                if (_formKey.currentState!.validate()) {
                                  authController.signIn(
                                      email: emailController.text,
                                      password: passwordController.text);
                                }
                              } else {
                                // Caso contrário, vá para a próxima página
                                _pageController.nextPage(
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.easeIn,
                                );
                              }
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          RichDefaultText(
                            text: 'Não tem conta? ',
                            size: 12,
                            wid: GestureDetector(
                              onTap: () {
                                (
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SignUpScreen(),
                                    ),
                                  ),
                                );
                              },
                              child: SubText(
                                text: 'Crie uma aqui!',
                                align: TextAlign.start,
                                color: PrimaryColor,
                              ),
                            ),
                          )
                        ],
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
    ));
  }
}

class InputLogin extends StatelessWidget {
  InputLogin(
      {super.key,
      this.title,
      this.inputTitle,
      required this.controller,
      this.keyboardType,
      this.obsecureText});

  String? title;
  String? inputTitle;

  TextEditingController controller;
  bool? obsecureText;
  TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: defaultPaddingHorizonTop,
      child: Column(
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
              obsecureText: obsecureText ?? false,
              textEditingController: controller,
              textInputType: keyboardType ?? TextInputType.text,
              title: inputTitle ?? "",
              fill: true,
              maxLines: 1, // Define maxLines para 1
            ),
          ),
        ],
      ),
    );
  }
}
