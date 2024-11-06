import 'dart:convert';
import 'package:Benefeer/component/buttons.dart';
import 'package:Benefeer/component/colors.dart';
import 'package:Benefeer/component/padding.dart';
import 'package:Benefeer/component/texts.dart';
import 'package:Benefeer/component/widgets/header.dart';
import 'package:Benefeer/view/dashboard/binding.dart';
import 'package:Benefeer/view/dashboard/screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

class QrCodeBuyPlanScreen extends StatelessWidget {
  QrCodeBuyPlanScreen(
      {super.key, required this.qrCode, required this.qrCodeCopyPaste});

  final String qrCode;
  final String qrCodeCopyPaste;

  Widget _buildQrCodeImage(String base64String) {
    final decodedBytes = base64Decode(
        base64String.split(',').last); // Decodifica a string Base64

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        color: lightColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.memory(
                decodedBytes,
                fit: BoxFit.contain,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Função para iniciar a compra do plano e monitorar o status do pagamento
  Future<void> iniciarCompraPlano(BuildContext context, double valor) async {
    var uuid = Uuid();
    String idempotencyKey = uuid.v4();

    final url = Uri.parse("https://api.mercadopago.com/v1/payments");

    final response = await http.post(
      url,
      headers: {
        "Authorization":
            "Bearer TEST-2869162016512406-102909-e3a08dc42979eadc840e775ebf8c7a28-1983614734",
        "X-Idempotency-Key": idempotencyKey,
      },
      body: jsonEncode({
        "transaction_amount": valor,
        "description": "Acesso especial",
        "payment_method_id": "pix",
        "payer": {"email": "mmessiasltk@gmail.com"}
      }),
    );

    if (response.statusCode == 201) {
      final paymentResponse = jsonDecode(response.body);
      final paymentId = paymentResponse['id'].toString();

      // Verifica o status do pagamento a cada 5 segundos até ser aprovado
      bool pagamentoAprovado = false;
      while (!pagamentoAprovado) {
        await Future.delayed(Duration(seconds: 5));
        pagamentoAprovado = await verificarStatusPagamento(paymentId);

        if (pagamentoAprovado) {
          print("Pagamento aprovado!");

          // Atualiza o plano na API Strapi
          await atualizarPlanoNaApi();

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content:
                    Text("Pagamento aprovado! Plano atualizado com sucesso.")),
          );

          // Volta para a tela principal após o sucesso
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => DashboardScreen(),
            ),
          );
          break;
        }
      }
    } else {
      print("Erro ao iniciar pagamento");
    }
  }

  // Função para verificar o status do pagamento
  Future<bool> verificarStatusPagamento(String paymentId) async {
    final url = Uri.parse("https://api.mercadopago.com/v1/payments/$paymentId");

    final response = await http.get(
      url,
      headers: {
        "Authorization":
            "Bearer TEST-2869162016512406-102909-e3a08dc42979eadc840e775ebf8c7a28-1983614734",
      },
    );

    if (response.statusCode == 200) {
      final paymentResponse = jsonDecode(response.body);
      return paymentResponse['status'] == "approved";
    } else {
      print("Erro ao verificar o status: ${response.statusCode}");
      return false;
    }
  }

  // Função para atualizar o plano na API Strapi
  Future<void> atualizarPlanoNaApi() async {
    final url = Uri.parse("https://sua-api.com/endpoint-de-atualizacao");

    final response = await http.post(
      url,
      headers: {
        "Authorization": "Bearer SEU_TOKEN_STRAPI",
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "usuarioId": "ID_DO_USUARIO",
        "novoPlano": "ID_DO_PLANO_COMPRADO",
      }),
    );

    if (response.statusCode == 200) {
      print("Plano atualizado com sucesso na API");
    } else {
      print("Erro ao atualizar o plano: ${response.statusCode}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: lightColor,
      body: ListView(
        children: [
          const SizedBox(width: 20),
          Padding(
            padding: defaultPaddingHorizon,
            child: Column(
              children: [
                MainHeader(
                  title: "Finalizar compra",
                  icon: Icons.pix,
                ),
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(child: _buildQrCodeImage(qrCode)),
                ),
                SizedBox(
                  child: GestureDetector(
                    onTap: () {
                      Clipboard.setData(ClipboardData(text: qrCodeCopyPaste));
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            backgroundColor: PrimaryColor,
                            content: Text(
                                "Texto copiado para a área de transferência!")),
                      );
                    },
                    child: Column(
                      children: [
                        SecundaryText(
                            text: "Pix Copia e cola",
                            color: nightColor,
                            align: TextAlign.start),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.pix,
                              size: 30,
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: SubText(
                                text: qrCodeCopyPaste,
                                color: nightColor,
                                align: TextAlign.center,
                                maxl: 2,
                                over: TextOverflow.fade,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        DefaultButton(
                          text: "Copiar",
                          icon: Icons.paste_rounded,
                          color: SecudaryColor,
                          padding: defaultPadding,
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Divider(),
                SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {
                    iniciarCompraPlano(context,
                        100.0); // Substitua "100.0" pelo valor do plano
                  },
                  child: DefaultButton(
                    text: "Já fiz o pagamento!",
                    padding: defaultPadding,
                    color: FourtyColor,
                    colorText: lightColor,
                    icon: Icons.check,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DashboardScreen(),
                      ),
                    );
                  },
                  child: DefaultButton(
                    text: "Desistir",
                    padding: defaultPadding,
                    color: FifthColor,
                    colorText: lightColor,
                    icon: Icons.error,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
