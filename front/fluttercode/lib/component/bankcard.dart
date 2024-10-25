import 'dart:convert';

import 'package:Benefeer/component/colors.dart';
import 'package:Benefeer/component/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BankCard extends StatelessWidget {
  BankCard(
      {super.key,
      this.urllogo,
      this.qrCode,
      required this.name,
      required this.cpf});

  String? urllogo;
  String? qrCode;
  String name;
  String cpf;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [PrimaryColor, SecudaryColor],
            begin: Alignment.topCenter, // Início do degradê
            end: Alignment.bottomRight, // Fim do degradê
          ),
          borderRadius: BorderRadius.circular(17)),
      child: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            PrimaryText(
              color: nightColor,
              text: "Benefeer",
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SubText(text: name, align: TextAlign.start),
                    SecundaryText(
                        text: cpf,
                        color: nightColor,
                        align: TextAlign.start),
                  ],
                ),
                const SizedBox(width: 10),
                if (qrCode != null && qrCode!.startsWith('data:image'))
                  Align(
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                        height: 100, child: _buildQrCodeImage(qrCode!)),
                  )
                else
                  SizedBox(
                    height: 80,
                  )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildQrCodeImage(String base64String) {
  // Remove a parte 'data:image/png;base64,' da string
  final decodedBytes =
      base64Decode(base64String.split(',').last); // Decodifica a string Base64

  return ClipRRect(
    borderRadius: BorderRadius.circular(10),
    child: Image.memory(
      decodedBytes,
      fit: BoxFit.contain,
    ),
  );
}
