import 'package:Benefeer/component/buttons.dart';
import 'package:Benefeer/component/colors.dart';
import 'package:Benefeer/component/padding.dart';
import 'package:Benefeer/component/texts.dart';
import 'package:Benefeer/component/widgets/header.dart';
import 'package:Benefeer/component/widgets/searchInput.dart';
import 'package:Benefeer/controller/auth.dart';
import 'package:Benefeer/service/local/auth.dart';
import 'package:Benefeer/service/remote/auth.dart';
import 'package:Benefeer/view/plan/qrcodebuyplan.dart';
import 'package:flutter/material.dart';

class PlansScreen extends StatefulWidget {
  PlansScreen({super.key, required this.id});
  var id;

  @override
  State<PlansScreen> createState() => _PlansScreenState();
}

class _PlansScreenState extends State<PlansScreen> {
  @override
  var token;

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
        body: ListView(
          children: [
            FutureBuilder<Map>(
                future: RemoteAuthService()
                    .getOnePlan(token: token, id: widget.id.toString()),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var render = snapshot.data!;
                    return SizedBox(
                      child: Padding(
                        padding: defaultPadding,
                        child: Column(
                          children: [
                            MainHeader(
                                title: render["name"],
                                icon: Icons.arrow_back_ios,
                                onClick: () {
                                  (Navigator.pop(context));
                                }),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: SizedBox(
                                height: 100,
                                width: MediaQuery.of(context).size.width * 1,
                                child: Image.network(
                                  render['illustrationurl'],
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 30),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  SizedBox(
                                    height: 30,
                                  ),
                                  SubText(
                                      text: "${render['desc']}",
                                      align: TextAlign.start),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Divider(),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  SubText(
                                      text: "Benefícios:",
                                      align: TextAlign.start),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  SubText(
                                      text: "${render['benefits']}"
                                          .replaceAll("\\n", "\n\n"),
                                      color: nightColor,
                                      align: TextAlign.start),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Divider(),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      SubText(
                                          text: "${render['rules']}"
                                              .replaceAll("\\n", "\n\n"),
                                          color: OffColor,
                                          align: TextAlign.start),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 60,
                                  ),
                                  PrimaryText(
                                    align: TextAlign.end,
                                    color: nightColor,
                                    text: "${render['value']}R\$",
                                  ),
                                  Padding(
                                    padding: defaultPaddingVertical,
                                    child: GestureDetector(
                                      onTap: () async {
                                        final paymentData =
                                            await AuthController()
                                                .iniciarPagamentoMercadoPago(
                                                    render['value']);

                                        if (paymentData != null) {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  QrCodeBuyPlanScreen(
                                                qrCode: paymentData[
                                                    'qrCodeBase64']!,
                                                qrCodeCopyPaste: paymentData[
                                                    'qrCodeCopyPaste']!,
                                              ),
                                            ),
                                          );
                                        } else {
                                          print(
                                              "Falha ao iniciar o pagamento.");
                                        }
                                      },
                                      child: DefaultButton(
                                        color: SeventhColor,
                                        colorText: lightColor,
                                        padding: defaultPadding,
                                        text: "Adquirir",
                                        icon: Icons.pix,
                                      ),
                                    ),
                                  ),
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
                        text: 'Erro ao pesquisar Plano',
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
