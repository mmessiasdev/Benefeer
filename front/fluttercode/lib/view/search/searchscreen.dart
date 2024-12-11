import 'package:Benefeer/component/categorie.dart';
import 'package:Benefeer/component/colors.dart';
import 'package:Benefeer/component/containersLoading.dart';
import 'package:Benefeer/component/padding.dart';
import 'package:Benefeer/component/texts.dart';
import 'package:Benefeer/component/widgets/searchInput.dart';
import 'package:Benefeer/model/categories.dart';
import 'package:Benefeer/service/local/auth.dart';
import 'package:Benefeer/service/remote/auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
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
    var strToken = await LocalAuthService().getSecureToken();

    // Verifique se o widget ainda está montado antes de chamar setState
    if (mounted) {
      setState(() {
        token = strToken;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 40, horizontal: 15),
            child: SearchInput(),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(color: PrimaryColor),
              child: Padding(
                padding: defaultPadding,
                child: ListView(
                  children: [
                    FutureBuilder<List<CategoryModel>>(
                        future: RemoteAuthService().getCategories(token: token),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  var renders = snapshot.data![index];
                                  print(renders);
                                  if (renders != null) {
                                    return Column(
                                      children: [
                                        Center(
                                            child: Categorie(
                                          title: renders.name.toString(),
                                          illurl: renders.illustrationurl
                                              .toString(),
                                          id: renders.id.toString(),
                                        )),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                      ],
                                    );
                                  }
                                  return SizedBox(
                                      height: 300,
                                      child: ErrorPost(
                                          text:
                                              'Não encontrado. \n\nVerifique sua conexão, por gentileza.'));
                                });
                          }
                          return SizedBox(
                              height: 300,
                              child: ErrorPost(
                                  text:
                                      'Categorias não encontrada. \n\nVerifique sua conexão, por gentileza.'));
                        }),
                    SizedBox(
                      height: 20,
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
