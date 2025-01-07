import 'package:dartz/dartz.dart';
import 'package:ticket_pass/data/venta/models/entrada_en_venta_model.dart';
import 'package:ticket_pass/data/venta/models/entrada_requerida_model.dart';
import 'package:ticket_pass/data/venta/source/venta_firebase_service.dart';
import 'package:ticket_pass/domain/venta/repository/venta_repository.dart';
import '../../../service_locator.dart';

class VentaRepositoryImpl extends VentaRepository {
  @override
  Future<Either> getEntradasEnVenta(EntradaRequeridaModel entradas) async {
    var entradasDisponibles =
        await sl<VentaFirebaseService>().getEntradasEnVenta(entradas);

    return entradasDisponibles.fold(
      (error) {
        return Left(error);
      },
      (data) {
        if (data.length < entradas.numeroEntradas) {
          return const Left("No hay suficientes entradas disponibles.");
        }

        return Right(
          List.from(data)
              .map((toElement) =>
                  EntradaEnVentaModel.fromMap(toElement).toEntity())
              .toList(),
        );
      },
    );
  }
}
