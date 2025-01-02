import 'package:cloud_firestore/cloud_firestore.dart';

class EventoEntity {
  final String categoriaId;
  final String id;
  final String nombre;
  final List<String> imagenes;
  final Timestamp fecha;
  final String descripcion;
  final String ubicacion;
  final num precio;

  EventoEntity({
    required this.categoriaId,
    required this.id,
    required this.nombre,
    required this.imagenes,
    required this.fecha,
    required this.descripcion,
    required this.ubicacion,
    required this.precio,
  });
}