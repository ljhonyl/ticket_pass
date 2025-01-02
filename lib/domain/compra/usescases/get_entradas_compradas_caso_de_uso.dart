import 'package:dartz/dartz.dart';
import 'package:ticket_pass/domain/caso_de_uso.dart';
import 'package:ticket_pass/domain/compra/repository/compra_repository.dart';

import '../../../service_locator.dart';


class GetEntradasCompradasCasoDeUso implements CasoDeUso<Either, String> {
  @override
  Future<Either> call({String ? params}) async{
    print("CASO DE USO LLAMADO");
    return await sl<CompraRepository>().getEntradasCompradas(params!);
  }
}