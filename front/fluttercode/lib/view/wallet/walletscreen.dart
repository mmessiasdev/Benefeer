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
import 'package:Benefeer/view/account/auth/signin.dart';
import 'package:Benefeer/view/wallet/balance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

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
  final _formKey = GlobalKey<FormState>();

  TextEditingController valueExit = TextEditingController();

  @override
  void dispose() {
    valueExit.dispose();
    super.dispose();
  }

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

  void _showDraggableScrollableSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          builder: (context, scrollController) {
            return Container(
                color: Colors.white,
                child: Padding(
                  padding: defaultPadding,
                  child: ListView(
                    children: [
                      SecundaryText(
                        text: "Selecione o valor que você deseja retirar",
                        color: nightColor,
                        align: TextAlign.center,
                      ),
                      InputLogin(
                        inputTitle: 'R\$',
                        controller: valueExit,
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Form(
                        key: _formKey,
                        child: Padding(
                          padding: defaultPadding,
                          child: GestureDetector(
                            onTap: () {
                              print('TESTEEE ${valueExit.text}');

                              // Substituindo a vírgula por ponto antes de tentar a conversão
                              String valueWithDot =
                                  valueExit.text.replaceAll(',', '.');

                              // Tentando converter o valor com ponto
                              double? exitValueDouble =
                                  double.tryParse(valueWithDot);

                              print(exitValueDouble);
                              print(currentBalanceDoublePrint);

                              if (exitValueDouble != null) {
                                if (currentBalanceDoublePrint >
                                    exitValueDouble) {
                                  if (_formKey.currentState!.validate()) {
                                    RemoteAuthService().postExitBalances(
                                        token: token,
                                        profileId: id,
                                        valueExit: valueWithDot
                                            .toString()); // Passa como string no formato correto
                                  }
                                } else {
                                  EasyLoading.showError("Saldo insuficiente.");
                                }
                              } else {
                                // Caso a conversão falhe, mostre uma mensagem de erro
                                print(
                                    "Valor inválido para conversão: ${valueExit.text}");
                              }
                            },
                            child: DefaultButton(
                              text: "Retirar",
                              padding: defaultPadding,
                              color: SeventhColor,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ));
          },
        );
      },
    );
  }

  String currentBalance = "";
  double currentBalanceDouble = 0;
  double currentBalanceDoublePrint = 0.0;

  bool _isActivated = false;

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
          // O total de saldo é exibido diretamente pelo FutureBuilder
          SizedBox(height: 25),
          Expanded(
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
                              color:
                                  screen == "saldo" ? nightColor : Colors.grey,
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
                            FutureBuilder<double>(
                              future: calculateTotalBalance(
                                  token: token, profileId: id),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                } else if (snapshot.hasError) {
                                  return SecundaryText(
                                      text:
                                          'Erro ao calcular saldo: ${snapshot.error}',
                                      color: nightColor,
                                      align: TextAlign.start);
                                } else if (snapshot.hasData) {
                                  currentBalanceDoublePrint = snapshot.data ??
                                      0.0; // Aqui inicializa a variável
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SubText(
                                        text: 'Saldo disponível:',
                                        color: nightColor,
                                        align: TextAlign.start,
                                      ),
                                      SecundaryText(
                                        text:
                                            'R\$${currentBalanceDoublePrint.toStringAsFixed(2)}',
                                        color: nightColor,
                                        align: TextAlign.start,
                                      ),
                                    ],
                                  );
                                } else {
                                  return Text('Nenhum dado encontrado');
                                }
                              },
                            ),
                            const SizedBox(
                              height: 25,
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
                            GestureDetector(
                              onTap: () {
                                _showDraggableScrollableSheet(context);
                              },
                              child: DefaultButton(
                                color: nightColor,
                                colorText: lightColor,
                                text: "Resgatar saldo",
                                padding: EdgeInsets.all(20),
                              ),
                            ),
                            SizedBox(
                              height: 25,
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
                                  // Padding(
                                  //   padding: defaultPaddingVertical,
                                  //   child: GestureDetector(
                                  //     child: Row(
                                  //       mainAxisAlignment:
                                  //           MainAxisAlignment.spaceBetween,
                                  //       children: [
                                  //         SecundaryText(
                                  //             text: "Entradas",
                                  //             color: nightColor,
                                  //             align: TextAlign.start),
                                  //         Icon(Icons.arrow_right),
                                  //       ],
                                  //     ),
                                  //     onTap: () {
                                  //       Navigator.push(
                                  //         context,
                                  //         MaterialPageRoute(
                                  //           builder: (context) =>
                                  //               EnterBalancesScreen(
                                  //             token: token,
                                  //             id: id,
                                  //           ),
                                  //         ),
                                  //       );
                                  //     },
                                  //   ),
                                  // ),
                                  // GestureDetector(
                                  //   child: Row(
                                  //     mainAxisAlignment:
                                  //         MainAxisAlignment.spaceBetween,
                                  //     children: [
                                  //       SecundaryText(
                                  //           text: "Saídas",
                                  //           color: nightColor,
                                  //           align: TextAlign.start),
                                  //       Icon(Icons.arrow_right),
                                  //     ],
                                  //   ),
                                  //   onTap: () {
                                  //     Navigator.push(
                                  //       context,
                                  //       MaterialPageRoute(
                                  //         builder: (context) =>
                                  //             ExitBalancesScreem(
                                  //           token: token,
                                  //           id: id,
                                  //         ),
                                  //       ),
                                  //     );
                                  //   },
                                  // ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SecundaryText(
                                        text: "Entradas",
                                        color: nightColor,
                                        align: TextAlign.center,
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      // Interruptor (Switch) para alternar entre ativar e desativar
                                      Switch(
                                        value:
                                            _isActivated, // Valor do switch (true ou false)
                                        onChanged: (bool newValue) {
                                          // Atualiza o estado quando o usuário muda a posição do switch
                                          setState(() {
                                            _isActivated = newValue;
                                          });
                                        },
                                        activeColor:
                                            FifthColor, // Cor do switch quando ativado
                                        inactiveThumbColor:
                                            SeventhColor, // Cor do thumb quando desativado
                                        activeTrackColor: OffColor,
                                        inactiveTrackColor:
                                            PrimaryColor, // Cor da trilha quando desativado
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      // Texto indicando o estado atual
                                      SecundaryText(
                                          text: 'Saídas',
                                          color: nightColor,
                                          align: TextAlign.center)
                                    ],
                                  ),
                                  _isActivated == false
                                      ? EnterBalancesScreen(
                                          token: token,
                                          id: id,
                                        )
                                      : ExitBalancesScreem(
                                          token: token,
                                          id: id,
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
        ],
      ),
    );
  }
}
