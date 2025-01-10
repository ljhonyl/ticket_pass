import 'package:dartz/dartz.dart';
import 'package:ticket_pass/data/auth/source/inicio_sesion_firebase_service.dart';
import 'package:ticket_pass/domain/auth/entity/usuario_entity.dart';
import 'package:ticket_pass/domain/auth/entity/usuario_inicio_sesion_entity.dart';
import 'package:ticket_pass/domain/auth/repository/inicio_sesion_repository.dart';

import '../../../service_locator.dart';

class InicioSesionRepositoryImpl extends InicioSesionRepository {
  @override
  Future<Either> registrarse(UsuarioEntity usuario) async {
    return await sl<InicioSesionFirebaseService>().registrarse(usuario.toModel());
  }

  @override
  Future<Either> iniciarSesion(UsuarioInicioSesionEntity usuario) async {
    return await sl<InicioSesionFirebaseService>().iniciarSesion(usuario.toModel());
  }

  @override
  Future<Either> restablecerPassword(String email) async {
    return await sl<InicioSesionFirebaseService>().restablecerPassword(email);
  }

  @override
  Future<bool> sesionIniciada() async {
    return await sl<InicioSesionFirebaseService>().sesionIniciada();
  }
}

