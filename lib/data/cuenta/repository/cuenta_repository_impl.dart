import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ticket_pass/common/service/img_bb_service.dart';
import 'package:ticket_pass/data/cuenta/models/cuenta_model.dart';
import 'package:ticket_pass/data/cuenta/service/cuenta_firebase_service.dart';
import '../../../domain/cuenta/repository/cuenta_repository.dart';
import '../../../service_locator.dart';

class CuentaRepositoryImpl extends CuentaRepository{
  @override
  Future<Either> getCuenta() async {
    var cuenta = await sl<CuentaFirebaseService>().getCuenta();

    return cuenta.fold(
      (error){
        return Left(error);
      },
      (data){
        if(data is CuentaModel){
          var datos = data.toEntity();
          return Right(datos);
        }
        return Left("Erro al tratar la cuenta");
      }
    );
  }

  @override
  Future<Either> setImagen(dynamic imagen) async {
    try {
      File imagenFile;
      if (imagen is XFile) {
        imagenFile = File(imagen.path);
      } else if (imagen is File) {
        imagenFile = imagen;
      } else {
        return Left('Tipo de imagen no soportado');
      }
      String imagenUrl = await sl<ImgBBService>().subirImagen(imagenFile);

      var respuesta= await sl<CuentaFirebaseService>().setImagen(imagenUrl);

      return respuesta.fold(
        (error) => Left(error),
        (data) => Right(imagenUrl),
      );
    }
    catch(e) {
      return Left('Error al subir la imagen');
    }
  }
}