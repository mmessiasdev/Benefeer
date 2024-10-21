import 'dart:convert'; // Para trabalhar com JSON
import 'package:flutter/material.dart';
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
  String? dataResult; // Para armazenar os dados da API

  // Método para lidar com a leitura do QR Code e fazer a requisição à API
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
          var response = await http.get(Uri.parse(apiUrl));
          if (response.statusCode == 200) {
            // Decodifica o JSON da resposta
            var jsonData = jsonDecode(response.body);
            setState(() {
              dataResult = jsonData.toString(); // Armazena o resultado
              isLoading = false;
            });
          } else {
            setState(() {
              dataResult = "Erro ao carregar dados da API";
              isLoading = false;
            });
          }
        } catch (e) {
          setState(() {
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
    return Scaffold(
      appBar: AppBar(title: Text("QR Code Scanner")),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
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
                  : Text(
                      dataResult != null ? dataResult! : 'Escaneie um QR Code'),
            ),
          )
        ],
      ),
    );
  }
}
