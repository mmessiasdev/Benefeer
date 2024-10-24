import 'dart:convert'; // Para trabalhar com JSON
import 'package:Benefeer/component/colors.dart';
import 'package:Benefeer/component/padding.dart';
import 'package:Benefeer/component/texts.dart';
import 'package:Benefeer/component/widgets/header.dart';
import 'package:Benefeer/service/local/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:http/http.dart' as http;

class QRCodeScannerPage extends StatefulWidget {
  @override
  _QRCodeScannerPageState createState() => _QRCodeScannerPageState();
}

class _QRCodeScannerPageState extends State<QRCodeScannerPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  bool isLoading = false;
  var dataResult; // Para armazenar os dados da API
  var token;

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

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      // Se estiver carregando, não faz outra requisição
      if (!isLoading) {
        setState(() {
          isLoading = true;
        });

        // Exemplo: O QR Code pode conter um URL ou um ID
        String apiUrl =
            scanData.code.toString(); // Pode ser um link direto ou ID

        try {
          var response = await http.get(
            Uri.parse(apiUrl),
            headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer $token",
              'ngrok-skip-browser-warning': "true"
            },
          );

          if (response.statusCode == 200) {
            EasyLoading.showSuccess('QR Code válido.');

            // Decodifica o JSON da resposta
            var jsonData = jsonDecode(response.body);

            // Atualiza o estado com os valores obtidos da API
            setState(() {
              dataResult = jsonData;
              isLoading = false;
            });
          } else {
            EasyLoading.showError('Erro ao carregar dados.');
            setState(() {
              dataResult = "Erro ao carregar dados da API";
              isLoading = false;
            });
          }
        } catch (e) {
          setState(() {
            EasyLoading.showError('QR Code válido não encontrado.');
            dataResult = "Falha na conexão: $e";
            isLoading = false;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: lightColor,
        body: Padding(
          padding: defaultPaddingHorizon,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              MainHeader(
                title: "Verifique o QR Code",
                onClick: () {
                  (Navigator.pop(context));
                },
                icon: Icons.arrow_back_ios,
                maxl: 2,
                over: TextOverflow.fade,
              ),
              SizedBox(
                height: 350,
                child: QRView(
                  key: qrKey,
                  onQRViewCreated: _onQRViewCreated,
                ),
              ),
              Expanded(
                flex: 1,
                child: Center(
                  child: isLoading
                      ? CircularProgressIndicator() // Mostra o loading
                      : dataResult != null &&
                              dataResult is Map &&
                              dataResult.containsKey("id")
                          ? Padding(
                              padding: defaultPaddingVertical,
                              child: ListView(
                                children: [
                                  Padding(
                                    padding: defaultPaddingVertical,
                                    child: Icon(
                                      Icons.verified,
                                      color: SeventhColor,
                                      size: 40,
                                    ),
                                  ),
                                  SecundaryText(
                                    align: TextAlign.start,
                                    color: nightColor,
                                    text: dataResult?["name"].toString() ?? "",
                                  ),
                                  SubText(
                                      text: dataResult?["localization"]
                                              .toString() ??
                                          "",
                                      align: TextAlign.start),
                                  Padding(
                                    padding: defaultPadding,
                                    child: Divider(),
                                  ),
                                  SubTextSized(
                                    text: dataResult?["rules"]
                                            .replaceAll("\\n", "\n\n") ??
                                        "",
                                    size: 15,
                                    fontweight: FontWeight.w600,
                                    color: OffColor,
                                  )
                                ],
                              ),
                            )
                          : dataResult != null && dataResult != Map
                              ? SizedBox(
                                  height: 300,
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.dangerous,
                                        color: FifthColor,
                                        size: 40,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      SecundaryText(
                                          text: "QR Code inválido.",
                                          color: nightColor,
                                          align: TextAlign.center),
                                    ],
                                  ),
                                )
                              : SizedBox(
                                  height: 300,
                                  child: Center(
                                    child: Column(
                                      children: [
                                        CircularProgressIndicator(
                                          color: PrimaryColor,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        SecundaryText(
                                          text: 'Escaneie um QR Code',
                                          color: nightColor,
                                          align: TextAlign.center,
                                        ),
                                      ],
                                    ),
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
