import 'package:Benefeer/component/bankcard.dart';
import 'package:Benefeer/component/buttons.dart';
import 'package:Benefeer/component/colors.dart';
import 'package:Benefeer/component/padding.dart';
import 'package:Benefeer/component/texts.dart';
import 'package:Benefeer/component/tips.dart';
import 'package:Benefeer/component/widgets/header.dart';
import 'package:Benefeer/service/local/auth.dart';
import 'package:flutter/material.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  String screen = "saldo";

  var token;
  var fullname;
  var cpf;

  @override
  void initState() {
    super.initState();
    getString();
  }

  void getString() async {
    var strToken = await LocalAuthService().getSecureToken("token");
    var strFullName = await LocalAuthService().getFullName("fullname");
    var strCpf = await LocalAuthService().getCpf("cpf");

    if (mounted) {
      setState(() {
        cpf = strCpf.toString();
        fullname = strFullName.toString();
        token = strToken.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: defaultPaddingHorizon,
            child: MainHeader(
              title: "Carteira",
              onClick: () {},
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Expanded(
            child: Container(
              color: lightColor,
              child: Padding(
                padding: defaultPaddingHorizon,
                child: ListView(
                  children: [
                    Padding(
                      padding: defaultPaddingHorizonTop,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            child: SubText(
                              text: "Saldo",
                              align: TextAlign.center,
                              color: screen == "saldo" ? nightColor : OffColor,
                            ),
                            onTap: () {
                              setState(() {
                                screen = "saldo";
                              });
                            },
                          ),
                          GestureDetector(
                            child: SubText(
                              text: "Extrato",
                              align: TextAlign.center,
                              color:
                                  screen == "extract" ? nightColor : OffColor,
                            ),
                            onTap: () {
                              setState(() {
                                screen = "extract";
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    screen == "saldo"
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const SizedBox(
                                height: 40,
                              ),
                              BankCard(
                                cpf: cpf ?? "",
                                name: fullname ?? "",
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              Tips(
                                desc:
                                    "Após a compra de algum produto dentro do link do nosso app, o valor do cashback leva no máximo até 7 dias uteis para ser acrescentado na sua conta.",
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              DefaultButton(
                                color: nightColor,
                                colorText: lightColor,
                                text: "Resgatar saldo",
                                padding: EdgeInsets.all(20),
                              ),
                            ],
                          )
                        : SizedBox(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
