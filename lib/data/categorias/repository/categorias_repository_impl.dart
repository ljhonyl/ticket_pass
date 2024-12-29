import 'package:dartz/dartz.dart';
import 'package:ticket_pass/data/categorias/models/categoria_model.dart';
import 'package:ticket_pass/data/categorias/source/categorias_firebase_service.dart';

import '../../../domain/categorias/repository/categorias_repository.dart';
import '../../../service_locator.dart';

class CategoriasRepositoryImpl extends CategoriasRepository{
  @override
  Future<Either> getCategorias() async{
    var categorias = await sl<CategoriasFirebaseService>().getCategorias();

    return categorias.fold(
    (error){
      return Left(error);
    },
    (data){
      return Right(
        CategoriaModel.fromMap(data)
      );
    }
    );
  }

}