import 'package:Benefeer/component/containersLoading.dart';
import 'package:Benefeer/component/contentproduct.dart';
import 'package:Benefeer/component/widgets/header.dart';
import 'package:Benefeer/component/widgets/iconlist.dart';
import 'package:Benefeer/component/widgets/listTitle.dart';
import 'package:Benefeer/component/widgets/searchInput.dart';
import 'package:Benefeer/model/categories.dart';
import 'package:Benefeer/model/stores.dart';
import 'package:Benefeer/service/remote/auth.dart';
import 'package:Benefeer/view/qrcode/qrcodescreen.dart';
import 'package:flutter/material.dart';
import 'package:Benefeer/component/colors.dart';
import 'package:Benefeer/component/padding.dart';
import 'package:Benefeer/component/texts.dart';
import 'package:Benefeer/service/local/auth.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var client = http.Client();

  String screen = "online";

  String? token;
  String? fname;
  var id;
  bool public = false;

  @override
  void initState() {
    super.initState();
    getString();
  }

  void getString() async {
    var strToken = await LocalAuthService().getSecureToken("token");
    var strFname = await LocalAuthService().getFname("fname");
    var strId = await LocalAuthService().getId("id");

    // Verifique se o widget ainda está montado antes de chamar setState
    if (mounted) {
      setState(() {
        token = strToken;
        id = strId;
        fname = strFname;
      });
    }
  }

  TextEditingController content = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController desc = TextEditingController();

  @override
  void dispose() {
    content.dispose();
    title.dispose();
    desc.dispose();
    super.dispose();
  }

  void toggleIcon() {
    setState(() {
      public = !public; // Alterna entre os ícones
    });
  }

  Widget ManutentionErro() {
    return ErrorPost(
      text: "Estamos passando por uma manutenção. Entre novamente mais tarde!",
    );
  }

  @override
  Widget build(BuildContext context) {
    return token == ""
        ? const SizedBox()
        : SafeArea(
            child: ListView(
              children: [
                Padding(
                  padding: defaultPaddingHorizon,
                  child: MainHeader(
                    title: "Benefeer",
                    icon: Icons.qr_code,
                    onClick: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QRCodeScannerPage(),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: defaultPaddingHorizon,
                  child: const SearchInput(),
                ),
                const SizedBox(height: 25),
                Padding(
                  padding: defaultPaddingHorizon,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconList(
                        title: "Perto de você",
                        icon: Icons.location_on,
                        onClick: () {},
                      ),
                      IconList(
                        title: "Recomendados",
                        icon: Icons.star,
                        onClick: () {},
                      ),
                      IconList(
                        title: "Ofertas Relâmpago",
                        icon: Icons.flash_on,
                        onClick: () {},
                      ),
                      IconList(
                        title: "Mais",
                        icon: Icons.more_horiz,
                        onClick: () {},
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(75),
                  ),
                  child: Container(
                    height: 75,
                    decoration: BoxDecoration(color: SecudaryColor),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          child: SubText(
                            text: "Online",
                            align: TextAlign.center,
                            color: screen == "online" ? nightColor : OffColor,
                          ),
                          onTap: () {
                            setState(() {
                              screen = "online";
                            });
                          },
                        ),
                        GestureDetector(
                          child: SubText(
                            text: "Perto de você",
                            align: TextAlign.center,
                            color: screen == "close" ? nightColor : OffColor,
                          ),
                          onTap: () {
                            setState(() {
                              screen = "close";
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  color: SecudaryColor,
                  child: Padding(
                    padding: defaultPaddingVertical,
                    child: screen == "online"
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Padding(
                                padding: defaultPaddingHorizon,
                                child: const ListTitle(title: "Destaques"),
                              ),
                              SizedBox(
                                height: 250, // Altura definida para o ListView
                                child: FutureBuilder<List<StoresModel>>(
                                  future: RemoteAuthService()
                                      .getStores(token: token),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                            ConnectionState.done &&
                                        snapshot.hasData) {
                                      if (snapshot.data!.isEmpty) {
                                        return const Center(
                                          child: Text(
                                              "Nenhuma loja disponível no momento."),
                                        );
                                      } else {
                                        return ListView.builder(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount: snapshot.data!.length,
                                          itemBuilder: (context, index) {
                                            var renders = snapshot.data![index];
                                            return ContentProduct(
                                              urlLogo:
                                                  renders.logourl.toString(),
                                              drules:
                                                  "${renders.percentcashback}% de cashback",
                                              title: renders.name.toString(),
                                              id: renders.id.toString(),
                                            );
                                          },
                                        );
                                      }
                                    } else if (snapshot.hasError) {
                                      return Center(
                                        child: Text(
                                          "Erro ao carregar dados: ${snapshot.error}",
                                        ),
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
                              SizedBox(
                                height: 40,
                              ),
                              Padding(
                                padding: defaultPaddingHorizon,
                                child: const ListTitle(title: "Eletrônicos"),
                              ),
                              SizedBox(
                                height: 250, // Altura definida para o ListView
                                child: FutureBuilder<List<OnlineStores>>(
                                  future: RemoteAuthService()
                                      .getOneCategoryStories(
                                          token: token, id: '1'),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                            ConnectionState.done &&
                                        snapshot.hasData) {
                                      if (snapshot.data!.isEmpty) {
                                        return const Center(
                                          child: Text(
                                              "Nenhuma loja disponível no momento."),
                                        );
                                      } else {
                                        return ListView.builder(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount: snapshot.data!.length,
                                          itemBuilder: (context, index) {
                                            var renders = snapshot.data![index];
                                            return ContentProduct(
                                              urlLogo:
                                                  renders.logourl.toString(),
                                              drules:
                                                  "${renders.percentcashback}% de cashback",
                                              title: renders.name.toString(),
                                              id: renders.id.toString(),
                                            );
                                          },
                                        );
                                      }
                                    } else if (snapshot.hasError) {
                                      return Center(
                                        child: Text(
                                          "Erro ao carregar dados: ${snapshot.error}",
                                        ),
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
                        : SizedBox(
                            height: MediaQuery.of(context).size.height * .5,
                            child: ErrorPost(
                              text: "Em breve!",
                            ),
                          ),
                  ),
                ),
              ],
            ),
          );
  }
}
