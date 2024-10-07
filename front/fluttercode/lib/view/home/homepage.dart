import 'package:Benefeer/component/containersLoading.dart';
import 'package:Benefeer/component/contentproduct.dart';
import 'package:Benefeer/component/widgets/header.dart';
import 'package:Benefeer/component/widgets/iconlist.dart';
import 'package:Benefeer/component/widgets/listTitle.dart';
import 'package:Benefeer/component/widgets/searchInput.dart';
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

    setState(() {
      token = strToken;
      id = strId;
      fname = strFname;
    });
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
    return SafeArea(
      child: ListView(
        children: [
          Padding(
            padding: defaultPaddingHorizon,
            child: Column(
              children: [
                MainHeader(
                  title: "Benefeer",
                  onClick: () => {},
                ),
                const SearchInput(),
                const SizedBox(
                  height: 25,
                ),
                Row(
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
                      title: "Ofertas Relampago",
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
              ],
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(75),
            ),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: SecudaryColor,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: defaultPadding,
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
                  Padding(
                    padding: defaultPaddingVertical,
                    child: screen == "online"
                        ? Expanded(
                            // Aqui é onde você usa o Expanded
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 40,
                                ),
                                Column(
                                  children: [
                                    Padding(
                                      padding: defaultPaddingHorizon,
                                      child: const SizedBox(
                                        width: double.infinity,
                                        child: ListTitle(
                                          title: "Destaques",
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 240,
                                      child: ListView(
                                        scrollDirection: Axis.horizontal,
                                        children: const [
                                          ContentProduct(
                                              drules: "7% de cashback",
                                              title:
                                                  "Magaluasdascascas  asc asasc a"),
                                          ContentProduct(
                                              drules: "7% de cashback",
                                              title: "Magalu"),
                                          ContentProduct(
                                              drules: "7% de cashback",
                                              title: "Magalu"),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 40,
                                    ),
                                    Padding(
                                      padding: defaultPaddingHorizon,
                                      child: const SizedBox(
                                        width: double.infinity,
                                        child: ListTitle(
                                          title: "Destaques",
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 240,
                                      child: ListView(
                                        scrollDirection: Axis.horizontal,
                                        children: const [
                                          ContentProduct(
                                              drules: "7% de cashback",
                                              title:
                                                  "Magaluasdascascas  asc asasc a"),
                                          ContentProduct(
                                              drules: "7% de cashback",
                                              title: "Magalu"),
                                          ContentProduct(
                                              drules: "7% de cashback",
                                              title: "Magalu"),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 40,
                                    ),
                                    Padding(
                                      padding: defaultPaddingHorizon,
                                      child: const SizedBox(
                                        width: double.infinity,
                                        child: ListTitle(
                                          title: "Destaques",
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 240,
                                      child: ListView(
                                        scrollDirection: Axis.horizontal,
                                        children: const [
                                          ContentProduct(
                                            drules: "7% de cashback",
                                            title:
                                                "Magaluasdascascas  asc asasc a",
                                          ),
                                          ContentProduct(
                                            drules: "7% de cashback",
                                            title: "Magalu",
                                          ),
                                          ContentProduct(
                                            drules: "7% de cashback",
                                            title: "Magalu",
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        : ErrorPost(text: "Em breve!"),
                  ), // Aqui deverá ficar em expanded
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
