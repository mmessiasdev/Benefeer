import 'package:Benefeer/component/defaultButton.dart';
import 'package:flutter/material.dart';
import 'package:Benefeer/component/colors.dart';
import 'package:Benefeer/component/texts.dart';

class DefaultTitleButton extends StatelessWidget {
  final String title;
  final Function onClick;
  Color color;
  Color iconColor;
  DefaultTitleButton({
    Key? key,
    required this.title,
    required this.onClick,
    required this.color,
    required this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SubTextSized(text: title, size: 24, fontweight: FontWeight.bold),
          Defaultbutton(
            color: color,
            iconColor: iconColor,
            onClick: () {
              onClick();
            },
          ),
        ],
      ),
    );
  }
}
