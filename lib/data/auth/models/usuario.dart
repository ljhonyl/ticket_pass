class Usuario {
  String ? nombre;
  String ? apellidos;
  String ? email;
  String ? password;
  int ? edad;
  List<String> ? tipoEntradasPreferidas;

  Usuario({
    required this.nombre,
    required this.apellidos,
    required this.email,
    required this.password
  });
}