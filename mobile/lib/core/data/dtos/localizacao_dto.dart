import 'package:auto_park/core/domain/entities/localizacao_entity.dart';

class LocalizacaoDto extends LocalizacaoEntity {
  LocalizacaoDto({
    required super.latitude,
    required super.longiture,
  });

  static LocalizacaoDto fromJson(Map<String, dynamic> json) {
    return LocalizacaoDto(
      latitude: json['lat'].toString(),
      longiture: json['long'].toString(),
    );
  }
}
