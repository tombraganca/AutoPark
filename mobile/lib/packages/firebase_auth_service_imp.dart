import 'package:auto_park/core/failures/auth/auth_failure.dart';
import 'package:auto_park/core/services/firbase_auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthServiceImp implements FirebaseAuthService {
  final FirebaseAuth _firebaseAuth;
  FirebaseAuthServiceImp(this._firebaseAuth);
  @override
  Future<Map<String, dynamic>> auth(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return {
        'email': userCredential.user!.email ?? '',
        'uid': userCredential.user!.uid,
        'phoneNumber': userCredential.user!.phoneNumber ?? '',
      };
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-exists':
          throw AuthFailureLoginExists();
        case 'invalid-password':
          throw AuthFailurePasswordInvalid();
      }
    }
    throw '';
  }

  @override
  Future<Map<String, dynamic>> create(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return {
        'email': userCredential.user!.email ?? '',
        'uid': userCredential.user!.uid,
        'phoneNumber': userCredential.user!.phoneNumber ?? '',
      };
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-exists':
          throw AuthFailureLoginExists();
        case 'invalid-password':
          throw AuthFailurePasswordInvalid();
      }
    }
    throw '';
  }

  @override
  Future<void> delete() async {
    try {
      if (_firebaseAuth.currentUser != null) {
        await _firebaseAuth.currentUser!.delete();
      } else {
        throw AuthFailureDelete();
      }
    } on FirebaseAuthException catch (e) {}
  }

  @override
  Future<Stream<Map<String, dynamic>>> read() {
    // TODO: implement read
    throw UnimplementedError();
  }
}
