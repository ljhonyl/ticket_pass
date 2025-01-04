import 'package:cloud_firestore/cloud_firestore.dart';

class MiEventoEntity{
  final String eventoId;
  final String nombreEvento;
  final Timestamp fechaEvento;
  final String imagen;

  MiEventoEntity({
    required this.eventoId,
    required this.nombreEvento,
    required this.fechaEvento,
    required this.imagen
  });
}