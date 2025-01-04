import 'package:dartz/dartz.dart';
import 'package:ticket_pass/data/misentradas/models/mi_compra_model.dart';
import 'package:ticket_pass/data/misentradas/service/mis_entradas_firebase_service.dart';
import 'package:ticket_pass/domain/misentradas/entity/mi_compra_entity.dart';
import 'package:ticket_pass/domain/misentradas/repository/mis_entradas_repository.dart';

import '../../../service_locator.dart';

class MisEntradasRepositoryImpl extends MisEntradasRepository{
  @override
  Future<Either> getEntradas(String eventoId) async {
    var compras = await sl<MisEntradasFirebaseService>().getEntradas(eventoId);

    return compras.fold(
            (error){
          print("REPOSITORIO MIS ENTRADAS");
          return Left(error);
        },
            (data){
          List<MiCompraEntity> datos = (data as List<MiCompraModel>)
              .map((compra) => compra.toEntity())
              .toList();

          return Right(datos);
        }
    );
  }
}