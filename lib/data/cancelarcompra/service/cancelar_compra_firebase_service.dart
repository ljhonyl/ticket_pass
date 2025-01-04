
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:ticket_pass/data/cancelarcompra/models/entrada_cancelada_model.dart';

abstract class CancelarCompraFirebaseService{
  Future<Either> cancelarCompra(List<EntradaCanceladaModel> entradas);
}

class CancelarCompraFirebaseServiceImpl extends CancelarCompraFirebaseService{
  @override
  Future<Either> cancelarCompra(List<EntradaCanceladaModel> entradas) async {
    try{

      for (var entrada in entradas){
        await FirebaseFirestore.instance
            .collection('eventos')
            .doc(entrada.eventoId)
            .collection('entradas')
            .doc(entrada.numeroEntrada)
            .update({
              'estado': 'disponible',
            });
      }

      return Right("Compra realizada con exito");
    }
    catch(e){
      print(e.toString());
      return Left("Ocurrió un problema inesperado, intentelo de nuevo más tarde");
    }
  }

}
