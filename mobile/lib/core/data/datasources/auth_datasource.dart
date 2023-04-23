import 'package:auto_park/core/services/firbase_auth_service.dart';

abstract class AuthDataSource {
  Future<Map<String, dynamic>> auth(String email, String password);
  Future<Map<String, dynamic>> create(String email, String password);
  Future<void> delete();
  Future<Stream<Map<String, dynamic>>> read();
}

class AuthDataSourceImp implements AuthDataSource {
  final FirebaseAuthService _firebaseAuthService;
  AuthDataSourceImp(this._firebaseAuthService);
  @override
  Future<Map<String, dynamic>> auth(String email, String password) async {
    return await _firebaseAuthService.auth(email, password);
  }

  @override
  Future<Map<String, dynamic>> create(String email, String password) async {
    return await _firebaseAuthService.create(email, password);
  }

  @override
  Future<void> delete() async {
    return await _firebaseAuthService.delete();
  }

  @override
  Future<Stream<Map<String, dynamic>>> read() async {
    return await _firebaseAuthService.read();
  }
}
