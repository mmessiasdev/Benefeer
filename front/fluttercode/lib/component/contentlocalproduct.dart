import 'package:Benefeer/component/colors.dart';
import 'package:Benefeer/component/texts.dart';
import 'package:Benefeer/view/store/localstorescreen.dart';
import 'package:Benefeer/view/store/storescreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ContentLocalProduct extends StatelessWidget {
  ContentLocalProduct(
      {super.key,
      required this.benefit,
      required this.title,
      this.urlLogo,
      required this.id});

  final String benefit;
  final String title;
  final String? urlLogo;
  String id;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        (Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LocalStoreScreen(id: id)),
        ));
      },
      child: Container(
          width: 150,
          decoration: BoxDecoration(
            color: SecudaryColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  width: 75,
                  height: 100,
                  child: Image.network(urlLogo ?? "", fit: BoxFit.contain),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: PrimaryColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SubText(
                      color: lightColor,
                      text: benefit,
                      align: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 1,
                  height: 40,
                  child: Flexible(
                    child: SubText(
                      text: title,
                      color: nightColor,
                      align: TextAlign.start,
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
