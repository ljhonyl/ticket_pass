import 'package:dartz/dartz.dart';
import 'package:diacritic/diacritic.dart';
import 'package:ticket_pass/data/evento/models/evento_model.dart';
import 'package:ticket_pass/data/evento/source/evento_firebase_service.dart';
import 'package:ticket_pass/domain/evento/repository/evento_repository.dart';

import '../../../service_locator.dart';

class EventoRepositoryImpl extends EventoRepository {
  @override
  Future<Either> getProximamente() async {
    var proximamente = await sl<EventoFirebaseService>().getProximamente();

    return proximamente.fold((error) {
      return Left(error);
    }, (data) {
      return Right(List.from(data)
          .map((item) => EventoModel.fromMap(item).toEntity())
          .toList());
    });
  }

  @override
  Future<Either> getEntradas() async {
    var entradas = await sl<EventoFirebaseService>().getEntradas();

    return entradas.fold((error) {
      return Left(error);
    }, (data) {
      return Right(List.from(data)
          .map((item) => EventoModel.fromMap(item).toEntity())
          .toList());
    });
  }

  @override
  Future<Either> getEntradasPorCategoria(String categoria) async {
    var entradas =
        await sl<EventoFirebaseService>().getEntradasPorCategoria(categoria);

    return entradas.fold((error) {
      return Left(error);
    }, (data) {
      return Right(List.from(data)
          .map((item) => EventoModel.fromMap(item).toEntity())
          .toList());
    });
  }

  @override
  Future<Either> getEntradaPorNombre(String nombre) async {
    var entradas = await sl<EventoFirebaseService>().getEntradaPorNombre();

    return entradas.fold((error) {
      return Left(error);
    }, (data) {
      var elementos = List<EventoModel>.from(
        data.map((item) => EventoModel.fromMap(item)),
      );

      var elementosBuscados = elementos.where((item) {
        return normalizarNombre(item.nombreNormalizado)
            .contains(normalizarNombre(nombre));
      }).toList();

      var resultado = elementosBuscados.map((item) => item.toEntity()).toList();

      return Right(resultado);
    });
  }

  String normalizarNombre(String nombre) {
    String nombreAux = nombre.toLowerCase();
    nombreAux = nombreAux.replaceAll('ñ', '{{ñ}}');
    nombreAux = removeDiacritics(nombreAux);
    nombreAux = nombreAux.replaceAll('{{n}}', 'ñ');
    nombreAux = nombreAux.replaceAll(RegExp(r'[^a-z0-9ñ]'), '');

    return nombreAux;
  }
}
