import 'package:auto_park/core/domain/entities/registros_entity.dart';

class RegistroDto extends RegistroEntity {
  RegistroDto({
    required super.title,
    required super.registro,
    required super.date,
    required super.id,
  });

  factory RegistroDto.fromJson(Map<String, dynamic> json) {
    return RegistroDto(
        id: json['id'],
        title: json['title'],
        registro: json['registro'],
        date: json['date']);
  }

  Map<String, dynamic> toJson() {
    return {
      'title': super.title,
      'registro': super.registro,
      'date': super.date,
      'id': super.id,
    };
  }
}
