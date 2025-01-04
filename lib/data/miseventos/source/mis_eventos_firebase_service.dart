import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/mi_evento_model.dart';

abstract class MisEventosFirebaseService{
  Future<Either> getEventosAsistidos();
}

class MisEventosFirebaseServiceImpl extends MisEventosFirebaseService{
  @override
  Future<Either> getEventosAsistidos() async {
    try{
      print("Firebase Eventos");
      var usuarioFirebase = await FirebaseAuth.instance.currentUser;
      var eventosDocs = await FirebaseFirestore.instance
          .collection("usuarios")
          .doc(usuarioFirebase!.uid)
          .collection('eventos')
          .get();

      print("Documentos recuperados: ${eventosDocs.docs.map((e) => e.data()).toList()}");

      var eventos = eventosDocs.docs.map((doc) {
        print(doc);//llego hasta aqui una vez
        return MiEventoModel.fromMap(doc.data());
      }).toList();
      print(eventos);

      return right(eventos);
    }
    catch(e) {
      return left("Ocurrió un error inesperado, inténtelo de nuevo más tarde");
    }
  }

}