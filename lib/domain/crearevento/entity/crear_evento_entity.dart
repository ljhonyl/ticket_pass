import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ticket_pass/data/crearevento/models/crear_evento_model.dart';

class CrearEventoEntity {
  final String categoriaId;
  final String nombre;
  final List<dynamic> imagenes;
  final Timestamp fecha;
  final String descripcion;
  final String ubicacion;
  final num precio;
  final num totalEntradas;
  final num entradasVendidas;

  CrearEventoEntity({
    required this.categoriaId,
    required this.nombre,
    required this.imagenes,
    required this.fecha,
    required this.descripcion,
    required this.ubicacion,
    required this.precio,
    required this.totalEntradas,
    this.entradasVendidas = 0
  });
}

extension CrearEventoXEntity on CrearEventoEntity {
  CrearEventoModel toModel(List<String> listaUrls) {
    return CrearEventoModel(
        categoriaId: categoriaId,
        nombre: nombre,
        imagenes: listaUrls,
        fecha: fecha,
        descripcion: descripcion,
        ubicacion: ubicacion,
        precio: precio,
        totalEntradas: totalEntradas,
        entradasVendidas: entradasVendidas
    );
  }
}

