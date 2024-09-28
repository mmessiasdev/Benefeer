// import 'package:Bloguee/model/postnauth.dart';
// import 'package:flutter/material.dart';
// import 'package:Bloguee/component/colors.dart';
// import 'package:Bloguee/component/texts.dart';
// import 'package:Bloguee/component/thumbpost.dart';
// import 'package:Bloguee/service/local/auth.dart';
// import 'package:Bloguee/service/remote/auth.dart';
// import 'package:Bloguee/view/posts/post/screen.dart';

// class RenderPost extends StatefulWidget {
//   RenderPost({super.key, required this.query});

//   String query;

//   @override
//   State<RenderPost> createState() => _RenderPostState();
// }

// class _RenderPostState extends State<RenderPost> {
//   String? token;
//   String? chunkId;

//   @override
//   void initState() {
//     super.initState();
//     getString();
//   }

//   void getString() async {
//     var strToken = await LocalAuthService().getSecureToken("token");
//     var strChunkId = await LocalAuthService().getChunkId("chunkId");
//     setState(() {
//       token = strToken;
//       chunkId = strChunkId;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (token == null || chunkId == null) {
//       return Center(child: CircularProgressIndicator(backgroundColor: PrimaryColor,));
//     }

//     return FutureBuilder<List<PostsModel>>(
//         future: RemoteAuthService().getPostSearch(token: token!, query: widget.query, chunkId: chunkId!),
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             return ListView.builder(
//                 itemCount: snapshot.data!.length,
//                 itemBuilder: (context, index) {
//                   var render = snapshot.data![index];
//                   return Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 25),
//                     child: GestureDetector(
//                       child: ThumbPost(
//                           title: render.title.toString(),
//                           desc: render.desc.toString(),
//                           data: render.updatedAt.toString().replaceAll("-", "/").substring(0, 10)),
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => PostScreen(
//                               id: render.id.toString(),
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   );
//                 });
//           } else if (snapshot.hasError) {
//             print(snapshot.hasError);
//             return Center(
//                 child: SubText(
//               text: 'Erro ao pesquisar post',
//               color: PrimaryColor,
//               align: TextAlign.center,
//             ));
//           }
//           return Expanded(
//             child: Center(
//               child: CircularProgressIndicator(
//                 color: PrimaryColor,
//               ),
//             ),
//           );
//         });
//   }
// }


// class SearchPosts extends SearchDelegate<String> {
//   @override
//   String get searchFieldLabel => 'Qual sua dúvida?';

//   @override
//   List<Widget>? buildActions(BuildContext context) {
//     // TODO: implement buildActions
//     return [
//       IconButton(
//           onPressed: () {
//             query = "";
//           },
//           icon: Icon(Icons.clear))
//     ];
//   }

//   @override
//   Widget? buildLeading(BuildContext context) {
//     // TODO: implement buildLeading
//     return IconButton(
//         onPressed: () {
//           close(context, "");
//         },
//         icon: Icon(Icons.arrow_back_ios));
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     if (query.isEmpty) {
//       return Container();
//     }
//     return RenderPost(
//       query: query,
//     );
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     if (query.isEmpty) {
//       return Container();
//     }
//     return RenderPost(
//       query: query,
//     );
//   }
// }
