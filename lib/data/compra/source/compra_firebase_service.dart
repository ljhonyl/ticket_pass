import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/peticion_compra_model.dart';

abstract class CompraFirebaseService{
  Future<Either> comprar(PeticionCompraModel compra);
  Future<Either> getEntradasCompradas(String eventoId);
}

class CompraFirebaseServiceImpl extends CompraFirebaseService{
  @override
  Future<Either> comprar(PeticionCompraModel compra) async{
    print("Legamos al servico de compra de firebase");
    try{
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
          });

      for (var entrada in compra.entradas){
        await FirebaseFirestore.instance
            .collection('entradas')
            .doc(compra.eventoId)
            .collection('entradas')
            .doc(entrada.numeroEntrada)
            .update({
              'estado': 'vendida',
              'comprador': usuarioFirebase.uid,
              'fechaCompra': entrada.fechaCompra,
            });
      }

      return Right("Compra realizada con exito");
    }
    catch(e){
      print(e.toString());
      return Left("Ocurrió un problema inesperado, intentelo de nuevo más tarde");
    }
  }

  @override
  Future<Either> getEntradasCompradas(String eventoId) async {
    print("Servicio");
    try{
      var usuarioFirebase = FirebaseAuth.instance.currentUser;
      var entradas = await FirebaseFirestore.instance
          .collection('usuarios')
          .doc(usuarioFirebase!.uid)
          .collection(eventoId)
          .get();

      return Right(entradas.docs.map((element) => element.data()).toList());
    }
    catch(e){
      print(e.toString());
      return Left("Ocurrió un problema inesperado, intentelo de nuevo más tarde");
    }
  }
}