import 'package:dartz/dartz.dart';
import 'package:ticket_pass/domain/caso_de_uso.dart';
import 'package:ticket_pass/domain/cerrarsesion/repository/cerrar_sesion_repository.dart';
import '../../../service_locator.dart';


class CerrarSesionCasoDeUso implements CasoDeUso<Either, dynamic> {
  @override
  Future<Either> call({dynamic params}) async{
    return await sl<CerrarSesionRepository>().cerrarSesion();
  }
}