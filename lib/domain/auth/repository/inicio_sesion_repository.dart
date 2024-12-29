import 'package:dartz/dartz.dart';
import 'package:ticket_pass/data/auth/models/usuario.dart';
import 'package:ticket_pass/data/auth/models/usuario_inicio_sesion.dart';

abstract class InicioSesionRepository {
  Future<Either> registrarse(Usuario usuario);
  Future<Either> iniciarSesion(UsuarioInicioSesion usuario);
  Future<Either> restablecerPassword(String email);
  Future<bool> sesionIniciada();
}