import 'package:Benefeer/component/padding.dart';
import 'package:Benefeer/component/widgets/title.dart';
import 'package:Benefeer/view/dashboard/screen.dart';
import 'package:flutter/material.dart';
import 'package:Benefeer/component/colors.dart';
import 'package:Benefeer/component/texts.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
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
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Padding(
                padding: defaultPaddingHorizonTop,
                child: DefaultTitle(
                  buttom: true,
                  title: "Crie sua conta!",
                  subtitle: "Para se conectar com seus amigos ",
                  subbuttom: SubTextSized(
                    align: TextAlign.start,
                    fontweight: FontWeight.w600,
                    text: "ou com você mesmo.",
                    size: 20,
                    color: nightColor,
                  ),
                ),
              ),
              // Column(
              //   children: [
              //     InputRegister(
              //       borderRadius: const BorderRadius.only(
              //           bottomLeft: Radius.circular(40),
              //           topLeft: Radius.circular(40)),
              //       padding: defaultPaddingHorizon,
              //       ftitle: true,
              //       textController: usernameController,
              //       title: "Seu nickname",
              //       subdesc:
              //           "No Benefeer, você não precisa ser feliz o tempo todo. ",
              //       subdescwid: "Apenas seja você!",
              //     ),
              //     InputRegister(
              //       borderRadius: const BorderRadius.only(
              //           bottomLeft: Radius.circular(40),
              //           topLeft: Radius.circular(40)),
              //       padding: defaultPaddingHorizon,
              //       ftitle: true,
              //       textController: fnameController,
              //       title: "Seu primeiro nome: (o nome que será chamado)",
              //       subdesc:
              //           "No Benefeer, você não precisa ser feliz o tempo todo. ",
              //       subdescwid: "Apenas seja você!",
              //     ),
              //     InputRegister(
              //       borderRadius: const BorderRadius.only(
              //           bottomRight: Radius.circular(40),
              //           topRight: Radius.circular(40)),
              //       padding: defaultPaddingHorizon,
              //       ftitle: false,
              //       textController: lnameController,
              //       title: "Seu segundo nome:",
              //       subdesc: "Não se trata de uma rede social... ",
              //       subdescwid: "O Benefeer é um diário social.",
              //     ),
              //     InputRegister(
              //       borderRadius: const BorderRadius.only(
              //           bottomLeft: Radius.circular(40),
              //           topLeft: Radius.circular(40)),
              //       padding: defaultPaddingHorizon,
              //       ftitle: false,
              //       textController: emailController,
              //       title: "Seu email:",
              //       subdesc: "Poste o que quiser, aonde quiser e ",
              //       subdescwid: "para quem quiser!",
              //       textCondition: (String? value) {
              //         if (value == null || value.isEmpty) {
              //           return "Esse campo não pode ficar vazio.";
              //         } else if (!value.isValidEmail) {
              //           return "Insira os caracteres válido.";
              //         }
              //         return null;
              //       },
              //     ),
              //     InputRegister(
              //       borderRadius: const BorderRadius.only(
              //           bottomLeft: Radius.circular(40),
              //           topLeft: Radius.circular(40)),
              //       padding: defaultPaddingHorizon,
              //       ftitle: true,
              //       password: true,
              //       textController: passwordController,
              //       title: "Sua senha:",
              //       subdesc: "Aqui, a sua única obrigação é não ter medo. ",
              //       subdescwid:
              //           "Todas suas postagens são criptografadas por você.",
              //     ),
              //   ],
              // ),
              const SizedBox(height: 40),
              Padding(
                padding: defaultPaddingHorizon,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: RichDefaultText(
                            wid: GestureDetector(
                              onTap: () {
                                (
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const DashboardScreen(),
                                    ),
                                  ),
                                );
                              },
                              child: SubTextSized(
                                align: TextAlign.start,
                                color: FourtyColor,
                                size: 16,
                                text: "Entre",
                                fontweight: FontWeight.w600,
                                tdeco: TextDecoration.underline,
                              ),
                            ),
                            text: "Já tem um login? ",
                            align: TextAlign.start,
                            size: 16,
                            fontweight: FontWeight.normal)),
                    const SizedBox(
                      width: 20,
                    ),
                    CircleAvatar(
                      maxRadius: 40,
                      backgroundColor: FourtyColor,
                      child: GestureDetector(
                        child: Icon(
                          Icons.arrow_right_alt,
                          color: lightColor,
                        ),
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            // authController.signUp(
                            //   fname: fnameController.text,
                            //   lname: lnameController.text,
                            //   email: emailController.text,
                            //   username: usernameController.text,
                            //   password: passwordController.text,
                            // );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
