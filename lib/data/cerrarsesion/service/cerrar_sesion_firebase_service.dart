import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class CerrarSesionFirebaseService {
  Future<Either> cerrarSesion();
}

class CerrarSesionFirebaseServiceImpl extends CerrarSesionFirebaseService {
  @override
  Future<Either> cerrarSesion() async {
    try {
      await FirebaseAuth.instance.signOut();

      return const Right("Sesión Cerrada");
    } catch (e) {
      return const Left("Ocurrió un problema al intentar cerrar la sesión");
    }
  }
}
