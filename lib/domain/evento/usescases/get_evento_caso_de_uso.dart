import 'package:dartz/dartz.dart';
import 'package:ticket_pass/domain/caso_de_uso.dart';
import 'package:ticket_pass/domain/evento/repository/evento_repository.dart';

import '../../../service_locator.dart';


class GetEventoCasoDeUso implements CasoDeUso<Either, dynamic> {
  @override
  Future<Either> call({dynamic params}) async{
    return await sl<EventoRepository>().getEntradas();
  }
}