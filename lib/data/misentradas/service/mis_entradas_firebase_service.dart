import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ticket_pass/data/misentradas/models/mi_compra_model.dart';

import '../models/mi_entrada_model.dart';

abstract class MisEntradasFirebaseService{
  Future<Either> getEntradas(String eventoId);
}

class MisEntradasFirebaseServiceImpl extends MisEntradasFirebaseService{
  @override
  Future<Either> getEntradas(String eventoId) async {
    try{
      var usuarioFirebase = await FirebaseAuth.instance.currentUser;
      var comprasDocs = await FirebaseFirestore.instance
          .collection("usuarios")
          .doc(usuarioFirebase!.uid)
          .collection(eventoId)
          .get();

      var compras = comprasDocs.docs.map((doc) {
        var entradasData = doc['entradas'] as List;
        List<MiEntradaModel> entradas = entradasData.map((entradaMap) {
          return MiEntradaModel.fromMap(entradaMap);
        }).toList();
        return MiCompraModel.fromMap(doc.data(), entradas);
      }).toList();

      return right(compras);
    }
    catch(e) {
      print("LEFT SERVICIO0");
      return left("Ocurrió un error inesperado, inténtelo de nuevo más tarde");
    }
  }

}