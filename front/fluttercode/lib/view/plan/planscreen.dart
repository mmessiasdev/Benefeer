import 'dart:convert';

import 'package:Benefeer/component/colors.dart';
import 'package:Benefeer/component/contentlocalproduct.dart';
import 'package:Benefeer/component/contentproduct.dart';
import 'package:Benefeer/component/padding.dart';
import 'package:Benefeer/component/texts.dart';
import 'package:Benefeer/component/widgets/header.dart';
import 'package:Benefeer/component/widgets/plancontainer.dart';
import 'package:Benefeer/component/widgets/searchInput.dart';
import 'package:Benefeer/model/plans.dart';
import 'package:Benefeer/service/local/auth.dart';
import 'package:Benefeer/service/remote/auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart'; // Pacote get para navegação

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
                      return Center(child: Text('Erro: ${snapshot.error}'));
                    } else if (snapshot.hasData) {
                      var response = snapshot.data
                          as http.Response; // Usa o alias 'http.Response'
                      var render =
                          jsonDecode(response.body) as Map<String, dynamic>;

                      // Verifica se o campo "plan" é nulo
                      if (render != null && render['plan'] == null) {
                        // Se for nulo, renderiza o widget codado
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding: defaultPaddingHorizon,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  const SizedBox(
                                    height: 40,
                                  ),
                                  SecundaryText(
                                      color: nightColor,
                                      text:
                                          "Você ainda não possui nenhum plano.",
                                      align: TextAlign.start),
                                  SizedBox(
                                    height: 40,
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
                                    height: 40,
                                  ),
                                  Icon(Icons.arrow_downward),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                height: 600,
                                child: Center(
                                  child: FutureBuilder<List<Plans>>(
                                      future: RemoteAuthService()
                                          .getPlans(token: token),
                                      builder: (context, planSnapshot) {
                                        if (planSnapshot.hasData) {
                                          return ListView.builder(
                                              shrinkWrap: true,
                                              scrollDirection: Axis.horizontal,
                                              itemCount:
                                                  planSnapshot.data!.length,
                                              itemBuilder: (context, index) {
                                                var renders =
                                                    planSnapshot.data![index];
                                                if (renders != null) {
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: PlanContainer(
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
                                          height: 300,
                                          child: Center(
                                            child: CircularProgressIndicator(
                                              color: nightColor,
                                            ),
                                          ),
                                        );
                                      }),
                                ),
                              ),
                            ),
                          ],
                        );
                      } else {
                        // Aqui, você não precisa do setState. Basta definir a variável idPlan diretamente.
                        idPlan = render['plan']['id'].toString();
                        print(idPlan);
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
                                      child: FutureBuilder<List<LocalStores>>(
                                        future: RemoteAuthService()
                                            .getOnePlansLocalStores(
                                                token: token, id: idPlan),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            print(
                                              RemoteAuthService()
                                                  .getOnePlansLocalStores(
                                                      token: token, id: idPlan),
                                            );
                                            return GridView.builder(
                                              gridDelegate:
                                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 2,
                                                crossAxisSpacing: 10,
                                                mainAxisSpacing: 5,
                                                childAspectRatio:
                                                    0.75, // Proporção padrão
                                              ),
                                              itemCount: snapshot.data!.length,
                                              itemBuilder: (context, index) {
                                                var renders =
                                                    snapshot.data![index];
                                                // Verificação se o idPlan não é nulo
                                                if (idPlan != null) {
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: ContentLocalProduct(
                                                      urlLogo: renders.urllogo
                                                          .toString(),
                                                      benefit: renders.benefit
                                                          .toString(),
                                                      title: renders.name
                                                          .toString(),
                                                      id: renders.id.toString(),
                                                    ),
                                                  );
                                                }
                                                return const SizedBox(
                                                  height: 100,
                                                  child: Center(
                                                    child:
                                                        Text('Não encontrado'),
                                                  ),
                                                );
                                              },
                                            );
                                          }
                                          return SizedBox(
                                            height: 300,
                                            child: Center(
                                              child: CircularProgressIndicator(
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
