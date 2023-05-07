class VehicleEntity {
  final String id;
  final String marca;
  final String modelo;
  final String placa;
  VehicleEntity({
    required this.id,
    required this.marca,
    required this.modelo,
    required this.placa,
  });

  factory VehicleEntity.empty() {
    return VehicleEntity(marca: '', modelo: '', placa: '', id: '');
  }
}
