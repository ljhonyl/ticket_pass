import 'package:dartz/dartz.dart';

abstract class MisEntradasRepository{
  Future<Either> getEntradas(String eventoId);
}