import 'package:Benefeer/component/colors.dart';
import 'package:Benefeer/component/inputdefault.dart';
import 'package:Benefeer/component/texts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Benefeer/extention/string_extention.dart';
import 'package:flutter/widgets.dart';

class InputRegister extends StatelessWidget {
  InputRegister({
    super.key,
    required this.textController,
    required this.title,
    required this.subdesc,
    required this.ftitle,
    required this.padding,
    required this.borderRadius,
    required this.subdescwid,
    this.password,
    this.aligh,
    this.textCondition,
  });
  TextEditingController textController;
  String title;
  String subdesc;
  String subdescwid;

  TextAlign? aligh;
  EdgeInsetsGeometry padding;
  BorderRadiusGeometry borderRadius;

  bool? ftitle;
  bool? password;

  String? Function(String?)? textCondition;

  Widget ImageThumb(context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: Opacity(
        opacity: 0.5,
        child: Image.asset(
          "assets/images/illustrator/Illustrator4.png",
          width: MediaQuery.of(context).size.width * 0.5,
          height: 242,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget textThumb(context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: RichDefaultText(
          text: subdesc,
          align: TextAlign.end,
          size: 20,
          fontweight: FontWeight.w300,
          wid: SubTextSized(
            align: TextAlign.end,
            fontweight: FontWeight.w600,
            text: subdescwid,
            size: 20,
            color: nightColor,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 100),
      child: Column(
        children: [
          Padding(
            padding: padding,
            child: InputTextField(
              title: title,
              fill: true,
              textEditingController: textController,
              validation: textCondition,
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          ftitle == true
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    textThumb(context),
                    ImageThumb(context),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ImageThumb(context),
                    textThumb(context),
                  ],
                )
        ],
      ),
    );
  }
}
