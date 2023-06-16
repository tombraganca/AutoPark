import 'dart:convert';
import 'dart:developer';

import 'package:auto_park/core/domain/entities/registros_entity.dart';
import 'package:intl/intl.dart';

class RegistroDto extends RegistroEntity {
  RegistroDto({
    required super.title,
    required super.date,
    required super.id,
  });

  factory RegistroDto.fromJson(Map<String, dynamic> json) {
    return RegistroDto(
        id: json['id'] ?? '',
        title: json['type'].toString().toLowerCase().contains('out')
            ? 'Saída'
            : 'Entrada',
        date: DateFormat('yyyy-MM-dd hh:mm:ss')
            .format(DateTime.parse(json['date'].toString())));
  }
  Map<String, dynamic> toJson() {
    return {
      'title': super.title,
      'date': super.date,
      'id': super.id,
    };
  }
}
