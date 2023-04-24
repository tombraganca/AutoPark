import 'package:auto_park/core/domain/entities/user_entity.dart';

abstract class FirebaseAuthService {
  Future<UserEntity> auth(String email, String password);
  Future<bool> create(String email, String password);
  Future<bool> delete();
}
