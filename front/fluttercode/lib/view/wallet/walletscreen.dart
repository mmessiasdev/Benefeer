import 'package:Benefeer/component/bankcard.dart';
import 'package:Benefeer/component/buttons.dart';
import 'package:Benefeer/component/colors.dart';
import 'package:Benefeer/component/padding.dart';
import 'package:Benefeer/component/texts.dart';
import 'package:Benefeer/component/tips.dart';
import 'package:Benefeer/component/widgets/header.dart';
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
  double totalBalance = 0.0; // Variável para armazenar o valor calculado

  @override
  void initState() {
    super.initState();
    getString();
  }

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

  // Função para calcular o saldo total
  Future<void> calculateTotalBalance() async {
    try {
      // Recuperando os dados das duas chamadas de API
      var balanceLocalStores = await RemoteAuthService()
          .getBalanceLocalStores(token: token, profileId: id);
      var exitBalances = await RemoteAuthService()
          .getExitBalances(token: token, profileId: id);

      // Calculando a soma dos valores de entradas (balance) e subtraindo as saídas (exit)
      double balanceSum = 0.0;
      double exitSum = 0.0;

      // Somando os valores de balance
      for (var render in balanceLocalStores) {
        balanceSum += double.parse(render.value.toString());
      }

      // Subtraindo os valores de exit
      for (var render in exitBalances) {
        exitSum += double.parse(render.value.toString());
      }

      // Calculando o total
      setState(() {
        totalBalance = balanceSum - exitSum;
      });
    } catch (e) {
      print("Erro ao calcular o saldo: $e");
    }
  }

  bool _isActivated = false;

  @override
  Widget build(BuildContext context) {
    // Chama o cálculo do saldo total sempre que a tela for carregada
    if (token != null && id != null) {
      calculateTotalBalance();
    }

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
          // Exibir o total de saldo calculado logo abaixo do MainHeader
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Saldo Total: R\$ ${totalBalance.toStringAsFixed(2)}',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
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
                                // child: Row(
                                //   mainAxisAlignment: MainAxisAlignment.center,
                                //   children: [
                                //     SecundaryText(
                                //       text: "Entradas",
                                //       color: nightColor,
                                //       align: TextAlign.center,
                                //     ),
                                //     SizedBox(
                                //       width: 15,
                                //     ),
                                //     // Interruptor (Switch) para alternar entre ativar e desativar
                                //     Switch(
                                //       value:
                                //           _isActivated, // Valor do switch (true ou false)
                                //       onChanged: (bool newValue) {
                                //         // Atualiza o estado quando o usuário muda a posição do switch
                                //         setState(() {
                                //           _isActivated = newValue;
                                //         });
                                //       },
                                //       activeColor:
                                //           FifthColor, // Cor do switch quando ativado
                                //       inactiveThumbColor:
                                //           SeventhColor, // Cor do thumb quando desativado
                                //       activeTrackColor: OffColor,
                                //       inactiveTrackColor:
                                //           PrimaryColor, // Cor da trilha quando desativado
                                //     ),
                                //     SizedBox(
                                //       width: 15,
                                //     ),
                                //     // Texto indicando o estado atual
                                //     SecundaryText(
                                //         text: 'Saídas',
                                //         color: nightColor,
                                //         align: TextAlign.center)
                                //   ],
                                // ),
                              ),
                              // _isActivated == false
                              //     ? EnterBalancesScreen(
                              //         token: token,
                              //         id: id,
                              //       )
                              //     : ExitBalancesScreem(
                              //         token: token,
                              //         id: id,
                              //       ),
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
