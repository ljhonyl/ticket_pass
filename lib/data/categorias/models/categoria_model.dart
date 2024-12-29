import 'dart:convert';

import '../../../domain/categorias/entity/categoria_entity.dart';

class CategoriaModel {
  final String id;
  final String nombre;

  CategoriaModel({
    required this.id,
    required this.nombre
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nombre': nombre,
    };
  }

  factory CategoriaModel.fromMap(Map<String, dynamic> map) {
    return CategoriaModel(
      id: map['id'] as String,
      nombre: map['nombre'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoriaModel.fromJson(String source) => CategoriaModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

extension CategoryXModel on CategoriaModel {
  CategoriaEntity toEntity() {
    return CategoriaEntity(
        id: id,
        nombre: nombre,
    );
  }
}