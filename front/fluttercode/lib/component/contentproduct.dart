import 'package:Benefeer/component/colors.dart';
import 'package:Benefeer/component/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ContentProduct extends StatelessWidget {
  const ContentProduct({super.key, required this.drules, required this.title});

  final String drules;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 15,
        ),
        Container(
          width: 150,
            decoration: BoxDecoration(
              color: lightColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 75,
                    height: 100,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: FourtyColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SubText(
                        color: lightColor,
                        text: drules,
                        align: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 1,
                    child: SecundaryText(
                      text: title,
                      color: nightColor,
                      align: TextAlign.start,
                    ),
                  ),
                ],
              ),
            )),
      ],
    );
  }
}
