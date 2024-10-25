import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalAuthService {
  final _storage = FlutterSecureStorage();

  Future<void> storeToken(String token) async {
    await _storage.write(key: "token", value: token);
  }

  Future<String?> getSecureToken(String token) async {
    return await _storage.read(key: "token");
  }

  Future storeAccount({
    required String email,
    required String lname,
    required String fname,
    required String fullname,
    required String cpf,
    required int id,
  }) async {
    await _storage.write(key: "id", value: id.toString());
    await _storage.write(key: "email", value: email);
    await _storage.write(key: "lname", value: lname);
    await _storage.write(key: "fname", value: fname);
    await _storage.write(key: "fullname", value: fullname);
    await _storage.write(key: "cpf", value: cpf.toString());
  }

  Future<String?> getEmail(String unicKey) async {
    return await _storage.read(key: "email");
  }

  Future<String?> getId(String unicKey) async {
    return await _storage.read(key: "id");
  }

  Future<String?> getLname(String unicKey) async {
    return await _storage.read(key: "lname");
  }

  Future<String?> getFname(String unicKey) async {
    return await _storage.read(key: "fname");
  }

  Future<String?> getFullName(String unicKey) async {
    return await _storage.read(key: "fullname");
  }

  Future<String?> getCpf(String unicKey) async {
    return await _storage.read(key: "cpf");
  }

  Future<void> clear() async {
    await _storage.deleteAll();
  }
}
