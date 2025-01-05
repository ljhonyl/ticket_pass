import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticket_pass/domain/cuenta/usescases/set_imagen_caso_de_uso.dart';

import '../../../service_locator.dart';

class ImagenCubit extends Cubit<String>{
  ImagenCubit({required String imagen}) : super(imagen);

  Future<Either> setImagen(dynamic nuevaImagen) async{
    try{
      var respuesta = await sl<SetImagenCasoDeUso>().call(params: nuevaImagen);

      return respuesta.fold(
        (error) {
          return Left(error);
        },
        (data) {
          emit(data);
          return Right("Imagen actualizada correctamente");
        },
      );
    }
    catch(e){
      emit(state);
      return Left("Ocurrio un error durante el proceso");
    }
  }
}