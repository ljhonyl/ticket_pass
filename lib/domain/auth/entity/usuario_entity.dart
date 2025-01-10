import 'package:ticket_pass/data/auth/models/usuario_model.dart';

class UsuarioEntity {
  String ? nombre;
  String ? apellidos;
  String ? email;
  String ? password;

  UsuarioEntity({
    required this.nombre,
    required this.apellidos,
    required this.email,
    required this.password
  });
}

extension UsuarioXEntity on UsuarioEntity{
  UsuarioModel toModel(){
    return UsuarioModel(
        nombre: nombre,
        apellidos: apellidos,
        email: email,
        password: password
    );
  }
}

