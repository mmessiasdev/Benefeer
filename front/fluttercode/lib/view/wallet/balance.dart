import 'package:Benefeer/component/colors.dart';
import 'package:Benefeer/component/padding.dart';
import 'package:Benefeer/component/texts.dart';
import 'package:Benefeer/component/widgets/header.dart';
import 'package:Benefeer/model/balancelocalstores.dart';
import 'package:Benefeer/model/verfiquedexitbalances.dart';
import 'package:Benefeer/service/remote/auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EnterBalancesScreen extends StatefulWidget {
  EnterBalancesScreen({super.key, required this.token, required this.id});
  var token;
  var id;

  @override
  State<EnterBalancesScreen> createState() => _EnterBalancesScreenState();
}

class _EnterBalancesScreenState extends State<EnterBalancesScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: defaultPadding,
            child: MainHeader(
              title: "Entradas de saldo",
              icon: Icons.arrow_back_ios,
              onClick: () {
                (Navigator.pop(context));
              },
            ),
          ),
          FutureBuilder<List<BalanceLocalStores>>(
              future: RemoteAuthService().getBalanceLocalStores(
                  token: widget.token, profileId: widget.id),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    // Caso os dados não existam ou estejam vazios, retorne algo como um "Nenhum dado encontrado".
                    return Text('Nenhum dado encontrado');
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data?.length ??
                        0, // Use o length para garantir que você não vai acessar um índice inválido
                    itemBuilder: (context, index) {
                      var renders = snapshot.data![index];
                      String formatDateTime(String dateTimeString) {
                        // Parse a string no formato ISO 8601 ("2024-11-16T14:09:31.396Z")
                        DateTime dateTime = DateTime.parse(dateTimeString);

                        // Formatar a data e hora para o formato brasileiro "dd/MM/yyyy HH:mm:ss"
                        String formattedDate =
                            DateFormat('dd/MM/yyyy HH:mm:ss').format(dateTime);

                        return formattedDate;
                      }

                      String formattedDate =
                          formatDateTime(renders.updatedAt.toString());
                      print(renders.createdAt);
                      return Padding(
                        padding: defaultPadding,
                        child: Container(
                          decoration: BoxDecoration(
                            color: FourtyColor,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: defaultPadding,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                SubText(
                                    text: '${renders.storeName.toString()}',
                                    align: TextAlign.start),
                                SizedBox(
                                  height: 2,
                                ),
                                SubTextSized(
                                  text:
                                      'R\$${double.parse(renders.value.toString())}'
                                          .replaceAll('.', ','),
                                  size: 12,
                                  fontweight: FontWeight.w900,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                SubText(
                                  text: '$formattedDate',
                                  align: TextAlign.end,
                                  color: OffColor,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return CircularProgressIndicator();
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
        ],
      ),
    );
  }
}

class ExitBalancesScreem extends StatefulWidget {
  ExitBalancesScreem({super.key, required this.token, required this.id});
  var token;
  var id;

  @override
  State<ExitBalancesScreem> createState() => _ExitBalancesScreemState();
}

class _ExitBalancesScreemState extends State<ExitBalancesScreem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: defaultPadding,
          child: MainHeader(
            title: "Saídas de saldo",
            icon: Icons.arrow_back_ios,
            onClick: () {
              (Navigator.pop(context));
            },
          ),
        ),
        FutureBuilder<List<VerfiquedExitBalances>>(
          future: RemoteAuthService()
              .getExitBalances(token: widget.token, profileId: widget.id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {
              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                // Caso os dados não existam ou estejam vazios, retorne algo como um "Nenhum dado encontrado".
                return const Text('Nenhum dado encontrado');
              }
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: snapshot.data?.length ??
                    0, // Use o length para garantir que você não vai acessar um índice inválido
                itemBuilder: (context, index) {
                  var renders = snapshot.data![index];
                  String formatDateTime(String dateTimeString) {
                    // Parse a string no formato ISO 8601 ("2024-11-16T14:09:31.396Z")
                    DateTime dateTime = DateTime.parse(dateTimeString);

                    // Formatar a data e hora para o formato brasileiro "dd/MM/yyyy HH:mm:ss"
                    String formattedDate =
                        DateFormat('dd/MM/yyyy HH:mm:ss').format(dateTime);

                    return formattedDate;
                  }

                  String formattedDate =
                      formatDateTime(renders.updatedAt.toString());
                  return Padding(
                    padding: defaultPadding,
                    child: Container(
                      decoration: BoxDecoration(
                        color: FifthColor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: defaultPadding,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SubTextSized(
                              text:
                                  'R\$${double.parse(renders.value.toString())}'
                                      .replaceAll('.', ','),
                              size: 12,
                              color: lightColor,
                              fontweight: FontWeight.w900,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SubText(
                              text: '$formattedDate',
                              align: TextAlign.start,
                              color: SecudaryColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return const CircularProgressIndicator();
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
      ],
    );
  }
}
