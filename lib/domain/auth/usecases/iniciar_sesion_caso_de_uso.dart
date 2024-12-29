import 'package:dartz/dartz.dart';
import 'package:ticket_pass/data/auth/models/usuario_inicio_sesion.dart';
import 'package:ticket_pass/domain/auth/repository/inicio_sesion_repository.dart';
import 'package:ticket_pass/domain/auth/usecases/caso_de_uso.dart';

import '../../../service_locator.dart';


class IniciarSesionCasoDeUso implements CasoDeUso<Either, UsuarioInicioSesion> {
  @override
  Future<Either> call({UsuarioInicioSesion ? params}) async{
    return await sl<InicioSesionRepository>().iniciarSesion(params!);
  }
}