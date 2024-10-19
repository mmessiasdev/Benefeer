import 'package:Benefeer/component/bankcard.dart';
import 'package:Benefeer/component/buttons.dart';
import 'package:Benefeer/component/colors.dart';
import 'package:Benefeer/component/padding.dart';
import 'package:Benefeer/component/texts.dart';
import 'package:Benefeer/component/tips.dart';
import 'package:Benefeer/component/widgets/header.dart';
import 'package:flutter/material.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  String screen = "saldo";

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
            height: 50,
          ),
          Expanded(
            child: Container(
              color: EighthColor,
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
                            children: [
                              const SizedBox(
                                height: 40,
                              ),
                              BankCard(
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
