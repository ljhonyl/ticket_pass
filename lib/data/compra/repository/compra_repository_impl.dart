import 'package:dartz/dartz.dart';
import 'package:ticket_pass/data/compra/source/compra_firebase_service.dart';
import 'package:ticket_pass/domain/compra/entity/peticion_compra_entity.dart';
import '../../../domain/compra/entity/compra_entity.dart';
import '../../../domain/compra/repository/compra_repository.dart';
import '../../../service_locator.dart';
import '../models/compra_model.dart';
import '../models/entrada_comprada_model.dart';

class CompraRepositoryImpl extends CompraRepository{
  @override
  Future<Either> comprar(PeticionCompraEntity compra) async{
    return await sl<CompraFirebaseService>().comprar(compra.toModel());
  }

  @override
  Future<Either> getEntradasCompradas(String eventoId) async {
    print("REPOSITORIO");
    var entradasCompradas = await sl<CompraFirebaseService>().getEntradasCompradas(eventoId);

    return entradasCompradas.fold(
        (error){
          print("REPOSITORIO ERROR");
          return Left(error);
        },
        (data){
          var datos = (data as List<CompraModel>).map((compraModel) {
            return compraModel.toEntity(); // Convierte CompraModel a CompraEntity
          }).toList();

          return Right(datos);
        }
    );
  }
}