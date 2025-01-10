import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ticket_pass/data/auth/models/usuario_inicio_sesion_model.dart';

import '../models/usuario_model.dart';

abstract class InicioSesionFirebaseService {
  Future<Either> registrarse(UsuarioModel usuario);
  Future<Either> iniciarSesion(UsuarioInicioSesionModel usuario);
  Future<Either> restablecerPassword(String email);
  Future<bool> sesionIniciada();
}

class InicioSesionFirebaseServiceImpl extends InicioSesionFirebaseService{
  @override
  Future<Either> registrarse(UsuarioModel usuario) async{
    try{
      var usuarioFirebase = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: usuario.email!,
        password: usuario.password!,
      );

      await FirebaseFirestore.instance.collection('usuarios').doc(
        usuarioFirebase.user!.uid
      ).set(
        {
          'id': usuarioFirebase.user!.uid,
          'nombre': usuario.nombre,
          'apellidos': usuario.apellidos,
          'email': usuario.email,
          'imagen': ''
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
  Future<Either> iniciarSesion(UsuarioInicioSesionModel usuario) async {
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
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