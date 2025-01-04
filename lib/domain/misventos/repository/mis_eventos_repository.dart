import 'package:dartz/dartz.dart';

abstract class MisEventosRepository{
  Future<Either> getEventosAsistidos();
}