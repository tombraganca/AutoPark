import 'package:auto_park/core/domain/entities/registros_entity.dart';

class RegistroDto extends RegistroEntity {
  RegistroDto({
    required super.title,
    required super.registro,
    required super.date,
  });

  factory RegistroDto.fromJson(Map<String, dynamic> json) {
    return RegistroDto(
        title: json['title'], registro: json['registro'], date: json['date']);
  }

  Map<String, dynamic> toJson() {
    return {
      'title': super.title,
      'registro': super.registro,
      'date': super.date,
    };
  }
}
