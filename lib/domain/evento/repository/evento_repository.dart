import 'package:dartz/dartz.dart';

abstract class EventoRepository{
  Future<Either> getProximamente();
  Future<Either> getEntradas();
  Future<Either> getEntradasPorCategoria(String categoria);
  Future<Either> getEntradaPorNombre(String nombre);
}