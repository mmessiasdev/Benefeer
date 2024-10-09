import 'package:flutter/material.dart';
import 'package:Benefeer/component/colors.dart';
import 'package:Benefeer/component/texts.dart';

class MainHeader extends StatelessWidget {
  MainHeader({Key? key, required this.title, required this.onClick, this.icon})
      : super(key: key);
  String title;
  final Function onClick;
  IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 25),
      child: SizedBox(
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            PrimaryText(
              color: nightColor,
              text: title,
            ),
            GestureDetector(
              onTap: () => onClick(),
              child: Icon(
                icon,
                size: 34,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
