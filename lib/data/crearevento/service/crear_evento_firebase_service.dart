import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:diacritic/diacritic.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ticket_pass/data/crearevento/models/crear_evento_model.dart';

abstract class CrearEventoFirebaseService {
  Future<Either> crearEvento(CrearEventoModel evento);
}

class CrearEventoFirebaseServiceImpl extends CrearEventoFirebaseService {
  @override
  Future<Either> crearEvento(CrearEventoModel evento) async {
    try {
      var usuarioFirebase = FirebaseAuth.instance.currentUser;
      Map<String, dynamic> eventoMap = evento.toMap();
      eventoMap['id'] = '';
      eventoMap['organizador'] = usuarioFirebase!.uid;
      eventoMap['nombreNormalizado'] = normalizarNombre(evento.nombre);
      var eventoRef =
          await FirebaseFirestore.instance.collection('eventos').add(eventoMap);
      await FirebaseFirestore.instance
          .collection('eventos')
          .doc(eventoRef.id)
          .update({'id': eventoRef.id});

      WriteBatch batch = FirebaseFirestore.instance.batch();

      for (int i = 0; i < evento.totalEntradas.toInt(); i++) {
        var numeroEntradaRef = FirebaseFirestore.instance
            .collection('eventos')
            .doc(eventoRef.id)
            .collection('entradas')
            .doc();

        batch.set(numeroEntradaRef, {
          'numeroEntrada': numeroEntradaRef.id,
          'eventoId': eventoRef.id,
          'estado': 'disponible',
          'compradorId': '',
          'fechaDeCompra': null,
        });
      }
      await batch.commit();

      return const Right("Evento creado con exito");
    } catch (e) {
      return const Left(
          "Ocurrió un problema inesperado, intentelo de nuevo más tarde");
    }
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
