import 'package:auto_park/core/failures/failure.dart';

class AuthFailure extends Failure {
  AuthFailure(super.msg, [super.stackTrace]);
}

class AuthFailureLoginExists extends AuthFailure {
  AuthFailureLoginExists() : super('Login já existente');
}

class AuthFailurePasswordInvalid extends AuthFailure {
  AuthFailurePasswordInvalid() : super('E-mail ou Senha Inválidos.');
}

class AuthFailureDelete extends AuthFailure {
  AuthFailureDelete() : super('Falha ao realizar a deleção.');
}
