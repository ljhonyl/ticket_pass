import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../domain/misventos/entity/mi_evento_entity.dart';

class MiEventoModel{
  final String eventoId;
  final String nombreEvento;
  final Timestamp fechaEvento;
  final String imagen;

  MiEventoModel({
    required this.eventoId,
    required this.nombreEvento,
    required this.fechaEvento,
    required this.imagen
  });

  factory MiEventoModel.fromMap(Map<String, dynamic> map) {
    return MiEventoModel(
      eventoId: map['id'] as String,
      nombreEvento: map['nombreEvento'] as String,
      fechaEvento: map['fechaEvento'] as Timestamp,
      imagen: map['imagen'] as String,
    );
  }
}

extension MiEventosModelToEntity on MiEventoModel {
  MiEventoEntity toEntity() {
    return MiEventoEntity(
      eventoId: eventoId,
      nombreEvento: nombreEvento,
      fechaEvento: fechaEvento,
      imagen: imagen,
    );
  }
}