import 'package:ticket_pass/domain/cancelarcompra/entity/entrada_cancelada_entity.dart';

class EntradaCanceladaModel {
  final String eventoId;
  final String numeroEntrada;

  EntradaCanceladaModel({
    required this.eventoId,
    required this.numeroEntrada,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'numeroEntrada': numeroEntrada,
    };
  }

  factory EntradaCanceladaModel.fromMap(Map<String, dynamic> map) {
    return EntradaCanceladaModel(
      eventoId: map['eventoId'] as String,
      numeroEntrada: map['numeroEntrada'] as String,
    );
  }
}

extension EntradaCanceladaXModel on EntradaCanceladaModel {
  EntradaCanceladaEntity toEntity() {
    return EntradaCanceladaEntity(
      eventoId: eventoId,
      numeroEntrada: numeroEntrada,
    );
  }
}
