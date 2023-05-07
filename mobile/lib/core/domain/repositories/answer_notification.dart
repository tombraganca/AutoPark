import 'package:auto_park/core/failures/failure.dart';
import 'package:either_dart/either.dart';

abstract class AnswerNotificationRepository {
  Future<Either<Failure, void>> answerNotification(String placa, bool answer);
}
