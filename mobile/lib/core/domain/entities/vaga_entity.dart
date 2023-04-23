import 'package:flutter/material.dart';

class VagaEntity {
  final String name;
  final String description;
  final List<String> reportes;
  final bool isAvailable;
  final TipoVaga tipoVaga;
  VagaEntity({
    required this.name,
    required this.reportes,
    required this.description,
    required this.isAvailable,
    required this.tipoVaga,
  });

  IconData getIconTipoVaga(TipoVaga tipoVaga) {
    Map<TipoVaga, IconData> map = {
      TipoVaga.idoso: Icons.elderly_rounded,
      TipoVaga.pcd: Icons.accessible_outlined,
      TipoVaga.comun: Icons.local_parking,
    };
    return map[tipoVaga]!;
  }
}

enum TipoVaga {
  pcd,
  idoso,
  comun,
}
