import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ticket_pass/data/auth/models/usuario_inicio_sesion.dart';

import '../models/usuario.dart';

abstract class InicioSesionFirebaseService {
  Future<Either> registrarse(Usuario usuario);
  Future<Either> iniciarSesion(UsuarioInicioSesion usuario);
  Future<Either> restablecerPassword(String email);
  Future<bool> sesionIniciada();
}

class InicioSesionFirebaseServiceImpl extends InicioSesionFirebaseService{
  @override
  Future<Either> registrarse(Usuario usuario) async{
    try{
      var datos = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: usuario.email!,
        password: usuario.password!,
      );

      await FirebaseFirestore.instance.collection('Usuarios').doc(
        datos.user!.uid
      ).set(
        {
          'nombre': usuario.nombre,
          'apellidos': usuario.apellidos,
          'email': usuario.email,
        }
      );

      return const Right("sesión iniciada");
    }
    on FirebaseAuthException catch(e){
      String msgError = '';

      if(e.code == 'weak-password'){
        msgError='Contraseña débil';
      }
      else if(e.code == 'email-already-in-use'){
        msgError='El email ya esta en uso';
      }
      return Left(msgError);
    }
  }

  @override
  Future<Either> iniciarSesion(UsuarioInicioSesion usuario) async {
    try{
      var respuesta = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: usuario.email!,
        password: usuario.password!,
      );

      return const Right("Sesión Iniciada");
    }
    on FirebaseAuthException catch(e){
      String msgError = '';

      if(e.code == 'invalid-email'){
        msgError='Email no registrado';
      }
      else if(e.code == 'invalid-credential'){
        msgError='Contraseña errónea';
      }
      return Left(msgError);
    }
  }

  @override
  Future<Either> restablecerPassword(String email) async {
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return right("Email enviado, revise su bandeja de entrada");
    }
    catch (e){
      return left("Email no registrado");
    }
  }

  @override
  Future<bool> sesionIniciada() async{
    try{
      if(FirebaseAuth.instance.currentUser != null){
        return true;
      }
      else{
        return false;
      }
    }
    catch(e) {
      return false;
    }
  }

}