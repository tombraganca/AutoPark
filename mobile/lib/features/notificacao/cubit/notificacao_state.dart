// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_park/core/data/dtos/notification_dto.dart';
import 'package:equatable/equatable.dart';

class NotificacaoState extends Equatable {
  NotificationDto? notificationDto = NotificationDto.empty();

  NotificacaoState({this.notificationDto});

  @override
  List<Object?> get props => [notificationDto];

  NotificacaoState copyWith({
    NotificationDto? notificationDto,
  }) {
    return NotificacaoState(
      notificationDto: notificationDto ?? this.notificationDto,
    );
  }
}
