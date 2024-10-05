import 'package:Benefeer/component/colors.dart';
import 'package:Benefeer/component/texts.dart';
import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(17),
        color: TerciaryColor,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: ButtonText(text: "Resgatar Saldo"),
      ),
    );
  }
}
