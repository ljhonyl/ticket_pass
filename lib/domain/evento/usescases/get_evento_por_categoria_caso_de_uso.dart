import 'package:dartz/dartz.dart';
import 'package:ticket_pass/domain/caso_de_uso.dart';
import 'package:ticket_pass/domain/evento/repository/evento_repository.dart';

import '../../../service_locator.dart';


class GetEventoPorCategoriaCasoDeUso implements CasoDeUso<Either, String> {
  @override
  Future<Either> call({String? params}) async{
    return await sl<EventoRepository>().getEntradasPorCategoria(params!);
  }
}