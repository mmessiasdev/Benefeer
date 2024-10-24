import 'dart:convert';

import 'package:Benefeer/component/colors.dart';
import 'package:Benefeer/component/containersLoading.dart';
import 'package:Benefeer/component/contentlocalproduct.dart';
import 'package:Benefeer/component/padding.dart';
import 'package:Benefeer/component/texts.dart';
import 'package:Benefeer/component/widgets/header.dart';
import 'package:Benefeer/model/plans.dart';
import 'package:Benefeer/service/local/auth.dart';
import 'package:Benefeer/service/remote/auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PlanScreen extends StatefulWidget {
  const PlanScreen({super.key});

  @override
  State<PlanScreen> createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
  var client = http.Client();
  var token;
  var idPlan;

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
    return Scaffold(
      backgroundColor: lightColor,
      body: token == null
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              children: [
                Padding(
                  padding: defaultPaddingHorizon,
                  child: MainHeader(
                      title: "Benefeer", icon: Icons.menu, onClick: () {}),
                ),
                FutureBuilder(
                  future: RemoteAuthService().getProfile(token: token),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return const WidgetLoading();
                    } else if (snapshot.hasData) {
                      var response = snapshot.data as http.Response;

                      // Verifica se o status da resposta é 200 (OK)
                      if (response.statusCode == 200) {
                        // Verifica se o conteúdo da resposta é JSON
                        try {
                          var render =
                              jsonDecode(response.body) as Map<String, dynamic>;

                          // Verifica se o campo "plan" é nulo
                          if (render != null && render['plan'] == null) {
                            // Código existente para renderizar o widget quando o plano é nulo
                            // ...
                          } else {
                            idPlan = render['plan']['id'].toString();
                            return Padding(
                              padding: defaultPaddingHorizon,
                              child: idPlan != null
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        SizedBox(
                                          height: 30,
                                        ),
                                        SecundaryText(
                                            text: "Seus beneficios",
                                            color: nightColor,
                                            align: TextAlign.start),
                                        SizedBox(
                                          height: 25,
                                        ),
                                        SizedBox(
                                          height:
                                              400, // Altura definida para o ListView
                                          child:
                                              FutureBuilder<List<LocalStores>>(
                                            future: RemoteAuthService()
                                                .getOnePlansLocalStores(
                                                    token: token, id: idPlan),
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData) {
                                                return ListView.builder(
                                                  shrinkWrap: true,
                                                  itemCount:
                                                      snapshot.data!.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    var renders =
                                                        snapshot.data![index];
                                                    // Verificação se o idPlan não é nulo
                                                    if (idPlan != null) {
                                                      return ContentLocalProduct(
                                                        urlLogo: renders.urllogo
                                                            .toString(),
                                                        benefit: renders.benefit
                                                            .toString(),
                                                        title: renders.name
                                                            .toString(),
                                                        id: renders.id
                                                            .toString(),
                                                      );
                                                    }
                                                    return SizedBox(
                                                      height: 100,
                                                      child: Center(
                                                          child: ErrorPost(
                                                              text:
                                                                  "Não encontrado")),
                                                    );
                                                  },
                                                );
                                              }
                                              return SizedBox(
                                                height: 300,
                                                child: Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    color: nightColor,
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    )
                                  : Text("data"),
                            );
                          }
                        } catch (e) {
                          // Exibe uma mensagem de erro se não conseguir decodificar JSON
                          return Center(
                            child: Text(
                                "Erro ao processar a resposta: ${e.toString()}"),
                          );
                        }
                      } else {
                        // Exibe o código de status HTTP e a resposta bruta
                        return Center(
                          child: ErrorPost(
                              text:
                                  "Plano não encontrado. \n\nVerifique sua conexão, por gentileza."),
                        );
                      }
                    } else {
                      return Center(
                        child: SecundaryText(
                          align: TextAlign.center,
                          color: nightColor,
                          text: "Nenhum Texto encontrado.",
                        ),
                      );
                    }
                    return CircularProgressIndicator();
                  },
                ),
                SizedBox(
                  height: 50,
                ),
              ],
            ),
    );
  }
}
