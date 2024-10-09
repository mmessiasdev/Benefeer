import 'package:Benefeer/component/colors.dart';
import 'package:Benefeer/component/texts.dart';
import 'package:flutter/material.dart';

class Categorie extends StatelessWidget {
  Categorie({super.key, required this.title, this.illurl});

  String title;
  String? illurl;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Container(
          decoration: BoxDecoration(
            color: SecudaryColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: SizedBox(
                  child: Center(
                    child: SubText(text: title, align: TextAlign.start),
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: 50,
                  child: Opacity(
                    opacity: .50,
                    child: Image.network(
                      illurl ?? "",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
