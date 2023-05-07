import 'package:auto_park/core/failures/failure.dart';

class FcmFailure extends Failure {
  FcmFailure(super.msg, [super.stackTrace]);
}

class FcmFailureInvalidToken extends FcmFailure {
  FcmFailureInvalidToken() : super('Token do dispositivo inválido');
}
