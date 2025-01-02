import '../../../domain/compra/entity/peticion_compra_entity.dart';
import 'peticion_entrada_compra_model.dart';

class PeticionCompraModel {
  final String eventoId;
  final String nombreEvento;
  final num cantidad;
  final num precioTotal;
  final List<PeticionEntradaCompraModel> entradas;

  PeticionCompraModel({
    required this.eventoId,
    required this.nombreEvento,
    required this.cantidad,
    required this.precioTotal,
    required this.entradas,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'eventoId': eventoId,
      'nombreEvento': nombreEvento,
      'cantidad': cantidad,
      'precioTotal': precioTotal,
    };
  }
}

extension PeticionCompraXModel on PeticionCompraModel {
  PeticionCompraEntity toEntity() {
    return PeticionCompraEntity(
      eventoId: eventoId,
      nombreEvento: nombreEvento,
      cantidad: cantidad,
      precioTotal: precioTotal,
      entradas: entradas.map((entrada) => entrada.toEntity()).toList(),
    );
  }
}

