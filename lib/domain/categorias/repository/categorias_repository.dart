import 'package:dartz/dartz.dart';

abstract class CategoriasRepository{
  Future<Either> getCategorias();
}