abstract class FirebaseAuthService {
  Future<Map<String, dynamic>> auth(String email, String password);
  Future<Map<String, dynamic>> create(String email, String password);
  Future<Stream<Map<String, dynamic>>> read();
  Future<void> delete();
}
