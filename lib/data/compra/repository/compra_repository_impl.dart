import 'package:dartz/dartz.dart';
import 'package:ticket_pass/data/compra/models/pago_model.dart';
import 'package:ticket_pass/data/compra/source/compra_firebase_service.dart';
import 'package:ticket_pass/data/compra/source/stripe_service.dart';
import 'package:ticket_pass/domain/compra/entity/peticion_compra_entity.dart';
import '../../../domain/compra/repository/compra_repository.dart';
import '../../../service_locator.dart';
import '../models/compra_model.dart';

class CompraRepositoryImpl extends CompraRepository{
  @override
  Future<Either> comprar(PeticionCompraEntity compra) async{
    var respuesta = await StripeService.instance.pagar(PagoModel(amount: compra.precioTotal));
    return respuesta.fold(
        (error) => Left(error),
        (data) async {
           return await sl<CompraFirebaseService>().comprar(compra.toModel());
        });
  }

  @override
  Future<Either> getEntradasCompradas(String eventoId) async {
    var entradasCompradas = await sl<CompraFirebaseService>().getEntradasCompradas(eventoId);

    return entradasCompradas.fold(
        (error){
          return Left(error);
        },
        (data){
          var datos = (data as List<CompraModel>).map((compraModel) {
            return compraModel.toEntity();
          }).toList();

          return Right(datos);
        }
    );
  }
}