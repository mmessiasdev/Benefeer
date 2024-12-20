import 'dart:convert';
import 'package:Benefeer/model/balancelocalstores.dart';
import 'package:Benefeer/model/carrouselbanner.dart';
import 'package:Benefeer/model/categories.dart';
import 'package:Benefeer/model/localstoriesverifiquedbuy.dart';
import 'package:Benefeer/model/plans.dart';
import 'package:Benefeer/model/localstores.dart';

import 'package:Benefeer/model/postsnauth.dart';
import 'package:Benefeer/model/profiles.dart';
import 'package:Benefeer/model/stores.dart';
import 'package:Benefeer/model/verfiquedexitbalances.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:Benefeer/model/postFiles.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
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
      Uri.parse('${url.toString()}/auth/local/register'),
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
      Uri.parse('${url.toString()}/auth/local'),
      headers: {
        "Content-Type": "application/json",
        "ngrok-skip-browser-warning": "true"
      },
      body: jsonEncode(body),
    );
    return response;
  }

  Future<dynamic> createProfile({
    required String fullname,
    required String token,
  }) async {
    var body = {
      "fullname": fullname,
    };
    var response = await client.post(
      Uri.parse('${url.toString()}/profile/me'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
        "ngrok-skip-browser-warning": "true"
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
      Uri.parse('${url.toString()}/profiles/me'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
        "ngrok-skip-browser-warning": "true"
      },
    );
  }

  Future<List<Banners>> getCarrouselBanners({
    required String? token,
    required String? id,
  }) async {
    List<Banners> listItens = [];
    var response = await client.get(
      Uri.parse('${url.toString()}/carrousels/$id'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
        "ngrok-skip-browser-warning": "true"
      },
    );
    var body = jsonDecode(response.body);
    var itemCount = body['banners'];
    print(itemCount);
    for (var i = 0; i < itemCount.length; i++) {
      listItens.add(Banners.fromJson(itemCount[i]));
    }
    return listItens;
  }

  Future addVerificationLocalStore({
    required int? profile,
    required int? local_store,
    required String? token,
  }) async {
    final body = {
      "profile": profile.toString(),
      "local_store": local_store.toString(),
    };
    var response = await client.post(
      Uri.parse('${url.toString()}/verifiqued-buy-local-stores'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
        "ngrok-skip-browser-warning": "true"
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
      Uri.parse('${url.toString()}/online-stores'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
        "ngrok-skip-browser-warning": "true"
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
      Uri.parse('${url.toString()}/categories'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
        "ngrok-skip-browser-warning": "true"
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
      Uri.parse('${url.toString()}/online-stores/$id'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
        "ngrok-skip-browser-warning": "true"
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
      Uri.parse('${url.toString()}/categories/$id'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
        "ngrok-skip-browser-warning": "true"
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
      Uri.parse('${url.toString()}/categories/$id'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
        "ngrok-skip-browser-warning": "true"
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
      Uri.parse('${url.toString()}/plans'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
        "ngrok-skip-browser-warning": "true"
      },
    );
    var body = jsonDecode(response.body);
    var itemCount = body;
    for (var i = 0; i < itemCount.length; i++) {
      listItens.add(Plans.fromJson(itemCount[i]));
    }
    return listItens;
  }

  Future<Map> getOnePlan({
    required String id,
    required String? token,
  }) async {
    var response = await client.get(
      Uri.parse('${url.toString()}/plans/$id'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
        "ngrok-skip-browser-warning": "true"
      },
    );
    var itens = json.decode(response.body);
    return itens;
  }

  Future addProfilePlan({
    required int? idProfile,
    required String? idPlan,
    required String? token,
  }) async {
    if (idProfile == null || idPlan == null || token == null) {
      throw Exception('Um ou mais parâmetros estão faltando!');
    }

    final body = {
      "profiles": [idProfile]
    };

    var response = await client.put(
      Uri.parse('${url.toString()}/plans/$idPlan'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
        "ngrok-skip-browser-warning": "true"
      },
      body: jsonEncode(body),
    );

    // Verifique a resposta
    if (response.statusCode == 200 || response.statusCode == 201) {
      print('Requisição bem-sucedida');
      print('Resposta: ${response.body}');
    } else {
      print('Falha na requisição: ${response.statusCode}');
      print('Erro: ${response.body}');
    }

    return response;
  }

  Future<List<LocalStores>> getOnePlansLocalStores({
    required String? token,
    required String? id,
  }) async {
    List<LocalStores> listItens = [];
    var response = await client.get(
      Uri.parse('${url.toString()}/plans/$id'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
        "ngrok-skip-browser-warning": "true"
      },
    );
    var body = jsonDecode(response.body);
    var itemCount = body["local_stores"];
    for (var i = 0; i < itemCount.length; i++) {
      listItens.add(LocalStores.fromJson(itemCount[i]));
    }
    return listItens;
  }

  Future<List<LocalStores>> getLocalStores({
    required String? token,
  }) async {
    List<LocalStores> listItens = [];
    var response = await client.get(
      Uri.parse('${url.toString()}/local-stores'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
        "ngrok-skip-browser-warning": "true"
      },
    );
    var body = jsonDecode(response.body);
    var itemCount = body;
    for (var i = 0; i < itemCount.length; i++) {
      listItens.add(LocalStores.fromJson(itemCount[i]));
    }
    return listItens;
  }

  Future<List<PlanStores>> getPlanStores(
      {required String? token, required String? id}) async {
    List<PlanStores> listItens = [];
    var response = await client.get(
      Uri.parse('${url.toString()}/plans/$id'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
        "ngrok-skip-browser-warning": "true"
      },
    );
    var body = jsonDecode(response.body);
    var itemCount = body["plan_stores"];
    for (var i = 0; i < itemCount.length; i++) {
      listItens.add(PlanStores.fromJson(itemCount[i]));
    }
    return listItens;
  }

  Future<Map> getLocalStore({
    required String id,
    required String? token,
  }) async {
    var response = await client.get(
      Uri.parse('${url.toString()}/local-stores/$id'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
        "ngrok-skip-browser-warning": "true"
      },
    );
    var itens = json.decode(response.body);
    return itens;
  }

  Future<Map> getQrCodeLocalStore({
    required String id,
    required String? token,
  }) async {
    var response = await client.get(
      Uri.parse('${url.toString()}/local-stores/$id/qrcode'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
        "ngrok-skip-browser-warning": "true"
      },
    );
    var itens = json.decode(response.body);
    return itens;
  }

  Future<List<Receipt>> getVerifiquedLocalStoriesFiles(
      {required String? token, required String? id}) async {
    List<Receipt> listItens = [];
    var response = await client.get(
      Uri.parse('${url.toString()}/verifiqued-buy-local-stores/${id}'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
        "ngrok-skip-browser-warning": "true"
      },
    );
    var body = jsonDecode(response.body);
    var itemCount = body["receipt"];
    for (var i = 0; i < itemCount.length; i++) {
      listItens.add(Receipt.fromJson(itemCount[i]));
    }
    return listItens;
  }

  Future<List<BalanceLocalStores>> getBalanceLocalStores(
      {required String? token, required String? profileId}) async {
    List<BalanceLocalStores> listItens = [];

    var response = await client.get(
      Uri.parse(
          '${url.toString()}/verifiqued-buy-local-stores?profile.id_eq=${profileId}&approved=true'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
        "ngrok-skip-browser-warning": "true"
      },
    );
    var body = jsonDecode(response.body);
    var itemCount = body;
    for (var i = 0; i < itemCount.length; i++) {
      listItens.add(BalanceLocalStores.fromJson(itemCount[i]));
    }
    return listItens;
  }

  Future<List<VerfiquedExitBalances>> getExitBalances(
      {required String? token, required String? profileId}) async {
    List<VerfiquedExitBalances> listItens = [];
    var response = await client.get(
      Uri.parse(
          '${url.toString()}/verfiqued-exit-balances?profile.id_eq=${profileId}&approved=true'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
        "ngrok-skip-browser-warning": "true"
      },
    );
    var body = jsonDecode(response.body);
    var itemCount = body;
    print(body);
    for (var i = 0; i < itemCount.length; i++) {
      listItens.add(VerfiquedExitBalances.fromJson(itemCount[i]));
    }
    return listItens;
  }

  Future postExitBalances(
      {required String? token,
      required String? profileId,
      required String? valueExit}) async {
    final body = {
      "value": valueExit.toString(),
      "profile": [profileId]
    };
    var response = await client.post(
      Uri.parse('${url.toString()}/verfiqued-exit-balances'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
        "ngrok-skip-browser-warning": "true"
      },
      body: jsonEncode(body),
    );
    print("Sua respostaaaaaaaaaaaaaaaaaa ${response.body}");
    if (response.statusCode == 200) {
      EasyLoading.showSuccess("Saldo enviado para conta de destino!");
      Navigator.of(Get.overlayContext!).pushReplacementNamed('/');
    } else {
      EasyLoading.showSuccess("Algo deu errado. Tente novamente!");
    }
    return response;
  }

  Future<List<StoresModel>> getOnlineStoresSearch({
    required String token,
    required String query,
  }) async {
    List<StoresModel> listItens = [];
    var response = await client.get(
      Uri.parse("${url.toString()}/online-stores?name_contains=$query"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
        "ngrok-skip-browser-warning": "true"
      },
    );
    var body = jsonDecode(response.body);
    var itemCount = body;
    for (var i = 0; i < itemCount.length; i++) {
      listItens.add(StoresModel.fromJson(itemCount[i]));
    }
    return listItens;
  }

  Future<List<Profile>> getProfiles({required String? token}) async {
    List<Profile> listItens = [];
    var response = await client.get(
      Uri.parse('${url.toString()}/profiles'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
        "ngrok-skip-browser-warning": "true"
      },
    );
    var body = jsonDecode(response.body);
    var itemCount = body;
    for (var i = 0; i < itemCount.length; i++) {
      listItens.add(Profile.fromJson(itemCount[i]));
    }
    return listItens;
  }
}
