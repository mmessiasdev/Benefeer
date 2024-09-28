import 'package:Benefeer/component/buttomborder.dart';
import 'package:Benefeer/component/padding.dart';
import 'package:Benefeer/model/postFiles.dart';
import 'package:Benefeer/service/local/auth.dart';
import 'package:Benefeer/service/remote/auth.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:Benefeer/component/colors.dart';
import 'package:Benefeer/component/widgets/header.dart';
import 'package:Benefeer/component/texts.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'dart:typed_data';
// import 'dart:html' as html;
import 'package:universal_platform/universal_platform.dart';

class PostScreen extends StatefulWidget {
  PostScreen({super.key, required this.id});
  String id;

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  var client = http.Client();
  var email;
  var lname;
  var token;
  var id;
  var chunkId;
  var fileBytes;
  var fileName;

  @override
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

  Future<Uint8List> convertURL(String url) async {
    try {
      // Baixar o conteúdo do arquivo PDF da URL
      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        // Converter a resposta para Uint8List
        Uint8List fileBytes = Uint8List.fromList(response.bodyBytes);
        return fileBytes;
      } else {
        print(
            'Erro ao baixar o arquivo. Código de status: ${response.statusCode}');
        return Uint8List(0); // Retornar uma lista vazia em caso de erro
      }
    } catch (e) {
      print('Erro: $e');
      return Uint8List(0); // Retornar uma lista vazia em caso de erro
    }
  }

  // Future<void> downloadPDFMobile() async {
  //   try {
  //     Uint8List bytesConverted = await convertURL(fileBytes);

  //     // Salvar o arquivo temporariamente
  //     final tempDir = await getTemporaryDirectory();
  //     final tempPath = '${tempDir.path}/${fileName}';
  //     File tempFile = File(tempPath);
  //     await tempFile.writeAsBytes(bytesConverted);

  //     // Abrir o PDF no navegador
  //     await launch(tempPath);
  //   } catch (e) {
  //     print('Erro: $e');
  //     // Lide com o erro conforme necessário
  //   }
  // }

  // Future<void> downloadPDFWeb() async {
  //   final response = await http.get(Uri.parse(fileBytes));

  //   if (response.statusCode == 200) {
  //     final Uint8List bytes = response.bodyBytes;

  //     final blob = html.Blob([bytes]);
  //     final url = html.Url.createObjectUrlFromBlob(blob);
  //     final anchor = html.AnchorElement(href: url)
  //       ..target = 'webbrowser'
  //       ..download = '${fileName}';

  //     html.document.body!.children.add(anchor);
  //     anchor.click();
  //     html.document.body!.children.remove(anchor);
  //     html.Url.revokeObjectUrl(url);

  //     print("PDF baixado com sucesso.");
  //   } else {
  //     throw Exception("Falha ao baixar o PDF: ${response.statusCode}");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return chunkId == "null"
        ? SizedBox()
        : ListView(
            children: [
              MainHeader(
                  title: "Voltar", onClick: () => Navigator.pop(context)),
              // FutureBuilder<Map>(
              //     future: RemoteAuthService()
              //         .getPost(id: widget.id),
              //     builder: (context, snapshot) {
              //       if (snapshot.hasData) {
              //         var render = snapshot.data!;
              //         return SizedBox(
              //           child: Column(
              //             children: [
              //               Padding(
              //                 padding: defaultPadding,
              //                 child: Column(
              //                   children: [
              //                     SizedBox(
              //                       width: double.infinity,
              //                       child: PrimaryText(
              //                         text: render["title"],
              //                         color: nightColor,
              //                         align: TextAlign.start,
              //                       ),
              //                     ),
              //                     SizedBox(
              //                       height: 25,
              //                     ),
              //                     SizedBox(
              //                       width:
              //                           MediaQuery.of(context).size.width * 1,
              //                       child: SubText(
              //                         text: "Por ${render["profile"]["fname"]}",
              //                         color: nightColor,
              //                         align: TextAlign.end,
              //                       ),
              //                     ),
              //                     SizedBox(
              //                       height: 50,
              //                     ),
              //                     SubText(
              //                         text: render["content"],
              //                         color: SecudaryColor,
              //                         align: TextAlign.justify),
              //                     SizedBox(
              //                       height: 100,
              //                     ),
              //                   ],
              //                 ),
              //               ),
              //               render["content"] == ""
              //                   ? SizedBox()
              //                   : Container(
              //                       width: double.infinity,
              //                       color: SixthColor,
              //                       child: Padding(
              //                           padding: const EdgeInsets.only(
              //                               left: 30,
              //                               right: 30,
              //                               top: 50,
              //                               bottom: 50),
              //                           child: SubText(
              //                             text: render["content"],
              //                             align: TextAlign.start,
              //                             color: nightColor,
              //                           )),
              //                     ),
              //               // Padding(
              //               //   padding: defaultPadding,
              //               //   child: FutureBuilder<List<PostFiles>>(
              //               //       future: RemoteAuthService().getPostsFiles(
              //               //           token: token, id: widget.id),
              //               //       builder: (context, snapshot) {
              //               //         if (snapshot.hasData) {
              //               //           return Column(
              //               //             children: [
              //               //               ListView.builder(
              //               //                   shrinkWrap: true,
              //               //                   itemCount: snapshot.data!.length,
              //               //                   itemBuilder: (context, index) {
              //               //                     var renderFile =
              //               //                         snapshot.data![index];
              //               //                     fileBytes = renderFile.url;
              //               //                     fileName = renderFile.name;
              //               //                     return Column(
              //               //                       children: [
              //               //                         Padding(
              //               //                             padding:
              //               //                                 const EdgeInsets
              //               //                                     .all(15),
              //               //                             child:
              //               //                                 SfPdfViewer.network(
              //               //                               renderFile.url
              //               //                                   .toString(),
              //               //                             )),
              //               //                         UniversalPlatform.isWeb
              //               //                             ? Padding(
              //               //                                 padding:
              //               //                                     const EdgeInsets
              //               //                                         .only(
              //               //                                         top: 50),
              //               //                                 child: SizedBox(
              //               //                                   width: double
              //               //                                       .infinity,
              //               //                                   child:
              //               //                                       InputOutlineButton(
              //               //                                     title:
              //               //                                         'Baixar Documento \n ${renderFile.name}',
              //               //                                     onClick: () {
              //               //                                       downloadPDFWeb();
              //               //                                     },
              //               //                                   ),
              //               //                                 ))
              //               //                             : SizedBox()
              //               //                       ],
              //               //                     );
              //               //                   }),
              //               //             ],
              //               //           );
              //               //         } else if (snapshot.hasError) {
              //               //           return SizedBox();
              //               //         }
              //               //         return SizedBox();
              //               //       }),
              //               // ),
              //             ],
              //           ),
              //         );
              //       } else if (snapshot.hasError) {
              //         return Expanded(
              //           child: Center(
              //               child: SubText(
              //             text: 'Erro ao pesquisar post',
              //             color: PrimaryColor,
              //             align: TextAlign.center,
              //           )),
              //         );
              //       }
              //       return SizedBox(
              //         height: 200,
              //         child: Center(
              //           child: CircularProgressIndicator(
              //             color: PrimaryColor,
              //           ),
              //         ),
              //       );
              //     }),
            ],
          );
  }
}
