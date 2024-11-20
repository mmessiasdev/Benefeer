import 'package:Benefeer/component/colors.dart';
import 'package:Benefeer/component/padding.dart';
import 'package:Benefeer/component/widgets/header.dart';
import 'package:Benefeer/component/widgets/plancontainer.dart';
import 'package:Benefeer/controller/auth.dart';
import 'package:Benefeer/model/plans.dart';
import 'package:Benefeer/service/local/auth.dart';
import 'package:Benefeer/service/remote/auth.dart';
import 'package:Benefeer/view/plan/planscreen.dart';
import 'package:flutter/material.dart';

class ListPlanScreen extends StatefulWidget {
  const ListPlanScreen({super.key});

  @override
  State<ListPlanScreen> createState() => _ListPlanScreenState();
}

class _ListPlanScreenState extends State<ListPlanScreen> {
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
    return SafeArea(
      child: Scaffold(
        backgroundColor: lightColor,
        body: ListView(
          children: [
            Padding(
              padding: defaultPaddingHorizon,
              child: MainHeader(
                  title: "Nossos Planos!",
                  maxl: 1,
                  icon: Icons.arrow_back_ios,
                  onClick: () {
                    Navigator.pop(context);
                  }),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 600,
              child: Center(
                child: FutureBuilder<List<Plans>>(
                    future: RemoteAuthService().getPlans(token: token),
                    builder: (context, planSnapshot) {
                      if (planSnapshot.hasData) {
                        return ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: planSnapshot.data!.length,
                            itemBuilder: (context, index) {
                              var renders = planSnapshot.data![index];
                              if (renders != null) {
                                return Padding(
                                  padding: defaultPaddingHorizon,
                                  child: PlanContainer(
                                      onClick: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => PlansScreen(
                                              id: renders.id,
                                            ),
                                          ),
                                        );
                                        // double valorPagamento =
                                        //     renders.value ?? 0.0;

                                        // bool pagamentoAprovado =
                                        //     await AuthController()
                                        //         .iniciarPagamentoMercadoPago(
                                        //             valorPagamento); // Valor do pagamento
                                      },
                                      bgcolor: getColorFromString(
                                          renders.color.toString()),
                                      name: renders.name.toString(),
                                      value: renders.value.toString(),
                                      rules: renders.rules.toString(),
                                      benefit: renders.benefits.toString()),
                                );
                              }
                              return const SizedBox(
                                height: 100,
                                child: Center(
                                  child: Text('Plano não encontrado'),
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
          ],
        ),
      ),
    );
  }
}
