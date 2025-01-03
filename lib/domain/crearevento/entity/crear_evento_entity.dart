import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ticket_pass/data/crearevento/models/crear_evento_model.dart';

class CrearEventoEntity {
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

  CrearEventoEntity({
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

extension CrearEventoXEntity on CrearEventoEntity {
  CrearEventoModel toModel() {
    return CrearEventoModel(
        categoriaId: categoriaId,
        id: id,
        nombre: nombre,
        imagenes: imagenes,
        fecha: fecha,
        descripcion: descripcion,
        ubicacion: ubicacion,
        precio: precio,
        totalEntradas: totalEntradas,
        entradasVendidas: entradasVendidas
    );
  }
}

