import 'package:Benefeer/component/colors.dart';
import 'package:Benefeer/component/texts.dart';
import 'package:flutter/material.dart';

class BankCard extends StatelessWidget {
  BankCard({super.key, this.urllogo});

  String? urllogo;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 190,
      width: 340,
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [PrimaryColor, SecudaryColor],
            begin: Alignment.topCenter, // Início do degradê
            end: Alignment.bottomRight, // Fim do degradê
          ),
          borderRadius: BorderRadius.circular(17)),
      child: Padding(
        padding: const EdgeInsets.all(25),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PrimaryText(
                  color: nightColor,
                  text: "Benefeer",
                ),
                const SizedBox(
                  height: 10,
                ),
                RichDefaultText(
                  text: "Saldo diponível: \n",
                  size: 16,
                  fontweight: FontWeight.w300,
                  wid: SecundaryText(
                    text: "R\$ 0,00",
                    color: nightColor,
                    align: TextAlign.start,
                  ),
                )
              ],
            ),
            Image.network(urllogo ?? ""),
          ],
        ),
      ),
    );
  }
}
