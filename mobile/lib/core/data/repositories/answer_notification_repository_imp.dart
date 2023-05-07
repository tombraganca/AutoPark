import 'package:auto_park/core/data/datasources/answer_notification_datasource.dart';
import 'package:auto_park/core/domain/repositories/answer_notification.dart';
import 'package:auto_park/core/failures/failure.dart';
import 'package:either_dart/either.dart';

class AnswerNotificationRepositoryImp implements AnswerNotificationRepository {
  final AnswerNotificationDataSource _answerNotificationDataSource;
  AnswerNotificationRepositoryImp(this._answerNotificationDataSource);
  @override
  Future<Either<Failure, void>> answerNotification(
      String placa, bool answer) async {
    try {
      return Right(await _answerNotificationDataSource.answerNotification(
          placa, answer));
    } on Failure catch (e) {
      return Left(e);
    }
  }
}
