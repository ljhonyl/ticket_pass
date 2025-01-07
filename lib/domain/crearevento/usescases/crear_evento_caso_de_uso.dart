import 'package:dartz/dartz.dart';
import 'package:ticket_pass/domain/caso_de_uso.dart';
import 'package:ticket_pass/domain/crearevento/entity/crear_evento_entity.dart';
import 'package:ticket_pass/domain/crearevento/repository/crear_evento_repository.dart';

import '../../../service_locator.dart';

class CrearEventoCasoDeUso implements CasoDeUso<Either, CrearEventoEntity> {
  @override
  Future<Either> call({CrearEventoEntity? params}) async {
    return await sl<CrearEventoRepository>().crearEvento(params!);
  }
}
