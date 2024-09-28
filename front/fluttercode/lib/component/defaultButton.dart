import 'package:flutter/material.dart';

class Defaultbutton extends StatelessWidget {
  Defaultbutton(
      {super.key,
      required this.color,
      required this.iconColor,
      required this.onClick});
  Color color;
  Color iconColor;
  final Function onClick;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
        onClick();
      },
      child: CircleAvatar(
        maxRadius: 40,
        backgroundColor: color,
        child: Icon(
          Icons.arrow_right_alt,
          color: iconColor,
        ),
      ),
    );
  }
}
