import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';

class CrearEventoModel {
  final String categoriaId;
  final String nombre;
  final List<String> imagenes;
  final Timestamp fecha;
  final String descripcion;
  final String ubicacion;
  final num precio;
  final num totalEntradas;
  final num entradasVendidas;

  CrearEventoModel({
    required this.categoriaId,
    required this.nombre,
    required this.imagenes,
    required this.fecha,
    required this.descripcion,
    required this.ubicacion,
    required this.precio,
    required this.totalEntradas,
    required this.entradasVendidas
  });

  Map<String, dynamic> toMap() {
    return {
      'categoriaId': categoriaId,
      'nombre': nombre,
      'imagenes': imagenes,
      'fecha': fecha,
      'descripcion': descripcion,
      'ubicacion': ubicacion,
      'precio': precio,
      'totalEntradas': totalEntradas,
      'entradasVendidas': entradasVendidas,
    };
  }
}
