import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:diacritic/diacritic.dart';

abstract class EventoFirebaseService{
  Future<Either> getProximamente();
  Future<Either> getEntradas();
  Future<Either> getEntradasPorCategoria(String categoria);
  Future<Either> getEntradaPorNombre(String nombre);
}

class EventoFirebaseServiceImpl extends EventoFirebaseService{
  @override
  Future<Either> getProximamente() async {
    try{
      final hoy = DateTime.now();
      final proximamente = hoy.add(Duration(days: 30));

      var datos = await FirebaseFirestore.instance.collection(
        'eventos'
      ).where(
        'fecha',
        isGreaterThan: Timestamp.fromDate(hoy)
      ).where(
        'fecha',
        isLessThanOrEqualTo: Timestamp.fromDate(proximamente)
      ).get();

      return Right(datos.docs.map((item) => item.data()).toList());
    }
    catch(e) {
      return left("Ocurrió un error inesperado, inténtelo de nuevo más tarde");
    }
  }

  @override
  Future<Either> getEntradas() async{
    try{
      var datos = await FirebaseFirestore.instance.collection(
          'eventos'
      ).get();

      return Right(datos.docs.map((item) => item.data()).toList());
    }
    catch(e) {
      return left("Ocurrió un error inesperado, inténtelo de nuevo más tarde");
    }
  }

  @override
  Future<Either> getEntradasPorCategoria(String categoria) async {
    try{
      var datos = await FirebaseFirestore.instance.collection(
          'eventos'
      ).where(
        'categoriaId',
        isEqualTo: categoria
      ).get();

      return Right(datos.docs.map((item) => item.data()).toList());
    }
    catch(e) {
      return left("Ocurrió un error inesperado, inténtelo de nuevo más tarde");
    }
  }

  @override
  Future<Either> getEntradaPorNombre(String nombre) async {
    try{
      var nombreBuscado = normalizarNombre(nombre);
      var datos = await FirebaseFirestore.instance.collection(
          'eventos'
      ).where(
          'nombreNormalizado',
          isGreaterThanOrEqualTo: nombreBuscado
      ).get();

      return Right(datos.docs.map((item) => item.data()).toList());
    }
    catch(e) {
      return left("Ocurrió un error inesperado, inténtelo de nuevo más tarde");
    }
  }

  String normalizarNombre(String nombre){
    String nombreAux = nombre.toLowerCase();
    nombreAux = nombreAux.replaceAll('ñ', '{{ñ}}');
    nombreAux = removeDiacritics(nombreAux);
    nombreAux = nombreAux.replaceAll('{{n}}', 'ñ');
    nombreAux = nombreAux.replaceAll(" ", "");
    nombreAux = nombreAux.replaceAll(RegExp(r'[^a-z0-9ñ]'), '');

    return nombreAux;
  }
}