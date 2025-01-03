import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ticket_pass/data/crearevento/service/crear_evento_firebase_service.dart';
import 'package:ticket_pass/data/crearevento/service/img_bb_service.dart';
import 'package:ticket_pass/domain/crearevento/entity/crear_evento_entity.dart';

import '../../../domain/crearevento/repository/crear_evento_repository.dart';
import '../../../service_locator.dart';

class CrearEventoRepositoryImpl extends CrearEventoRepository{

  @override
  Future<Either> crearEvento(CrearEventoEntity evento) async {
    try {
      List<File> files = evento.imagenes.map((imagen) {
        if (imagen is XFile) {
          return File(imagen.path);
        } else if (imagen is File) {
          return imagen;
        } else {
          throw Exception('Tipo de imagen no soportado');
        }
      }).toList();

      // Paso 2: Subir las imágenes y obtener las URLs
      List<String> urls = await sl<ImgBBService>().subirImagenes(files);

      var eventoModel = evento.toModel(urls);

      return sl<CrearEventoFirebaseService>().crearEvento(eventoModel);
    } catch (e) {
      return Left('Error al crear evento: ${e.toString()}');
    }
  }

  List<File> convertirImagenes(List<XFile> imagenes) {
    return imagenes.map((imagen) => File(imagen.path)).toList();
  }
}