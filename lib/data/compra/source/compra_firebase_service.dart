import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/compra_model.dart';
import '../models/entrada_comprada_model.dart';
import '../models/peticion_compra_model.dart';

abstract class CompraFirebaseService {
  Future<Either> comprar(PeticionCompraModel compra);
  Future<Either> getEntradasCompradas(String eventoId);
}

class CompraFirebaseServiceImpl extends CompraFirebaseService {
  @override
  Future<Either> comprar(PeticionCompraModel compra) async {
    try {
      var usuarioFirebase = FirebaseAuth.instance.currentUser;
      await FirebaseFirestore.instance
          .collection('usuarios')
          .doc(usuarioFirebase!.uid)
          .collection(compra.eventoId)
          .add({
        'eventoId': compra.eventoId,
        'nombreEvento': compra.nombreEvento,
        'cantidad': compra.cantidad,
        'precioTotal': compra.precioTotal,
        'entradas': compra.entradas.map((entrada) => entrada.toMap()).toList(),
        'fechaDeCompra': FieldValue.serverTimestamp()
      });

      for (var entrada in compra.entradas) {
        await FirebaseFirestore.instance
            .collection('eventos')
            .doc(compra.eventoId)
            .collection('entradas')
            .doc(entrada.numeroEntrada)
            .update({
          'estado': 'vendida',
          'comprador': usuarioFirebase.uid,
          'fechaDeCompra': entrada.fechaCompra,
        });
      }

      var eventoRef = FirebaseFirestore.instance
          .collection('usuarios')
          .doc(usuarioFirebase.uid)
          .collection('eventos')
          .doc(compra.eventoId);

      var eventoDoc = await eventoRef.get();
      if (!eventoDoc.exists) {
        await eventoRef.set({
          'id': compra.eventoId,
          'nombreEvento': compra.nombreEvento,
          'fechaEvento': compra.fechaEvento,
          'imagen': compra.imagen
        });
      }

      return const Right("Compra realizada con exito");
    } catch (e) {
      return const Left(
          "Ocurrió un problema inesperado, intentelo de nuevo más tarde");
    }
  }

  @override
  Future<Either> getEntradasCompradas(String eventoId) async {
    try {
      var usuarioFirebase = FirebaseAuth.instance.currentUser;
      var entradas = await FirebaseFirestore.instance
          .collection('usuarios')
          .doc(usuarioFirebase!.uid)
          .collection(eventoId)
          .orderBy('fechaDeCompra', descending: true)
          .limit(1)
          .get();

      var datos = entradas.docs.map((element) {
        var data = element.data();

        var entradasList = (data['entradas'] as List?)?.map((entrada) {
              return EntradaCompradaModel.fromMap(
                  entrada as Map<String, dynamic>);
            }).toList() ??
            [];

        var compraModel = CompraModel.fromMap(data, entradasList);
        return compraModel;
      }).toList();

      return Right(datos);
    } catch (e) {
      return const Left(
          "Ocurrió un problema inesperado, intentelo de nuevo más tarde");
    }
  }
}
