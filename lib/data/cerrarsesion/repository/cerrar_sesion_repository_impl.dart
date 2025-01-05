import 'package:dartz/dartz.dart';
import 'package:ticket_pass/data/cerrarsesion/service/cerrar_sesion_firebase_service.dart';
import 'package:ticket_pass/domain/cerrarsesion/repository/cerrar_sesion_repository.dart';

import '../../../service_locator.dart';

class CerrarSesionRepositoryImpl extends CerrarSesionRepository{
  @override
  Future<Either> cerrarSesion() async {
    return await sl<CerrarSesionFirebaseService>().cerrarSesion();
  }

}