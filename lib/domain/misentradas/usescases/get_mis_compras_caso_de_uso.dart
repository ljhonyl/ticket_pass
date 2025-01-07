import 'package:dartz/dartz.dart';
import 'package:ticket_pass/domain/caso_de_uso.dart';

import '../../../service_locator.dart';
import '../repository/mis_entradas_repository.dart';

class GetMisComprasCasoDeUso implements CasoDeUso<Either, String> {
  @override
  Future<Either> call({String? params}) async {
    return await sl<MisEntradasRepository>().getEntradas(params!);
  }
}
