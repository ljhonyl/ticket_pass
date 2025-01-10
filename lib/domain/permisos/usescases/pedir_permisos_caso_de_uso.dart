import 'package:dartz/dartz.dart';
import 'package:ticket_pass/domain/caso_de_uso.dart';
import 'package:ticket_pass/domain/permisos/repository/permisos_repository.dart';

import '../../../service_locator.dart';


class PedirPermisosCasoDeUso implements CasoDeUso<Either, dynamic> {
  @override
  Future<Either> call({dynamic params}) async{
    return await sl<PermisosRepository>().pedirPermisos();
  }
}