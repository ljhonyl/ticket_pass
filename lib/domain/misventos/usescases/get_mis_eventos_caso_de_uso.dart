import 'package:dartz/dartz.dart';
import 'package:ticket_pass/domain/caso_de_uso.dart';
import 'package:ticket_pass/domain/misventos/repository/mis_eventos_repository.dart';

import '../../../service_locator.dart';


class GetMisEventosCasoDeUso implements CasoDeUso<Either, dynamic> {
  @override
  Future<Either> call({dynamic params}) async{
    return await sl<MisEventosRepository>().getEventosAsistidos();
  }
}