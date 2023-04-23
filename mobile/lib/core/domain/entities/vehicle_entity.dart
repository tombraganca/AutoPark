// ignore_for_file: public_member_api_docs, sort_constructors_first
class VehicleEntity {
  final String name;
  final String marca;
  final String modelo;
  final String placa;
  VehicleEntity({
    required this.name,
    required this.marca,
    required this.modelo,
    required this.placa,
  });

  factory VehicleEntity.empty() {
    return VehicleEntity(name: '', marca: '', modelo: '', placa: '');
  }
}
