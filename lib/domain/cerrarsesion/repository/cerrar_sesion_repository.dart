import 'package:dartz/dartz.dart';

abstract class CerrarSesionRepository{
  Future<Either> cerrarSesion();
}