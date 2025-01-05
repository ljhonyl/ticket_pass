import 'package:dartz/dartz.dart';

abstract class CuentaRepository{
  Future<Either> getCuenta();
  Future<Either> setImagen(dynamic imagen);
}