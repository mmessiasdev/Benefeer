import 'package:Benefeer/component/bankcard.dart';
import 'package:Benefeer/component/buttons.dart';
import 'package:Benefeer/component/colors.dart';
import 'package:Benefeer/component/padding.dart';
import 'package:Benefeer/component/texts.dart';
import 'package:Benefeer/component/tips.dart';
import 'package:Benefeer/component/widgets/header.dart';
import 'package:Benefeer/model/balancelocalstores.dart';
import 'package:Benefeer/model/verfiquedexitbalances.dart';
import 'package:Benefeer/service/local/auth.dart';
import 'package:Benefeer/service/remote/auth.dart';
import 'package:Benefeer/view/wallet/balance.dart';
import 'package:flutter/material.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  String screen = "saldo";
  var token;
  var fullname;
  var cpf;
  var id;

  @override
  void initState() {
    super.initState();
    getString();
  }

  // Recuperar as informações de autenticação armazenadas
  void getString() async {
    var strToken = await LocalAuthService().getSecureToken("token");
    var strFullName = await LocalAuthService().getFullName("fullname");
    var strCpf = await LocalAuthService().getCpf("cpf");
    var strProfileId = await LocalAuthService().getId("id");

    if (mounted) {
      setState(() {
        cpf = strCpf.toString();
        id = strProfileId.toString();
        fullname = strFullName.toString();
        token = strToken.toString();
      });
    }
  }

  // Função assíncrona para calcular o saldo total
  Future<double> calculateTotalBalance({
    required String? token,
    required String? profileId,
  }) async {
    try {
      // Obter as entradas de saldo (BalanceLocalStores)
      List<BalanceLocalStores> balanceLocalStores = await RemoteAuthService()
          .getBalanceLocalStores(token: token, profileId: profileId);

      // Obter as saídas de saldo (VerfiquedExitBalances)
      List<VerfiquedExitBalances> exitBalances = await RemoteAuthService()
          .getExitBalances(token: token, profileId: profileId);

      double balanceSum = 0.0;
      double exitSum = 0.0;

      // Somar os valores de balance
      for (var balance in balanceLocalStores) {
        balanceSum += double.parse(balance.value.toString());
      }

      // Somar os valores de exit
      for (var exit in exitBalances) {
        exitSum += double.parse(exit.value.toString());
      }

      // Calcular o total
      return balanceSum - exitSum;
    } catch (e) {
      print("Erro ao calcular o saldo: $e");
      return 0.0; // Retorna 0 em caso de erro
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: defaultPaddingHorizon,
            child: MainHeader(
              title: "Carteira",
              onClick: () {},
            ),
          ),
          Center(
            // Utiliza o FutureBuilder para calcular e exibir o saldo total
            child: FutureBuilder<double>(
              future: calculateTotalBalance(token: token, profileId: id),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(); // Exibe o indicador de carregamento
                } else if (snapshot.hasError) {
                  return Text('Erro ao calcular saldo: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  return Text(
                    'Saldo Total: R\$${snapshot.data!.toStringAsFixed(2)}', // Exibe o saldo com 2 casas decimais
                    style: TextStyle(fontSize: 24),
                  );
                } else {
                  return Text('Nenhum dado encontrado');
                }
              },
            ),
          ),
          // O total de saldo é exibido diretamente pelo FutureBuilder
          SizedBox(height: 25),
          Expanded(
            child: Container(
              color: Colors.grey[100],
              child: Padding(
                padding: defaultPaddingHorizon,
                child: ListView(
                  children: [
                    Padding(
                      padding: defaultPaddingHorizonTop,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            child: Text(
                              "Saldo",
                              style: TextStyle(
                                color: screen == "saldo"
                                    ? nightColor
                                    : Colors.grey,
                                fontSize: 16,
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                screen = "saldo";
                              });
                            },
                          ),
                          GestureDetector(
                            child: Text(
                              "Extrato",
                              style: TextStyle(
                                color: screen == "extract"
                                    ? nightColor
                                    : Colors.grey,
                                fontSize: 16,
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                screen = "extract";
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    screen == "saldo"
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const SizedBox(
                                height: 40,
                              ),
                              BankCard(
                                cpf: cpf ?? "",
                                name: fullname ?? "",
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              Tips(
                                desc:
                                    "Após a compra de algum produto dentro do link do nosso app, o valor do cashback leva no máximo até 7 dias uteis para ser acrescentado na sua conta.",
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              DefaultButton(
                                color: nightColor,
                                colorText: lightColor,
                                text: "Resgatar saldo",
                                padding: EdgeInsets.all(20),
                              ),
                            ],
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 25,
                              ),
                              Padding(
                                padding: defaultPadding,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: defaultPaddingVertical,
                                      child: GestureDetector(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SecundaryText(
                                                text: "Entradas",
                                                color: nightColor,
                                                align: TextAlign.start),
                                            Icon(Icons.arrow_right),
                                          ],
                                        ),
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  EnterBalancesScreen(
                                                token: token,
                                                id: id,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    GestureDetector(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SecundaryText(
                                              text: "Saídas",
                                              color: nightColor,
                                              align: TextAlign.start),
                                          Icon(Icons.arrow_right),
                                        ],
                                      ),
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ExitBalancesScreem(
                                              token: token,
                                              id: id,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
