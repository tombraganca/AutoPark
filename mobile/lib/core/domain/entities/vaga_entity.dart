import 'package:flutter/material.dart';

class VagaEntity {
  final String name;
  final String description;
  final String situacao;
  final TipoVaga tipoVaga;
  final int id;
  VagaEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.situacao,
    required this.tipoVaga,
  });

  IconData getIconTipoVaga(TipoVaga tipoVaga) {
    Map<TipoVaga, IconData> map = {
      TipoVaga.idoso: Icons.elderly_rounded,
      TipoVaga.pcd: Icons.accessible_outlined,
      TipoVaga.commun: Icons.local_parking,
    };
    return map[tipoVaga]!;
  }
}

enum TipoVaga {
  pcd,
  idoso,
  commun,
}
