import 'package:Benefeer/component/containersLoading.dart';
import 'package:Benefeer/component/padding.dart';
import 'package:Benefeer/component/post.dart';
import 'package:Benefeer/component/widgets/logincont.dart';
import 'package:Benefeer/component/widgets/title.dart';
import 'package:Benefeer/model/postsnauth.dart';
import 'package:Benefeer/model/profiles.dart';
import 'package:Benefeer/service/remote/auth.dart';
import 'package:flutter/material.dart';
import 'package:Benefeer/component/widgets/header.dart';
import 'package:Benefeer/service/local/auth.dart';
import 'package:Benefeer/view/account/account.dart';
import 'package:Benefeer/view/account/auth/signin.dart';
import 'package:Benefeer/view/home/search/searchpost.dart';

import '../../component/colors.dart';
import '../../component/texts.dart';

class MyContents extends StatefulWidget {
  MyContents({Key? key}) : super(key: key);

  @override
  State<MyContents> createState() => _MyContentsState();
}

class _MyContentsState extends State<MyContents> {
  var email;
  var lname;
  var fname;
  var profileId;
  var token;
  var chunkId;

  @override
  void initState() {
    super.initState();
    getString();
  }

  void getString() async {
    var strEmail = await LocalAuthService().getEmail("email");
    var strFname = await LocalAuthService().getFname("fname");
    var strFull = await LocalAuthService().getLname("lname");
    var strId = await LocalAuthService().getId("id");
    var strToken = await LocalAuthService().getSecureToken("token");

    setState(() {
      email = strEmail.toString();
      lname = strFull.toString();
      fname = strFname.toString();
      profileId = strId.toString();
      token = strToken.toString();
    });
  }

  Widget ManutentionErro() {
    return ErrorPost(
      text: "Estamos passando por uma manutenção. Entre novamente mais tarde!",
    );
  }

  @override
  Widget build(BuildContext context) {
    return token != "null"
        ? Scaffold(
            backgroundColor: lightColor,
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                (Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AccountScreen(),
                  ),
                ));
              },
              backgroundColor: FourtyColor,
              splashColor: FourtyColor,
              foregroundColor: FourtyColor,
              focusColor: FourtyColor,
              child: Icon(
                Icons.person,
                color: lightColor,
              ),
            ),
            body: SafeArea(
                child: Padding(
              padding: defaultPaddingHorizon,
              child: ListView(
                children: [
                  DefaultTitle(
                    title: "Seu diário.",
                    align: TextAlign.start,
                    subtitle: "Aqui ficam localizada todas suas postagens ",
                    subbuttom: SubTextSized(
                      fontweight: FontWeight.w600,
                      text: "públicas ou não.",
                      size: 20,
                      color: nightColor,
                    ),
                  ),
                  // FutureBuilder<List<Posts>>(
                  //   future: RemoteAuthService()
                  //       .getMyPosts(token: token, profileId: profileId),
                  //   builder: (context, snapshot) {
                  //     if (snapshot.connectionState == ConnectionState.waiting) {
                  //       return const PostsLoading();
                  //     } else if (snapshot.hasError) {
                  //       return Center(child: ManutentionErro());
                  //     } else if (snapshot.hasData) {
                  //       var posts = snapshot.data!;
                  //       return ListView.builder(
                  //         itemCount: posts.length,
                  //         scrollDirection: Axis.vertical,
                  //         physics: const NeverScrollableScrollPhysics(),
                  //         shrinkWrap: true,
                  //         itemBuilder: (context, index) {
                  //           var render = posts[index];
                  //           return Padding(
                  //             padding: const EdgeInsets.symmetric(vertical: 15),
                  //             child: WidgetPosts(
                  //               plname: fname + " " + lname,
                  //               title: render.title.toString(),
                  //               desc: render.content.toString(),
                  //               updatedAt: "teste",
                  //               id: render.id.toString(),
                  //             ),
                  //           );
                  //         },
                  //       );
                  //     }
                  //     return SizedBox.shrink();
                  //   },
                  // ),
                ],
              ),
            )),
          )
        : Padding(
            padding: defaultPaddingHorizon,
            child: ListView(
              children: [
                DefaultTitle(
                  title: "Seu diário.",
                  align: TextAlign.start,
                  subtitle: "Aqui ficam localizada todas suas postagens ",
                  subbuttom: SubTextSized(
                    fontweight: FontWeight.w600,
                    text: "públicas ou não.",
                    size: 20,
                    color: nightColor,
                  ),
                ),
                Padding(
                  padding: defaultPaddingVertical,
                  child: LoginContent(
                    title: false,
                  ),
                ),
                PostsLoading(),
              ],
            ),
          );
  }
}
