import 'package:ticket_pass/domain/auth/repository/inicio_sesion_repository.dart';
import 'package:ticket_pass/domain/caso_de_uso.dart';

import '../../../service_locator.dart';


class SesionEnCursoCasoDeUso implements CasoDeUso<bool,dynamic> {
  @override
  Future<bool> call({params}) async{
    return await sl<InicioSesionRepository>().sesionIniciada();
  }

}