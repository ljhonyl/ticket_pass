import 'package:dartz/dartz.dart';
import 'package:ticket_pass/domain/auth/entity/usuario_entity.dart';
import 'package:ticket_pass/domain/auth/entity/usuario_inicio_sesion_entity.dart';

abstract class InicioSesionRepository {
  Future<Either> registrarse(UsuarioEntity usuario);
  Future<Either> iniciarSesion(UsuarioInicioSesionEntity usuario);
  Future<Either> restablecerPassword(String email);
  Future<bool> sesionIniciada();
}
