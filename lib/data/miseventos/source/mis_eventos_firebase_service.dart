import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/mi_evento_model.dart';

abstract class MisEventosFirebaseService {
  Future<Either> getEventosAsistidos();
}

class MisEventosFirebaseServiceImpl extends MisEventosFirebaseService {
  @override
  Future<Either> getEventosAsistidos() async {
    try {
      var usuarioFirebase = FirebaseAuth.instance.currentUser;
      var eventosDocs = await FirebaseFirestore.instance
          .collection("usuarios")
          .doc(usuarioFirebase!.uid)
          .collection('eventos')
          .orderBy('fechaEvento')
          .get();

      var eventos = eventosDocs.docs.map((doc) {
        return MiEventoModel.fromMap(doc.data());
      }).toList();

      return right(eventos);
    } catch (e) {
      return left("Ocurrió un error inesperado, inténtelo de nuevo más tarde");
    }
  }
}
