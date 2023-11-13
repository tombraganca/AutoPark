import 'package:auto_park/core/domain/repositories/answer_notification.dart';
import 'package:auto_park/core/failures/failure.dart';
import 'package:either_dart/either.dart';

abstract class AnswerNotificationUseCase {
  Future<Either<Failure, bool>> answerNotification({
    required String placa,
    required bool answer,
    required String parkingId,
  });
}

class AnswerNotificationUseCaseImp implements AnswerNotificationUseCase {
  final AnswerNotificationRepository _answerNotificationRepository;
  AnswerNotificationUseCaseImp(this._answerNotificationRepository);

  @override
  Future<Either<Failure, bool>> answerNotification(
      {required String placa,
      required bool answer,
      required String parkingId}) async {
    return await _answerNotificationRepository.answerNotification(
        placa, answer, parkingId);
  }
}
