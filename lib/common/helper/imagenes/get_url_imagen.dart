import 'package:ticket_pass/core/url/app_url.dart';

class GetUrlImagen{
  static String getImagenEntradaUrl(String imagen){
    return AppUrl.carpetaImagenes+ imagen +AppUrl.alt;
  }
  static String getImagenUsuarioUrl(){
    return AppUrl.imagenUsuario;
  }
}