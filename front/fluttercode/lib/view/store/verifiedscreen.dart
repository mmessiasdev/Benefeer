import 'dart:io';

import 'package:Benefeer/component/buttons.dart';
import 'package:Benefeer/component/colors.dart';
import 'package:Benefeer/component/padding.dart';
import 'package:Benefeer/component/texts.dart';
import 'package:Benefeer/component/widgets/header.dart';
import 'package:Benefeer/view/dashboard/screen.dart';
import 'package:Benefeer/view/store/verfiedlocalstore.dart';
import 'package:flutter/material.dart';

class VerifiedScreen extends StatelessWidget {
  const VerifiedScreen({super.key, required this.imagePath});
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: lightColor,
        body: Padding(
          padding: defaultPaddingHorizon,
          child: ListView(
            children: [
              MainHeader(
                title: "Parabens!",
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SecundaryText(
                      text: 'Parabens pela ótima compra!',
                      color: nightColor,
                      align: TextAlign.start,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SubText(
                      text:
                          "Iremos válidar seu comprovante e em até 7 dias, se a compra for confirmada, o saldo irá cair na sua conta!",
                      align: TextAlign.start,
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    SizedBox(
                      height: 400,
                      child: Image.file(
                        File(imagePath),
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SubText(
                          text: "A foto não ficou legal?",
                          align: TextAlign.center,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            (Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DocumentScannerScreen(),
                              ),
                            ));
                          },
                          child: DefaultButton(
                              color: SecudaryColor,
                              padding: EdgeInsetsDirectional.symmetric(
                                  vertical: 10, horizontal: 10),
                              text: "Tirar outra foto"),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    GestureDetector(
                      onTap: () {
                        (Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const DashboardScreen()),
                        ));
                      },
                      child: DefaultButton(
                          color: FourtyColor,
                          padding: defaultPadding,
                          text: "FInalizar"),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
