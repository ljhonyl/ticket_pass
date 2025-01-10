import 'package:dartz/dartz.dart';
import 'package:ticket_pass/domain/auth/entity/usuario_inicio_sesion_entity.dart';
import 'package:ticket_pass/domain/auth/repository/inicio_sesion_repository.dart';
import 'package:ticket_pass/domain/caso_de_uso.dart';

import '../../../service_locator.dart';


class IniciarSesionCasoDeUso implements CasoDeUso<Either, UsuarioInicioSesionEntity> {
  @override
  Future<Either> call({UsuarioInicioSesionEntity ? params}) async{
    return await sl<InicioSesionRepository>().iniciarSesion(params!);
  }
}