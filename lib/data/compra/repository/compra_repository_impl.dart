import 'package:dartz/dartz.dart';
import 'package:ticket_pass/data/compra/source/compra_firebase_service.dart';
import 'package:ticket_pass/domain/compra/entity/peticion_compra_entity.dart';
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
          return Left(error);
        },
        (data){
            return Right(
              data.map((doc) {
                // Si los datos contienen un campo 'entradas', conviértelo a una lista
                var entradasList = (doc['entradas'] as List?)?.map((entrada) => EntradaCompradaModel.fromMap(entrada)).toList() ?? [];

                // Convierte el Map a CompraModel y luego a CompraEntity
                var compraModel = CompraModel.fromMap(doc, entradasList);
                return compraModel.toEntity();
              }).toList(),
            );
        }
    );
  }
}