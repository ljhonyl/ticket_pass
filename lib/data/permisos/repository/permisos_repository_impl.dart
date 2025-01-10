import 'package:dartz/dartz.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:ticket_pass/domain/permisos/repository/permisos_repository.dart';

class PermisosRepositoryImpl extends PermisosRepository {
  @override
  Future<Either<String, String>> pedirPermisos() async {
    var status = await Permission.storage.status;

    if (status.isDenied || status.isRestricted) {
      var result = await Permission.storage.request();

      if (result.isGranted) {
        return Right('Permiso concedido');
      } else if (result.isPermanentlyDenied) {
        return Left('Permiso denegado. Abre la configuración para cambiarlo.');
      } else {
        return Left('Permiso no concedidos');
      }
    } else if (status.isGranted) {
      return Right('El permiso ya fue concedido');
    } else {
      return Left('Consulta los permisos necesarios en tus ajustes');
    }
  }
}