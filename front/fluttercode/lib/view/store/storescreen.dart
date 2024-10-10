import 'package:Benefeer/component/buttons.dart';
import 'package:Benefeer/component/colors.dart';
import 'package:Benefeer/component/padding.dart';
import 'package:Benefeer/component/texts.dart';
import 'package:Benefeer/component/tips.dart';
import 'package:Benefeer/component/widgets/header.dart';
import 'package:Benefeer/service/local/auth.dart';
import 'package:Benefeer/service/remote/auth.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

class StoreScreen extends StatefulWidget {
  StoreScreen({super.key, required this.id});
  String id;

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  var client = http.Client();
  var email;
  var lname;
  var token;
  var id;
  var chunkId;
  var fileBytes;
  var fileName;

  @override
  void initState() {
    super.initState();
    getString();
  }

  void getString() async {
    var strToken = await LocalAuthService().getSecureToken("token");

    setState(() {
      token = strToken.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: lightColor,
        body: token == "null"
            ? SizedBox()
            : ListView(
                children: [
                  FutureBuilder<Map>(
                      future: RemoteAuthService()
                          .getStore(token: token, id: widget.id),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          var render = snapshot.data!;
                          return SizedBox(
                            child: Padding(
                              padding: defaultPaddingHorizon,
                              child: Column(
                                children: [
                                  MainHeader(
                                      title: render["name"],
                                      icon: Icons.arrow_back_ios,
                                      onClick: () {
                                        (Navigator.pop(context));
                                      }),
                                  Padding(
                                    padding: defaultPaddingVertical,
                                    child: SizedBox(
                                        height: 185,
                                        child:
                                            Image.network(render["logourl"])),
                                  ),
                                  Padding(
                                    padding: defaultPaddingVertical,
                                    child: Container(
                                      width:
                                          MediaQuery.of(context).size.width * 1,
                                      decoration: BoxDecoration(
                                        color: PrimaryColor,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SubText(
                                          color: lightColor,
                                          text:
                                              "${render["percentcashback"]}% de cashback",
                                          align: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: defaultPaddingVertical,
                                    child: SecundaryText(
                                      text: render["desc"],
                                      color: nightColor,
                                      align: TextAlign.start,
                                    ),
                                  ),
                                  Padding(
                                    padding: defaultPaddingVertical,
                                    child: DefaultButton(
                                      text: "Ativar cashback",
                                      color: nightColor,
                                      padding: defaultPadding,
                                      colorText: lightColor,
                                    ),
                                  ),
                                  Tips(
                                      desc:
                                          "Ao clicar em “Ativar cashback”, você será redirecionado ao site ou app."),
                                  Tips(
                                      desc:
                                          "Qualquer item comprado dentro do nosso link, será acrescentado dentro do seu seu saldo no nosso app!"),
                                  Tips(
                                      desc:
                                          "O saldo do cashback irá cair na sua conta em até no máximo 7 dias uteis.")
                                ],
                              ),
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Expanded(
                            child: Center(
                                child: SubText(
                              text: 'Erro ao pesquisar post',
                              color: PrimaryColor,
                              align: TextAlign.center,
                            )),
                          );
                        }
                        return SizedBox(
                          height: 200,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: PrimaryColor,
                            ),
                          ),
                        );
                      }),
                ],
              ),
      ),
    );
  }
}
