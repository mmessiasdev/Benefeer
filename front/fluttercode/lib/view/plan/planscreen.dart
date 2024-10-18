import 'package:Benefeer/component/colors.dart';
import 'package:Benefeer/component/padding.dart';
import 'package:Benefeer/component/texts.dart';
import 'package:Benefeer/component/widgets/header.dart';
import 'package:Benefeer/component/widgets/plancontainer.dart';
import 'package:Benefeer/component/widgets/searchInput.dart';
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
      body: ListView(
        children: [
          Padding(
            padding: defaultPaddingHorizon,
            child:
                MainHeader(title: "Benefeer", icon: Icons.menu, onClick: () {}),
          ),
          FutureBuilder(
              future: RemoteAuthService().getProfile(token: token),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Erro: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  var render = snapshot.data;
                  return PrimaryText(
                    color: nightColor,
                    text: render['fname'],
                  );
                } else {
                  return Center(
                    child: SecundaryText(
                      align: TextAlign.center,
                      color: nightColor,
                      text: "Nenhum Texto encontrado.",
                    ),
                  );
                }
              }),
          Padding(
            padding: defaultPaddingHorizon,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 40,
                ),
                SecundaryText(
                    color: nightColor,
                    text: "Você ainda não possui nenhum plano.",
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
                Icon(Icons.arrow_downward)
              ],
            ),
          ),
          SizedBox(
            height: 50,
          ),
          SizedBox(
            height: 600,
            child: Center(
              child: FutureBuilder<List<Plans>>(
                  future: RemoteAuthService().getPlans(token: token),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            var renders = snapshot.data![index];
                            print(renders);
                            if (renders != null) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: PlanContainer(
                                    name: renders.name.toString(),
                                    value: renders.value.toString(),
                                    rules: renders.rules.toString(),
                                    benefit: renders.benefits.toString()),
                              );
                            }
                            return const SizedBox(
                              height: 100,
                              child: Center(
                                child: Text('Não encontrado'),
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
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
