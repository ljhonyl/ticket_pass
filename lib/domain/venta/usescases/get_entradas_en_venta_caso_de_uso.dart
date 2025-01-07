import 'package:dartz/dartz.dart';
import 'package:ticket_pass/data/venta/models/entrada_requerida_model.dart';
import 'package:ticket_pass/domain/caso_de_uso.dart';
import 'package:ticket_pass/domain/venta/repository/venta_repository.dart';

import '../../../service_locator.dart';

class GetEntradasEnVentaCasoDeUso
    implements CasoDeUso<Either, EntradaRequeridaModel> {
  @override
  Future<Either> call({EntradaRequeridaModel? params}) async {
    return await sl<VentaRepository>().getEntradasEnVenta(params!);
  }
}
