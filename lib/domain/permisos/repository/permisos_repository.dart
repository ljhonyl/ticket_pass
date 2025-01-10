import 'package:dartz/dartz.dart';

abstract class PermisosRepository{
  Future<Either> pedirPermisos();
}