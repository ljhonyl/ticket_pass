import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ticket_pass/domain/crearevento/entity/crear_evento_entity.dart';

class CrearEventoModel {
  final String categoriaId;
  final String id;
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
    required this.id,
    required this.nombre,
    required this.imagenes,
    required this.fecha,
    required this.descripcion,
    required this.ubicacion,
    required this.precio,
    required this.totalEntradas,
    required this.entradasVendidas
  });
}
