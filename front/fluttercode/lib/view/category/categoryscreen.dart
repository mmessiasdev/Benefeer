import 'package:Benefeer/component/buttons.dart';
import 'package:Benefeer/component/colors.dart';
import 'package:Benefeer/component/contentproduct.dart';
import 'package:Benefeer/component/padding.dart';
import 'package:Benefeer/component/texts.dart';
import 'package:Benefeer/component/widgets/header.dart';
import 'package:Benefeer/component/widgets/searchInput.dart';
import 'package:Benefeer/model/categories.dart';
import 'package:Benefeer/model/stores.dart';
import 'package:Benefeer/service/local/auth.dart';
import 'package:Benefeer/service/remote/auth.dart';
import 'package:Benefeer/view/store/storescreen.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatefulWidget {
  CategoryScreen({super.key, required this.id});
  var id;

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  var token;

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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: lightColor,
        body: token == "null"
            ? SizedBox()
            : ListView(
                children: [
                  FutureBuilder<Map>(
                      future: RemoteAuthService()
                          .getOneCategory(token: token, id: widget.id),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          var render = snapshot.data!;
                          return SizedBox(
                            child: Padding(
                              padding: defaultPadding,
                              child: Column(
                                children: [
                                  SearchInput(),
                                  MainHeader(
                                      title: render["name"],
                                      icon: Icons.arrow_back_ios,
                                      onClick: () {
                                        (Navigator.pop(context));
                                      }),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: SizedBox(
                                      height: 100,
                                      width:
                                          MediaQuery.of(context).size.width * 1,
                                      child: Image.network(
                                        render['illustrationurl'],
                                        height: 100,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Expanded(
                            child: Center(
                                child: SubText(
                              text: 'Erro ao pesquisar Categoria',
                              color: PrimaryColor,
                              align: TextAlign.center,
                            )),
                          );
                        }
                        return SizedBox(
                          height: 200,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: PrimaryColor,
                            ),
                          ),
                        );
                      }),
                  FutureBuilder<List<OnlineStore>>(
                    future: RemoteAuthService()
                        .getOneCategoryStories(token: token, id: widget.id),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return SizedBox(
                          height: 250,
                          child: ListView.builder(
                            scrollDirection:
                                Axis.horizontal, // Scroll horizontal aqui
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              var renders = snapshot.data![index];
                              if (renders != null) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ContentProduct(
                                    urlLogo: renders.logourl.toString(),
                                    drules:
                                        "${renders.percentcashback}% de cashback",
                                    title: renders.name.toString(),
                                    id: renders.id.toString(),
                                  ),
                                );
                              }
                              return const SizedBox(
                                height: 100,
                                child: Center(
                                  child: Text('Não encontrado'),
                                ),
                              );
                            },
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
                ],
              ),
      ),
    );
  }
}
