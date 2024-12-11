import 'package:Benefeer/component/buttons.dart';
import 'package:Benefeer/component/colors.dart';
import 'package:Benefeer/component/containersLoading.dart';
import 'package:Benefeer/component/contentlocalproduct.dart';
import 'package:Benefeer/component/contentproduct.dart';
import 'package:Benefeer/component/padding.dart';
import 'package:Benefeer/component/texts.dart';
import 'package:Benefeer/component/widgets/header.dart';
import 'package:Benefeer/component/widgets/searchInput.dart';
import 'package:Benefeer/model/categories.dart';
import 'package:Benefeer/model/localstores.dart';
import 'package:Benefeer/model/stores.dart';
import 'package:Benefeer/service/local/auth.dart';
import 'package:Benefeer/service/remote/auth.dart';
import 'package:Benefeer/view/store/online/storescreen.dart';
import 'package:flutter/material.dart';

class LocalStoreListScreen extends StatefulWidget {
  LocalStoreListScreen({super.key});

  @override
  State<LocalStoreListScreen> createState() => _LocalStoreListScreenState();
}

class _LocalStoreListScreenState extends State<LocalStoreListScreen> {
  @override
  var token;

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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: lightColor,
        body: token == null
            ? SizedBox()
            : Scaffold(
                backgroundColor: lightColor,
                body: ListView(
                  children: [
                    Padding(
                      padding: defaultPaddingHorizon,
                      child: MainHeader(
                        title: "Lojas locais",
                        icon: Icons.arrow_back_ios,
                        onClick: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Expanded(
                      child: FutureBuilder<List<LocalStores>>(
                        future:
                            RemoteAuthService().getLocalStores(token: token),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                                  ConnectionState.done &&
                              snapshot.hasData) {
                            if (snapshot.data!.isEmpty) {
                              return const Center(
                                child:
                                    Text("Nenhuma loja disponível no momento."),
                              );
                            } else {
                              return ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: 2,
                                itemBuilder: (context, index) {
                                  var renders = snapshot.data![index];
                                  // Verificação se o idPlan não é nulo
                                  return Padding(
                                    padding: defaultPadding,
                                    child: ContentLocalProduct(
                                      urlLogo: renders.urllogo.toString(),
                                      benefit: renders.benefit.toString(),
                                      title: renders.name.toString(),
                                      id: renders.id.toString(),
                                    ),
                                  );
                                },
                              );
                            }
                          } else if (snapshot.hasError) {
                            return WidgetLoading();
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
                )),
      ),
    );
  }
}
