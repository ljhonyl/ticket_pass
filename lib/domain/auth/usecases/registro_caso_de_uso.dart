import 'package:dartz/dartz.dart';
import 'package:ticket_pass/data/auth/models/usuario.dart';
import 'package:ticket_pass/domain/auth/repository/inicio_sesion_repository.dart';
import 'package:ticket_pass/domain/caso_de_uso.dart';

import '../../../service_locator.dart';


class RegistroCasoDeUso implements CasoDeUso<Either, Usuario> {
  @override
  Future<Either> call({Usuario ? params}) async{
    return await sl<InicioSesionRepository>().registrarse(params!);
  }

}