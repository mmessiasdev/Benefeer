import 'dart:convert';
import 'package:Benefeer/model/postsnauth.dart';
import 'package:Benefeer/model/profiles.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:Benefeer/model/postFiles.dart';
import 'package:http/http.dart' as http;

// const url = String.fromEnvironment('BASEURL', defaultValue: '');

class RemoteAuthService {
  // var client = http.Client();
  // final storage = FlutterSecureStorage();
  // final url = dotenv.env["BASEURL"];

  // Future<dynamic> signUp(
  //     {required String email,
  //     required String password,
  //     required String username}) async {
  //   var body = {"username": username, "email": email, "password": password};
  //   var response = await client.post(
  //     Uri.parse('$url/auth/local/register'),
  //     headers: {
  //       "Content-Type": "application/json",
  //       "ngrok-skip-browser-warning": "true"
  //     },
  //     body: jsonEncode(body),
  //   );
  //   return response;
  // }

  // Future<dynamic> signIn({
  //   required String email,
  //   required String password,
  // }) async {
  //   var body = {"identifier": email, "password": password};
  //   var response = await client.post(
  //     Uri.parse('$url/auth/local'),
  //     headers: {
  //       "Content-Type": "application/json",
  //       'ngrok-skip-browser-warning': "true"
  //     },
  //     body: jsonEncode(body),
  //   );
  //   print('Resposta HTML: ${response.body}');
  //   return response;
  // }

  // Future<dynamic> createProfile({
  //   required String fname,
  //   required String lname,
  //   required String token,
  // }) async {
  //   var body = {
  //     "fname": fname,
  //     "lname": lname,
  //   };
  //   var response = await client.post(
  //     Uri.parse('$url/profile/me'),
  //     headers: {
  //       "Content-Type": "application/json",
  //       "Authorization": "Bearer $token",
  //       'ngrok-skip-browser-warning': "true"
  //     },
  //     body: jsonEncode(body),
  //   );
  //   return response;
  // }

  // Future<dynamic> getProfile({
  //   required String token,
  // }) async {
  //   var response = await client.get(
  //     Uri.parse('$url/profiles/me'),
  //     headers: {
  //       "Content-Type": "application/json",
  //       "Authorization": "Bearer $token",
  //       'ngrok-skip-browser-warning': "true"
  //     },
  //   );
  //   return response;
  // }

  // Future addPost(
  //     {required String? title,
  //     required String? desc,
  //     required String? content,
  //     required int? profileId,
  //     required String? token,
  //     required bool? public}) async {
  //   final body = {
  //     "title": title.toString(),
  //     "desc": desc.toString(),
  //     "content": content.toString(),
  //     "profile": profileId.toString(),
  //     "public": public,
  //   };
  //   var response = await client.post(
  //     Uri.parse('$url/posts'),
  //     headers: {
  //       "Content-Type": "application/json",
  //       "Authorization": "Bearer $token",
  //       'ngrok-skip-browser-warning': "true"
  //     },
  //     body: jsonEncode(body),
  //   );
  //   return response;
  // }

  // Future<List<PostsNoAuth>> getPostsNoAuth() async {
  //   List<PostsNoAuth> listItens = [];
  //   var response = await client.get(
  //     Uri.parse('$url/posts?public_eq=true&_sort=id:DESC'),
  //   );
  //   var body = jsonDecode(response.body);
  //   var itemCount = body;
  //   for (var i = 0; i < itemCount.length; i++) {
  //     listItens.add(PostsNoAuth.fromJson(itemCount[i]));
  //   }
  //   return listItens;
  // }

  // Future<Map> getPost({
  //   required String id,
  // }) async {
  //   var response = await client.get(
  //     Uri.parse('$url/posts/$id'),
  //     headers: {
  //       "Content-Type": "application/json",
  //       'ngrok-skip-browser-warning': "true"
  //     },
  //   );
  //   var itens = json.decode(response.body);
  //   return itens;
  // }

  // Future<List<PostFiles>> getPostsFiles(
  //     {required String? token, required String? id}) async {
  //   List<PostFiles> listItens = [];
  //   var response = await client.get(
  //     Uri.parse('$url/posts/${id}'),
  //     headers: {
  //       "Content-Type": "application/json",
  //       "Authorization": "Bearer $token",
  //       'ngrok-skip-browser-warning': "true"
  //     },
  //   );
  //   var body = jsonDecode(response.body);
  //   var itemCount = body["files"];
  //   for (var i = 0; i < itemCount.length; i++) {
  //     listItens.add(PostFiles.fromJson(itemCount[i]));
  //   }
  //   return listItens;
  // }

  // // Future<List<PostsModel>> getPostSearch(
  // //     {required String token,
  // //     required String query,
  // //     required String chunkId}) async {
  // //   List<PostsModel> listItens = [];
  // //   var response = await client.get(
  // //     Uri.parse("$url/posts?title_contains=$query&chunk.id_eq=$chunkId"),
  // //     headers: {
  // //       "Content-Type": "application/json",
  // //       "Authorization": "Bearer $token",
  // //       'ngrok-skip-browser-warning': "true"
  // //     },
  // //   );
  // //   var body = jsonDecode(response.body);
  // //   var itemCount = body;
  // //   for (var i = 0; i < itemCount.length; i++) {
  // //     listItens.add(PostsModel.fromJson(itemCount[i]));
  // //   }
  // //   return listItens;
  // // }

  // Future<List<Profile>> getProfiles({required String? token}) async {
  //   List<Profile> listItens = [];
  //   var response = await client.get(
  //     Uri.parse('$url/profiles'),
  //     headers: {
  //       "Content-Type": "application/json",
  //       "Authorization": "Bearer $token",
  //       'ngrok-skip-browser-warning': "true"
  //     },
  //   );
  //   var body = jsonDecode(response.body);
  //   var itemCount = body;
  //   for (var i = 0; i < itemCount.length; i++) {
  //     listItens.add(Profile.fromJson(itemCount[i]));
  //   }
  //   return listItens;
  // }

  // Future<List<Posts>> getMyPosts(
  //     {required String? token, required String? profileId}) async {
  //   List<Posts> listItens = [];
  //   var response = await client.get(
  //     Uri.parse('$url/profile/$profileId'),
  //     headers: {
  //       "Content-Type": "application/json",
  //       "Authorization": "Bearer $token",
  //       'ngrok-skip-browser-warning': "true"
  //     },
  //   );
  //   var body = jsonDecode(response.body);
  //   var itemCount = body["posts"];
  //   print(body);
  //   for (var i = 0; i < itemCount.length; i++) {
  //     listItens.add(Posts.fromJson(itemCount[i]));
  //   }
  //   return listItens;
  // }
}
