import 'package:dartz/dartz.dart';
import 'package:ticket_pass/data/auth/models/usuario.dart';
import 'package:ticket_pass/data/auth/models/usuario_inicio_sesion.dart';
import 'package:ticket_pass/data/auth/source/inicio_sesion_firebase_service.dart';
import 'package:ticket_pass/domain/auth/repository/inicio_sesion_repository.dart';

import '../../../service_locator.dart';

class InicioSesionRepositoryImpl extends InicioSesionRepository {
  @override
  Future<Either> registrarse(Usuario usuario) async {
    return await sl<InicioSesionFirebaseService>().registrarse(usuario);
  }

  @override
  Future<Either> iniciarSesion(UsuarioInicioSesion usuario) async {
    return await sl<InicioSesionFirebaseService>().iniciarSesion(usuario);
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