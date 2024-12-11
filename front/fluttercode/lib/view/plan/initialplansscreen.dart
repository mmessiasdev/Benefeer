import 'dart:convert';

import 'package:Benefeer/component/bankcard.dart';
import 'package:Benefeer/component/colors.dart';
import 'package:Benefeer/component/containersLoading.dart';
import 'package:Benefeer/component/contentlocalproduct.dart';
import 'package:Benefeer/component/padding.dart';
import 'package:Benefeer/component/texts.dart';
import 'package:Benefeer/component/widgets/header.dart';
import 'package:Benefeer/component/widgets/plancontainer.dart';
import 'package:Benefeer/controller/auth.dart';
import 'package:Benefeer/model/plans.dart';
import 'package:Benefeer/service/local/auth.dart';
import 'package:Benefeer/service/remote/auth.dart';
import 'package:Benefeer/view/plan/listplanscreen.dart';
import 'package:Benefeer/view/plan/planscreen.dart';
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
    var strToken = await LocalAuthService().getSecureToken();

    setState(() {
      token = strToken.toString();
    });
  }

  // Método para converter string para cor
  Color getColorFromString(String color) {
    switch (color.toLowerCase()) {
      case 'red':
        return Colors.red;
      case 'black':
        return Colors.black;
      case 'yellow':
        return Colors.yellow;
      case 'green':
        return Colors.green;
      case 'blue':
        return Colors.blue;
      default:
        return PrimaryColor; // Cor padrão se a cor não for reconhecida
    }
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
                  child: MainHeader(title: "Benefeer"),
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
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Padding(
                                  padding: defaultPaddingHorizon,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      PlanViewUpdated(
                                          planname: 'Benefeer Free'),
                                      SizedBox(
                                        height: 35,
                                      ),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: SizedBox(
                                            height: 235,
                                            child: Image.asset(
                                              "assets/images/illustrator/illustrator2.png",
                                              fit: BoxFit.cover,
                                            )),
                                      ),
                                      SizedBox(
                                        height: 40,
                                      ),
                                      SubText(
                                        text:
                                            "Adquira para aproveitar o máximo de benefícios que temos a oferecer para você, sua família e sua empresa! ",
                                        color: nightColor,
                                        align: TextAlign.center,
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Icon(Icons.arrow_downward),
                                      SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 600,
                                  child: Center(
                                    child: FutureBuilder<List<Plans>>(
                                        future: RemoteAuthService()
                                            .getPlans(token: token),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            return ListView.builder(
                                                shrinkWrap: true,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount:
                                                    snapshot.data!.length,
                                                itemBuilder: (context, index) {
                                                  var renders =
                                                      snapshot.data![index];
                                                  if (renders != null) {
                                                    return Padding(
                                                      padding:
                                                          defaultPaddingHorizon,
                                                      child: PlanContainer(
                                                          onClick: () {
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        PlansScreen(
                                                                  id: renders
                                                                      .id,
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                          bgcolor:
                                                              getColorFromString(
                                                                  renders.color
                                                                      .toString()),
                                                          // esse widget será clicado
                                                          name: renders.name
                                                              .toString(),
                                                          value: renders.value
                                                              .toString(),
                                                          rules: renders.rules
                                                              .toString(),
                                                          benefit: renders
                                                              .benefits
                                                              .toString()),
                                                    );
                                                  }
                                                  return const SizedBox(
                                                    height: 100,
                                                    child: Center(
                                                      child: Text(
                                                          'Plano não encontrado'),
                                                    ),
                                                  );
                                                });
                                          }
                                          return SizedBox(
                                            height: 200,
                                            child: Center(
                                              child: CircularProgressIndicator(
                                                color: nightColor,
                                              ),
                                            ),
                                          );
                                        }),
                                  ),
                                ),
                              ],
                            );
                          } else {
                            idPlan = render['plan']['id'].toString();
                            return Padding(
                              padding: defaultPaddingHorizon,
                              child: idPlan != null
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        PlanViewUpdated(
                                          planname: render['plan']['name'],
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: SizedBox(
                                              height: 205,
                                              child: Image.asset(
                                                "assets/images/illustrator/illustrator1.png",
                                                fit: BoxFit.cover,
                                              )),
                                        ),
                                        SizedBox(
                                          height: 35,
                                        ),
                                        SecundaryText(
                                            text: "Seus beneficios",
                                            color: nightColor,
                                            align: TextAlign.start),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        FutureBuilder<List<PlanStores>>(
                                          future: RemoteAuthService()
                                              .getPlanStores(
                                                  token: token, id: idPlan),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                    ConnectionState.done &&
                                                snapshot.hasData) {
                                              if (snapshot.data!.isEmpty) {
                                                return const SizedBox(
                                                  height: 200,
                                                  child: Center(
                                                    child: Text(
                                                        "Nenhuma loja disponível no momento."),
                                                  ),
                                                );
                                              } else {
                                                return ListView.builder(
                                                  shrinkWrap: true,
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  itemCount:
                                                      snapshot.data!.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    var renders =
                                                        snapshot.data![index];
                                                    // Verificação se o idPlan não é nulo
                                                    return Padding(
                                                        padding: defaultPadding,
                                                        child: BankCard(
                                                          cpf: renders.name
                                                              .toString(),
                                                          name: renders.benefits
                                                              .toString(),
                                                          logo: renders.urlLogo,
                                                        ));
                                                  },
                                                );
                                              }
                                            } else if (snapshot.hasError) {
                                              return WidgetLoading();
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

class PlanViewUpdated extends StatelessWidget {
  PlanViewUpdated({super.key, required this.planname});

  String planname;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SubTextSized(
                fontweight: FontWeight.w400,
                size: 12,
                text: "Seu Plano:",
                color: nightColor,
                align: TextAlign.start),
            SizedBox(
              width: 5,
            ),
            SubText(
              text: planname,
              align: TextAlign.start,
              over: TextOverflow.fade,
              maxl: 2,
            ),
          ],
        ),
        SizedBox(
          width: 5,
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ListPlanScreen(),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: PrimaryColor,
            ),
            child: Padding(
              padding: defaultPadding,
              child: SubText(
                text: "Fazer Upgrade",
                align: TextAlign.center,
                color: lightColor,
              ),
            ),
          ),
        )
      ],
    );
  }
}
