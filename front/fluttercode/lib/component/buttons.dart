import 'package:Benefeer/component/colors.dart';
import 'package:Benefeer/component/padding.dart';
import 'package:Benefeer/component/texts.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/request/request.dart';

class DefaultButton extends StatelessWidget {
  DefaultButton({super.key, required this.text, this.color, this.padding});
  String text;
  Color? color;
  EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(17),
        color: color ?? TerciaryColor,
      ),
      child: Padding(
        padding: padding ?? defaultPaddingHorizon,
        child: ButtonText(text: text),
      ),
    );
  }
}
