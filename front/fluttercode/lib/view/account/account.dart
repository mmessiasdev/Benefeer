import 'package:Benefeer/component/defaultButton.dart';
import 'package:Benefeer/component/padding.dart';
import 'package:Benefeer/component/texts.dart';
import 'package:Benefeer/component/widgets/infotext.dart';
import 'package:Benefeer/component/widgets/title.dart';
import 'package:Benefeer/service/local/auth.dart';
import 'package:flutter/material.dart';
import 'package:Benefeer/component/widgets/header.dart';
import 'package:Benefeer/controller/controllers.dart';

import '../../component/defaultTitleButtom.dart';
import '../../component/colors.dart';
import '../../component/infoinputlogin.dart';
import 'auth/signin.dart';

class AccountScreen extends StatefulWidget {
  AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  var email;
  var fullname;
  var cpf;
  var id;
  var token;

  @override
  void initState() {
    super.initState();
    getString();
  }

  void getString() async {
    var strEmail = await LocalAuthService().getEmail();
    var strFullname = await LocalAuthService().getFullName();
    var strCpf = await LocalAuthService().getCpf();
    var strId = await LocalAuthService().getId();
    var strToken = await LocalAuthService().getSecureToken();

    setState(() {
      email = strEmail.toString();
      fullname = strFullname.toString();
      cpf = strCpf.toString();
      id = strId.toString();
      token = strToken.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    print(token);
    return Container(
      color: lightColor,
      child: Padding(
        padding: defaultPaddingHorizon,
        child: ListView(
          children: [
            DefaultTitle(
              buttom: true,
              title: "Seu perfil.",
            ),
            Column(
              children: [
                InfoText(
                    title: "Nome:", stitle: fullname == "null" ? "" : fullname),
                SizedBox(
                  height: 20,
                ),
                InfoText(title: "Email:", stitle: email == "null" ? "" : email),
                SizedBox(
                  height: 20,
                ),
                InfoText(title: "CPF:", stitle: cpf == "null" ? "" : cpf),
                SizedBox(
                  height: 70,
                ),
                DefaultTitleButton(
                  title: email == "null" ? "Entrar na conta" : "Sair da conta",
                  onClick: () {
                    if (token != "null") {
                      authController.signOut();
                      Navigator.pop(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignInScreen(),
                        ),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignInScreen(),
                        ),
                      );
                    }
                  },
                  color: FifthColor,
                  iconColor: lightColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
