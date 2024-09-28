// import 'dart:convert';
// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:Bloguee/component/buttomborder.dart';
// import 'package:Bloguee/component/buttomdefault.dart';
// import 'package:Bloguee/component/colors.dart';
// import 'package:Bloguee/component/header.dart';
// import 'package:Bloguee/component/inputdefault.dart';
// import 'package:Bloguee/component/texts.dart';
// import 'package:Bloguee/controller/controllers.dart';
// import 'package:Bloguee/service/local/auth.dart';
// import 'package:http/http.dart' as http;
// // import 'dart:html' as html;

// class CreatePost extends StatefulWidget {
//   const CreatePost({super.key});

//   @override
//   State<CreatePost> createState() => _CreatePostState();
// }

// class _CreatePostState extends State<CreatePost> {
//   var client = http.Client();

//   var token;
//   var id;
//   var chunk;

//   @override
//   void initState() {
//     super.initState();
//     getString();
//   }

//   void getString() async {
//     var strId = await LocalAuthService().getId("id");
//     var strChunk = await LocalAuthService().getId("chunk");
//     var strToken = await LocalAuthService().getSecureToken("token");

//     setState(() {
//       id = strId;
//       chunk = strChunk;
//       token = strToken.toString();
//     });
//   }

//   TextEditingController content = TextEditingController();
//   TextEditingController title = TextEditingController();
//   TextEditingController desc = TextEditingController();

//   @override
//   void dispose() {
//     content.dispose();
//     title.dispose();
//     desc.dispose();
//     super.dispose();
//   }

//   bool fixed = false;

//   List<int>? selectFile;
//   Uint8List? _bytesData;

//   String? selectedFileName;

//   // startPicker() async {
//   //   html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
//   //   uploadInput.multiple = true;
//   //   uploadInput.draggable = true;
//   //   uploadInput.click();

//   //   uploadInput.onChange.listen((event) {
//   //     final files = uploadInput.files;
//   //     final file = files![0];
//   //     final reader = html.FileReader();

//   //     setState(() {
//   //       selectedFileName = file.name;
//   //     });

//   //     reader.onLoadEnd.listen((event) {
//   //       setState(() {
//   //         _bytesData =
//   //             Base64Decoder().convert(reader.result.toString().split(",").last);
//   //         selectFile = _bytesData;
//   //       });
//   //     });
//   //     reader.readAsDataUrl(file);
//   //   });
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       children: [
//         MainHeader(title: 'Voltar', onClick: () => Navigator.pop(context)),
//         Padding(
//           padding: const EdgeInsets.only(left: 30, right: 30, top: 25),
//           child: SizedBox(
//             child: Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 20),
//                   child: SizedBox(
//                     width: double.infinity,
//                     child: PrimaryText(
//                       text: 'Crie seu Post',
//                       color: nightColor,
//                       align: TextAlign.start,
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(top: 20),
//                   child: InputTextField(
//                     title: 'Titulo',
//                     textEditingController: title,
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(top: 20),
//                   child: InputTextField(
//                     title: 'Descrição',
//                     textEditingController: desc,
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(top: 20),
//                   child: InputTextField(
//                     minLines: 1,
//                     maxLines: 15,
//                     title: 'Conteúdo',
//                     textEditingController: content,
//                   ),
//                 ),
//                 // Padding(
//                 //     padding: const EdgeInsets.only(top: 50),
//                 //     child: SizedBox(
//                 //       width: double.infinity,
//                 //       child: InputOutlineButton(
//                 //         title: 'Add PDF',
//                 //         onClick: () {
//                 //           startPicker();
//                 //         },
//                 //       ),
//                 //     )),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 _bytesData == null
//                     ? SizedBox()
//                     : Column(
//                         children: [
//                           SubText(
//                             text: 'Documento Adicionado',
//                             color: FourtyColor,
//                             align: TextAlign.center,
//                           ),
//                           SizedBox(
//                             height: 5,
//                           ),
//                           SubText(
//                             text: selectedFileName ??
//                                 'Nome do arquivo indisponível',
//                             color: PrimaryColor,
//                             align: TextAlign.center,
//                           ),
//                         ],
//                       ),
//                 Padding(
//                   padding: const EdgeInsets.only(top: 50),
//                   child: SizedBox(
//                     width: double.infinity,
//                     child: Align(
//                       child: CheckboxListTile(
//                         title: SecundaryText(
//                             text: 'Fixar Post?',
//                             color: nightColor,
//                             align: TextAlign.start),
//                         value: fixed,
//                         onChanged: (value) {
//                           setState(() {
//                             value == false ? fixed = false : fixed = true;
//                           });
//                         },
//                         controlAffinity: ListTileControlAffinity.trailing,
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 50,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(top: 30, bottom: 20),
//                   child: InputTextButton(
//                       title: "Enviar",
//                       color: FourtyColor,
//                       onClick: () {
//                         setState(() {
//                           authController.posting(
//                             fileName: selectedFileName,
//                             // selectFile: selectFile!,
//                             title: title.text,
//                             desc: desc.text,
//                             content: content.text,
//                             profileId: int.parse(id),
//                           );
//                         });
//                       }),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
