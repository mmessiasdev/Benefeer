import 'dart:convert';
import 'package:Benefeer/model/categories.dart';
import 'package:Benefeer/model/plans.dart';
import 'package:Benefeer/model/postsnauth.dart';
import 'package:Benefeer/model/profiles.dart';
import 'package:Benefeer/model/stores.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:Benefeer/model/postFiles.dart';
import 'package:http/http.dart' as http;

// const url = String.fromEnvironment('BASEURL', defaultValue: '');

class RemoteAuthService {
  var client = http.Client();
  final storage = FlutterSecureStorage();
  final url = dotenv.env["BASEURL"];

  Future<dynamic> signUp(
      {required String email,
      required String password,
      required String username}) async {
    var body = {"username": username, "email": email, "password": password};
    var response = await client.post(
      Uri.parse('$url/auth/local/register'),
      headers: {
        "Content-Type": "application/json",
        "ngrok-skip-browser-warning": "true"
      },
      body: jsonEncode(body),
    );
    return response;
  }

  Future<dynamic> signIn({
    required String email,
    required String password,
  }) async {
    var body = {"identifier": email, "password": password};
    var response = await client.post(
      Uri.parse('$url/auth/local'),
      headers: {
        "Content-Type": "application/json",
        'ngrok-skip-browser-warning': "true"
      },
      body: jsonEncode(body),
    );
    return response;
  }

  Future<dynamic> createProfile({
    required String fname,
    required String lname,
    required String token,
  }) async {
    var body = {
      "fname": fname,
      "lname": lname,
    };
    var response = await client.post(
      Uri.parse('$url/profile/me'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
        'ngrok-skip-browser-warning': "true"
      },
      body: jsonEncode(body),
    );
    return response;
  }

  Future<http.Response> getProfile({
    required String token,
  }) async {
    // Faz a chamada GET e retorna o objeto Response diretamente
    return await client.get(
      Uri.parse('$url/profiles/me'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
        'ngrok-skip-browser-warning': "true",
      },
    );
  }

  Future addPost(
      {required String? title,
      required String? desc,
      required String? content,
      required int? profileId,
      required String? token,
      required bool? public}) async {
    final body = {
      "title": title.toString(),
      "desc": desc.toString(),
      "content": content.toString(),
      "profile": profileId.toString(),
      "public": public,
    };
    var response = await client.post(
      Uri.parse('$url/posts'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
        'ngrok-skip-browser-warning': "true"
      },
      body: jsonEncode(body),
    );
    return response;
  }

  Future<List<StoresModel>> getStores({
    required String? token,
  }) async {
    List<StoresModel> listItens = [];
    var response = await client.get(
      Uri.parse('$url/online-stores'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
        'ngrok-skip-browser-warning': "true"
      },
    );
    var body = jsonDecode(response.body);
    var itemCount = body;
    for (var i = 0; i < itemCount.length; i++) {
      listItens.add(StoresModel.fromJson(itemCount[i]));
    }
    return listItens;
  }

  Future<List<CategoryModel>> getCategories({
    required String? token,
  }) async {
    List<CategoryModel> listItens = [];
    var response = await client.get(
      Uri.parse('$url/categories'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );
    var body = jsonDecode(response.body);
    var itemCount = body;
    for (var i = 0; i < itemCount.length; i++) {
      listItens.add(CategoryModel.fromJson(itemCount[i]));
    }
    return listItens;
  }

  Future<Map> getStore({
    required String id,
    required String? token,
  }) async {
    var response = await client.get(
      Uri.parse('$url/online-stores/$id'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
        'ngrok-skip-browser-warning': "true"
      },
    );
    var itens = json.decode(response.body);
    return itens;
  }

  Future<Map> getOneCategory({
    required String id,
    required String? token,
  }) async {
    var response = await client.get(
      Uri.parse('$url/categories/$id'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
        'ngrok-skip-browser-warning': "true"
      },
    );
    var itens = json.decode(response.body);
    return itens;
  }

  Future<List<OnlineStores>> getOneCategoryStories({
    required String? token,
    required String? id,
  }) async {
    List<OnlineStores> listItens = [];
    var response = await client.get(
      Uri.parse('$url/categories/$id'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
        'ngrok-skip-browser-warning': "true"
      },
    );
    var body = jsonDecode(response.body);
    var itemCount = body['online_stores'];
    for (var i = 0; i < itemCount.length; i++) {
      listItens.add(OnlineStores.fromJson(itemCount[i]));
    }
    return listItens;
  }

  Future<List<Plans>> getPlans({
    required String? token,
  }) async {
    List<Plans> listItens = [];
    var response = await client.get(
      Uri.parse('$url/plans'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );
    var body = jsonDecode(response.body);
    var itemCount = body;
    for (var i = 0; i < itemCount.length; i++) {
      listItens.add(Plans.fromJson(itemCount[i]));
    }
    return listItens;
  }

  Future<List<LocalStores>> getOnePlansLocalStores({
    required String? token,
    required String? id,
  }) async {
    List<LocalStores> listItens = [];
    var response = await client.get(
      Uri.parse('$url/plans/$id'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );
    var body = jsonDecode(response.body);
    var itemCount = body["local_stores"];
    for (var i = 0; i < itemCount.length; i++) {
      listItens.add(LocalStores.fromJson(itemCount[i]));
    }
    return listItens;
  }

  Future<Map> getLocalStore({
    required String id,
    required String? token,
  }) async {
    var response = await client.get(
      Uri.parse('$url/local-stores/$id'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
        'ngrok-skip-browser-warning': "true"
      },
    );
    var itens = json.decode(response.body);
    return itens;
  }

  Future<List<PostFiles>> getPostsFiles(
      {required String? token, required String? id}) async {
    List<PostFiles> listItens = [];
    var response = await client.get(
      Uri.parse('$url/posts/${id}'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
        'ngrok-skip-browser-warning': "true"
      },
    );
    var body = jsonDecode(response.body);
    var itemCount = body["files"];
    for (var i = 0; i < itemCount.length; i++) {
      listItens.add(PostFiles.fromJson(itemCount[i]));
    }
    return listItens;
  }

  Future<Map> getQrCodeLocalStore({
    required String id,
    required String? token,
  }) async {
    var response = await client.get(
      Uri.parse('$url/local-stores/$id/qrcode'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
        'ngrok-skip-browser-warning': "true"
      },
    );
    var itens = json.decode(response.body);
    return itens;
  }

  Future<List<StoresModel>> getOnlineStoresSearch({
    required String token,
    required String query,
  }) async {
    List<StoresModel> listItens = [];
    var response = await client.get(
      Uri.parse("$url/online-stores?name_contains=$query"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
        'ngrok-skip-browser-warning': "true"
      },
    );
    var body = jsonDecode(response.body);
    var itemCount = body;
    for (var i = 0; i < itemCount.length; i++) {
      listItens.add(StoresModel.fromJson(itemCount[i]));
    }
    return listItens;
  }

  //$url/posts?title_contains=$query&chunk.id_eq=$chunkId

  Future<List<Profile>> getProfiles({required String? token}) async {
    List<Profile> listItens = [];
    var response = await client.get(
      Uri.parse('$url/profiles'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
        'ngrok-skip-browser-warning': "true"
      },
    );
    var body = jsonDecode(response.body);
    var itemCount = body;
    for (var i = 0; i < itemCount.length; i++) {
      listItens.add(Profile.fromJson(itemCount[i]));
    }
    return listItens;
  }

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
