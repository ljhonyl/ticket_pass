import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../domain/evento/entity/evento_entity.dart';

class EventoModel {
  final String categoriaId;
  final String id;
  final String nombre;
  final List<String> imagenes;
  final Timestamp fecha;
  final String descripcion;
  final String ubicacion;
  final num precio;
  final String nombreNormalizado;

  EventoModel({
    required this.categoriaId,
    required this.id,
    required this.nombre,
    required this.imagenes,
    required this.fecha,
    required this.descripcion,
    required this.ubicacion,
    required this.precio,
    required this.nombreNormalizado
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'categoriaId': categoriaId,
      'id': id,
      'nombre': nombre,
      'imagenes': imagenes,
      'fecha': fecha,
      'descripcion': descripcion,
      'ubicacion': ubicacion,
      'precio': precio,
    };
  }

  factory EventoModel.fromMap(Map<String, dynamic> map) {
    return EventoModel(
      categoriaId: map['categoriaId'] as String,
      id: map['id'] as String,
      nombre: map['nombre'] as String,
      imagenes: List<String>.from(map['imagenes'].map((item) => item.toString())),
      fecha: map['fecha'] as Timestamp,
      descripcion: map['descripcion'] as String,
      ubicacion: map['ubicacion'] as String,
      precio: map['precio'] as num,
      nombreNormalizado: map['nombreNormalizado'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory EventoModel.fromJson(String source) =>
      EventoModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

extension EntradasXModel on EventoModel {
  EventoEntity toEntity() {
    return EventoEntity(
      categoriaId: categoriaId,
      id: id,
      nombre: nombre,
      imagenes: imagenes,
      fecha: fecha,
      descripcion: descripcion,
      ubicacion: ubicacion,
      precio: precio,
    );
  }
}

