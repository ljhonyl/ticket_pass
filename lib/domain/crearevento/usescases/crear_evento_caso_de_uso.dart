import 'package:dartz/dartz.dart';
import 'package:ticket_pass/data/compra/models/peticion_compra_model.dart';
import 'package:ticket_pass/domain/caso_de_uso.dart';
import 'package:ticket_pass/domain/compra/entity/peticion_compra_entity.dart';
import 'package:ticket_pass/domain/compra/repository/compra_repository.dart';
import 'package:ticket_pass/domain/crearevento/entity/crear_evento_entity.dart';
import 'package:ticket_pass/domain/crearevento/repository/crear_evento_repository.dart';

import '../../../service_locator.dart';


class CrearEventoCasoDeUso implements CasoDeUso<Either, CrearEventoEntity> {
  @override
  Future<Either> call({CrearEventoEntity ? params}) async{
    print("ESTAMOS EN LA IMPLEMENTACION DEL REPOSITORIO");
    return await sl<CrearEventoRepository>().crearEvento(params!);
  }
}