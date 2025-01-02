import 'package:dartz/dartz.dart';
import 'package:ticket_pass/data/evento/models/evento_model.dart';
import 'package:ticket_pass/data/evento/source/evento_firebase_service.dart';
import 'package:ticket_pass/domain/evento/repository/evento_repository.dart';

import '../../../service_locator.dart';

class EventoRepositoryImpl extends EventoRepository{
  @override
  Future<Either> getProximamente() async {
    var proximamente = await sl<EventoFirebaseService>().getProximamente();

    return proximamente.fold(
        (error){
          return Left(error);
        },
        (data){
          return Right(
            List.from(data).map((item) => EventoModel.fromMap(item).toEntity()).toList()
          );
        }
    );
  }

  @override
  Future<Either> getEntradas() async {
    var entradas = await sl<EventoFirebaseService>().getEntradas();

    return entradas.fold(
            (error){
          return Left(error);
        },
            (data){
          return Right(
              List.from(data).map((item) => EventoModel.fromMap(item).toEntity()).toList()
          );
        }
    );
  }

  @override
  Future<Either> getEntradasPorCategoria(String categoria) async{
    var entradas = await sl<EventoFirebaseService>().getEntradasPorCategoria(categoria);

    return entradas.fold(
            (error){
          return Left(error);
        },
            (data){
          return Right(
              List.from(data).map((item) => EventoModel.fromMap(item).toEntity()).toList()
          );
        }
    );
  }

  @override
  Future<Either> getEntradaPorNombre(String nombre) async{
    var entradas = await sl<EventoFirebaseService>().getEntradaPorNombre(nombre);

    return entradas.fold(
            (error){
          return Left(error);
        },
            (data){
          return Right(
              List.from(data).map((item) => EventoModel.fromMap(item).toEntity()).toList()
          );
        }
    );
  }

}