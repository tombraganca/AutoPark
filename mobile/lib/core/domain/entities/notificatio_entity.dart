// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_park/core/domain/entities/vehicle_entity.dart';

class NotificationEntity {
  final String id;
  final String title;
  final String body;
  final VehicleEntity vehicleEntity;
  final String datahora;
  final String tipoDeAcesso;
  NotificationEntity({
    required this.id,
    required this.title,
    required this.body,
    required this.vehicleEntity,
    required this.datahora,
    required this.tipoDeAcesso,
  });
}
