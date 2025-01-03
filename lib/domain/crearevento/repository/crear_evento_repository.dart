import 'package:dartz/dartz.dart';
import 'package:ticket_pass/domain/crearevento/entity/crear_evento_entity.dart';

abstract class CrearEventoRepository{
  Future<Either> crearEvento(CrearEventoEntity evento);
}