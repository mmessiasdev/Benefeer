import 'package:Benefeer/component/bankcard.dart';
import 'package:Benefeer/component/buttons.dart';
import 'package:Benefeer/component/colors.dart';
import 'package:Benefeer/component/padding.dart';
import 'package:Benefeer/component/texts.dart';
import 'package:Benefeer/component/tips.dart';
import 'package:Benefeer/component/widgets/header.dart';
import 'package:flutter/material.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

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
                      padding: defaultPadding,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SubText(text: "Online", align: TextAlign.center),
                          SubText(
                              text: "Perto de você", align: TextAlign.center),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    const BankCard(),
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
                    DefaultButton(text: "Resgatar saldo",),
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
