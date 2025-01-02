import 'package:dartz/dartz.dart';
import 'package:ticket_pass/data/venta/models/entrada_en_venta_model.dart';
import 'package:ticket_pass/data/venta/models/entrada_requerida_model.dart';
import 'package:ticket_pass/data/venta/source/venta_firebase_service.dart';
import 'package:ticket_pass/domain/venta/repository/venta_repository.dart';
import '../../../service_locator.dart';

class VentaRepositoryImpl extends VentaRepository {
  @override
  Future<Either> getEntradasEnVenta(EntradaRequeridaModel entradas) async {
    print("Estamos en la implementacion del repositorio");
    var entradasDisponibles = await sl<VentaFirebaseService>().getEntradasEnVenta(entradas);

    return entradasDisponibles.fold(
          (error) {
        return Left(error);
      },
          (data) {
        // Verificar que el número de entradas devueltas sea igual al solicitado
        if (data.length < entradas.numeroEntradas) {
          return Left("No hay suficientes entradas disponibles.");
        }

        // Si hay suficientes entradas, mapearlas y retornarlas
        return Right(
          List.from(data)
              .map((toElement) => EntradaEnVentaModel.fromMap(toElement).toEntity())
              .toList(),
        );
      },
    );
  }
}
