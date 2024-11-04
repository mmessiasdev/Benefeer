import 'package:Benefeer/component/categorie.dart';
import 'package:Benefeer/component/containersLoading.dart';
import 'package:Benefeer/component/contentproduct.dart';
import 'package:Benefeer/component/widgets/header.dart';
import 'package:Benefeer/component/widgets/iconlist.dart';
import 'package:Benefeer/component/widgets/listTitle.dart';
import 'package:Benefeer/component/widgets/searchInput.dart';
import 'package:Benefeer/model/categories.dart';
import 'package:Benefeer/model/stores.dart';
import 'package:Benefeer/service/remote/auth.dart';
import 'package:Benefeer/view/account/account.dart';
import 'package:Benefeer/view/category/categoryscreen.dart';
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

    // Verifique se o widget ainda está montado antes de chamar setState
    if (mounted) {
      setState(() {
        token = strToken;
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
                      Container(
                        decoration: BoxDecoration(
                            color: SecudaryColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: GestureDetector(
                          onTap: () {
                            (Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AccountScreen()),
                            ));
                          },
                          child: Padding(
                            padding: defaultPadding,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.person),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  children: [
                                    SubText(
                                      text: 'Meu Perfil',
                                      align: TextAlign.start,
                                      color: nightColor,
                                    ),
                                    SubTextSized(
                                      text:
                                          'Verificar informações e sair da conta',
                                      size: 10,
                                      fontweight: FontWeight.w600,
                                      color: OffColor,
                                    )
                                  ],
                                )
                              ],
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

  @override
  Widget build(BuildContext context) {
    return token == null
        ? const SizedBox()
        : SafeArea(
            child: Scaffold(
              backgroundColor: lightColor,
              body: ListView(
                children: [
                  Padding(
                    padding: defaultPaddingHorizon,
                    child: MainHeader(
                      title: "Benefeer",
                      icon: Icons.menu,
                      onClick: () => _showDraggableScrollableSheet(context),
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
                          title: "Saúde",
                          icon: Icons.monitor_heart,
                          onClick: () {
                            (Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CategoryScreen(
                                        id: '2',
                                      )),
                            ));
                          },
                        ),
                        IconList(
                          title: "Eletrônicos",
                          icon: Icons.computer,
                          onClick: () {
                            (Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CategoryScreen(
                                        id: '1',
                                      )),
                            ));
                          },
                        ),
                        IconList(
                          title: "Beleza",
                          icon: Icons.brush,
                          onClick: () {
                            (Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CategoryScreen(
                                        id: '4',
                                      )),
                            ));
                          },
                        ),
                        IconList(
                          title: "Verificar Loja",
                          icon: Icons.qr_code,
                          onClick: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => QRCodeScannerPage(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(35),
                      topRight: Radius.circular(35),
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
                                  height:
                                      250, // Altura definida para o ListView
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
                                            itemCount: snapshot.data!.length,
                                            itemBuilder: (context, index) {
                                              var renders =
                                                  snapshot.data![index];
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
                                SizedBox(
                                  height: 40,
                                ),
                                Padding(
                                  padding: defaultPaddingHorizon,
                                  child: const ListTitle(title: "Eletrônicos"),
                                ),
                                SizedBox(
                                  height:
                                      250, // Altura definida para o ListView
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
                                              var renders =
                                                  snapshot.data![index];
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
            ),
          );
  }
}
