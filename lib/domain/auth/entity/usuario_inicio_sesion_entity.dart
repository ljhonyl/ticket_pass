import 'package:ticket_pass/data/auth/models/usuario_inicio_sesion_model.dart';

class UsuarioInicioSesionEntity {
  String ? email;
  String ? password;

  UsuarioInicioSesionEntity({
    required this.email,
    required this.password
  });
}

extension UsuarioInicioSesionXEntity on UsuarioInicioSesionEntity{
  UsuarioInicioSesionModel toModel(){
    return UsuarioInicioSesionModel(
        email: email,
        password: password
    );
  }
}