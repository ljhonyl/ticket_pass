import 'package:dartz/dartz.dart';
import 'package:ticket_pass/data/miseventos/source/mis_eventos_firebase_service.dart';

import '../../../domain/misventos/entity/mi_evento_entity.dart';
import '../../../domain/misventos/repository/mis_eventos_repository.dart';
import '../../../service_locator.dart';
import '../models/mi_evento_model.dart';

class MisEventosRepositoryImpl extends MisEventosRepository {
  @override
  Future<Either> getEventosAsistidos() async {
    var eventos = await sl<MisEventosFirebaseService>().getEventosAsistidos();

    return eventos.fold((error) {
      return Left(error);
    }, (data) {
      List<MiEventoEntity> eventos = (data as List<MiEventoModel>)
          .map((eventoModel) => eventoModel.toEntity())
          .toList();

      return Right(eventos);
    });
  }
}
