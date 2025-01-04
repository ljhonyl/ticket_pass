import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ticket_pass/data/crearevento/models/crear_evento_model.dart';

abstract class CrearEventoFirebaseService{
  Future<Either> crearEvento(CrearEventoModel evento);
}

class CrearEventoFirebaseServiceImpl extends CrearEventoFirebaseService{
  @override
  Future<Either> crearEvento(CrearEventoModel evento) async{
    print("Legamos al servico de compra de firebase");
    try{
      print(evento.nombre);
      print(evento.categoriaId);
      print(evento.ubicacion);
      print(evento.precio.toString());
      print(evento.fecha.toString());
      print(evento.totalEntradas.toString());
      print(evento.descripcion);
      var usuarioFirebase = FirebaseAuth.instance.currentUser;
      Map<String, dynamic> eventoMap = evento.toMap();
      eventoMap['id'] = '';
      eventoMap['organizador'] = usuarioFirebase!.uid;
      var eventoRef = await FirebaseFirestore.instance.collection('eventos').add(eventoMap);
      await FirebaseFirestore.instance.collection('eventos').doc(eventoRef.id).update({'id': eventoRef.id});

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

      return Right("Evento creado con exito");
    }
    catch(e){
      print(e.toString());
      return Left("Ocurrió un problema inesperado, intentelo de nuevo más tarde");
    }
  }
}