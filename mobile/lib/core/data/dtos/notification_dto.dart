import 'package:auto_park/core/domain/entities/notificatio_entity.dart';
import 'package:auto_park/core/domain/entities/vehicle_entity.dart';

class NotificationDto extends NotificationEntity {
  NotificationDto(
      {required super.id,
      required super.title,
      required super.body,
      required super.vehicleEntity,
      required super.datahora,
      required super.tipoDeAcesso});

  factory NotificationDto.empty() {
    return NotificationDto(
        title: '',
        body: '',
        vehicleEntity: VehicleEntity.empty(),
        datahora: '',
        tipoDeAcesso: '',
        id: '');
  }

  factory NotificationDto.fromJson(Map<String, dynamic> json) {
    return NotificationDto(
        title: json['notification']['title'],
        body: json['notification']['body'],
        vehicleEntity: VehicleEntity(
          id: '',
          marca: json['data']['manufacturer'],
          modelo: json['data']['modelo'],
          placa: json['data']['plate'],
        ),
        datahora: json['data']['orderDate'],
        tipoDeAcesso: json['data']['accessType'],
        id: json['data']['osderId']);
  }
}