import 'package:dartz/dartz.dart';
import 'package:ticket_pass/domain/caso_de_uso.dart';
import 'package:ticket_pass/domain/compra/entity/peticion_compra_entity.dart';
import 'package:ticket_pass/domain/compra/repository/compra_repository.dart';

import '../../../service_locator.dart';


class CompraCasoDeUso implements CasoDeUso<Either, PeticionCompraEntity> {
  @override
  Future<Either> call({PeticionCompraEntity ? params}) async{
    return await sl<CompraRepository>().comprar(params!);
  }
}