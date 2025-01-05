import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ticket_pass/data/cuenta/models/cuenta_model.dart';

abstract class CuentaFirebaseService{
  Future<Either> getCuenta();
  Future<Either> setImagen(String imagen);
}

class CuentaFirebaseServiceImpl extends CuentaFirebaseService{
  @override
  Future<Either> getCuenta() async {
    try{
      var usuarioFirebase = FirebaseAuth.instance.currentUser;

      var usuarioDoc = await FirebaseFirestore.instance
          .collection('usuarios')
          .doc(usuarioFirebase!.uid)
          .get();

      return Right(CuentaModel.fromMap(usuarioDoc.data()!));
    }
    catch(e){
      return Left("No pudimos recuperar los datos de su cuenta");
    }
  }

  @override
  Future<Either> setImagen(String imagen) async{
    try{
      var usuarioFirebase = FirebaseAuth.instance.currentUser;

      await FirebaseFirestore.instance
          .collection('usuarios')
          .doc(usuarioFirebase!.uid)
          .update({'imagen': imagen});

      return Right("Imagen actualizada correctamente");
    }
    catch(e){
      return Left("Upss... Cambio de imagen no persistente");
    }
  }

}