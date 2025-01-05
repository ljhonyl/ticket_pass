import '../../../domain/cuenta/entity/cuenta_entity.dart';

class CuentaModel {
  final String nombre;
  final String apellidos;
  final String email;
  final String imagen;

  CuentaModel({
    required this.nombre,
    required this.apellidos,
    required this.email,
    required this.imagen
  });

  factory CuentaModel.fromMap(Map<String, dynamic> map) {
    return CuentaModel(
      nombre: map['nombre'] as String,
      apellidos: map['apellidos'] as String,
      email: map['email'] as String,
      imagen: map['imagen'] as String
    );
  }
}

extension CuentaXModel on CuentaModel {
  CuentaEntity toEntity() {
    return CuentaEntity(
      nombre: nombre,
      apellidos: apellidos,
      email: email,
      imagen: imagen
    );
  }
}
