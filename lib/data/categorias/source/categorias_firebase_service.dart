import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

abstract class CategoriasFirebaseService{
  Future<Either> getCategorias();
}

class CategoriasFirebaseServiceImpl extends CategoriasFirebaseService{
  @override
  Future<Either> getCategorias() async {
    try{
      var categorias = await FirebaseFirestore.instance.collection("categorias").get();

      return right(categorias.docs.map((element) => element.data()).toList());
    }
    catch(e) {
      return left("Ocurrió un error inesperado, inténtelo de nuevo más tarde");
    }
  }

}