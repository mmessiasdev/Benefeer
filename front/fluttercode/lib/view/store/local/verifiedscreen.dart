import 'dart:io';

import 'package:Benefeer/component/buttons.dart';
import 'package:Benefeer/component/colors.dart';
import 'package:Benefeer/component/padding.dart';
import 'package:Benefeer/component/texts.dart';
import 'package:Benefeer/component/widgets/header.dart';
import 'package:Benefeer/controller/auth.dart';
import 'package:Benefeer/service/local/auth.dart';
import 'package:Benefeer/service/remote/auth.dart';
import 'package:Benefeer/view/dashboard/screen.dart';
import 'package:Benefeer/view/store/local/verfiedlocalstore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class VerifiedScreen extends StatefulWidget {
  VerifiedScreen({
    super.key,
    required this.imagePath,
    required this.localstoreId,
  });
  final String imagePath;
  int localstoreId;

  @override
  State<VerifiedScreen> createState() => _VerifiedScreenState();
}

class _VerifiedScreenState extends State<VerifiedScreen> {
  var profileId;
  var tokenId;

  @override
  void initState() {
    super.initState();
    getString();
  }

  void getString() async {
    var strProfileId = await LocalAuthService().getId("id");
    var strToken = await LocalAuthService().getSecureToken("token");

    // Verifique se o widget ainda está montado antes de chamar setState
    if (mounted) {
      setState(() {
        tokenId = strToken;
        profileId = strProfileId;
      });
    }
  }

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
                        File(widget.imagePath),
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
                                builder: (context) => DocumentScannerScreen(
                                  localstoreId: widget.localstoreId,
                                ),
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
                      onTap: () async {
                        // Obtenha o arquivo a partir do caminho
                        File imageFile = File(widget.imagePath);
                        // Chame a função, passando o arquivo diretamente
                        AuthController().uploadImageToStrapi(
                          token: tokenId,
                          profileId: profileId,
                          localStoreId: widget.localstoreId.toString(),
                          filePath: widget.imagePath,
                        );
                      },
                      child: DefaultButton(
                          color: FourtyColor,
                          padding: defaultPadding,
                          text: "Finalizar"),
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
