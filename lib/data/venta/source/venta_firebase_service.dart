import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:ticket_pass/data/venta/models/entrada_requerida_model.dart';

abstract class VentaFirebaseService {
  Future<Either> getEntradasEnVenta(EntradaRequeridaModel entradas);
}

class VentaFirebaseServiceImpl extends VentaFirebaseService {
  @override
  Future<Either> getEntradasEnVenta(EntradaRequeridaModel entradas) async {
    try {
      var result =
          await FirebaseFirestore.instance.runTransaction((transaction) async {
        var entradasDisponiblesSnapshot = await FirebaseFirestore.instance
            .collection('eventos')
            .doc(entradas.eventoId)
            .collection('entradas')
            .where('estado', isEqualTo: 'disponible')
            .limit(entradas.numeroEntradas)
            .get();

        if (entradasDisponiblesSnapshot.docs.isEmpty ||
            entradasDisponiblesSnapshot.docs.length < entradas.numeroEntradas) {
          throw Exception("No hay entradas disponibles en este momento");
        }

        var entradasDisponibles =
            entradasDisponiblesSnapshot.docs.map((doc) => doc.data()).toList();

        for (var entradaDoc in entradasDisponiblesSnapshot.docs) {
          transaction.update(entradaDoc.reference, {'estado': 'reservada'});
        }
        return entradasDisponibles;
      });

      return Right(result);
    } catch (e) {
      return const Left(
          "Ocurrió un problema inesperado, intente de nuevo más tarde");
    }
  }
}
