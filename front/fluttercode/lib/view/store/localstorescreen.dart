import 'package:Benefeer/component/bankcard.dart';
import 'package:Benefeer/component/buttons.dart';
import 'package:Benefeer/component/colors.dart';
import 'package:Benefeer/component/padding.dart';
import 'package:Benefeer/component/texts.dart';
import 'package:Benefeer/component/tips.dart';
import 'package:Benefeer/component/widgets/header.dart';
import 'package:Benefeer/component/widgets/searchInput.dart';
import 'package:Benefeer/service/local/auth.dart';
import 'package:Benefeer/service/remote/auth.dart';
import 'package:Benefeer/view/store/verfiedlocalstore.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import 'package:flutter/material.dart';

class LocalStoreScreen extends StatefulWidget {
  LocalStoreScreen({super.key, required this.id});
  String id;

  @override
  State<LocalStoreScreen> createState() => _LocalStoreScreenState();
}

class _LocalStoreScreenState extends State<LocalStoreScreen> {
  var client = http.Client();
  var fullname;
  var cpf;

  var token;
  var fileBytes;
  var fileName;

  @override
  void initState() {
    super.initState();
    getString();
  }

  void getString() async {
    var strToken = await LocalAuthService().getSecureToken("token");
    var strFullName = await LocalAuthService().getFullName("fullname");
    var strCpf = await LocalAuthService().getCpf("cpf");

    setState(() {
      cpf = strCpf.toString();
      fullname = strFullName.toString();
      token = strToken.toString();
    });
  }

  // Função para abrir o link
  Future<void> _launchURL(urlAff) async {
    if (!await launchUrl(urlAff, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $urlAff';
    }
  }

  late String logo;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: lightColor,
        body: token == "null"
            ? const SizedBox()
            : ListView(
                children: [
                  FutureBuilder<Map>(
                      future: RemoteAuthService()
                          .getLocalStore(token: token, id: widget.id),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          var render = snapshot.data!;
                          logo = render["urllogo"];
                          return SizedBox(
                            child: Padding(
                              padding: defaultPaddingHorizon,
                              child: Column(
                                children: [
                                  MainHeader(
                                      title: "Benefeer",
                                      icon: Icons.arrow_back_ios,
                                      onClick: () {
                                        (Navigator.pop(context));
                                      }),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  FutureBuilder<Map>(
                                      future: RemoteAuthService()
                                          .getQrCodeLocalStore(
                                              id: widget.id, token: token),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          var renderQr = snapshot.data!;
                                          return BankCard(
                                            logo: logo,
                                            name: fullname,
                                            cpf: cpf,
                                            qrCode:
                                                renderQr["qrCode"].toString(),
                                          );
                                        } else if (snapshot.hasError) {
                                          return Expanded(
                                            child: Center(
                                                child: SubText(
                                              text: 'Erro ao pesquisar QR Code',
                                              color: PrimaryColor,
                                              align: TextAlign.center,
                                            )),
                                          );
                                        }
                                        return Padding(
                                          padding: defaultPadding,
                                          child: CircularProgressIndicator(),
                                        );
                                      }),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding: defaultPaddingVertical,
                                    child: Container(
                                      width:
                                          MediaQuery.of(context).size.width * 1,
                                      decoration: BoxDecoration(
                                        color: nightColor,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SubText(
                                          color: lightColor,
                                          text: "${render["benefit"]}",
                                          align: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: defaultPaddingVertical,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(Icons.location_on),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SubTextSized(
                                                  fontweight: FontWeight.w900,
                                                  size: 18,
                                                  text: render["name"],
                                                  color: nightColor,
                                                  align: TextAlign.start,
                                                ),
                                                SubText(
                                                  text: render["localization"],
                                                  color: nightColor,
                                                  align: TextAlign.start,
                                                ),
                                                SubTextSized(
                                                    size: 15,
                                                    fontweight: FontWeight.w600,
                                                    text: render["phone"],
                                                    color: nightColor,
                                                    align: TextAlign.start),
                                              ],
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Padding(
                                          padding: defaultPadding,
                                          child: const Divider(),
                                        ),
                                        SizedBox(
                                          child: GestureDetector(
                                            onTap: () {
                                              (
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          DocumentScannerScreen()),
                                                ),
                                              );
                                            },
                                            child: DefaultButton(
                                              text: "Pegar cashback",
                                              icon: Icons.attach_money,
                                              color: SeventhColor,
                                              padding: defaultPadding,
                                              colorText: lightColor,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: defaultPadding,
                                          child: const SizedBox(),
                                        ),
                                        SubText(
                                            color: OffColor,
                                            text: render["rules"]
                                                .replaceAll("\\n", "\n\n"),
                                            align: TextAlign.start),
                                      ],
                                    ),
                                  ),
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
