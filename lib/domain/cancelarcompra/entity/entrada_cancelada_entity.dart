import '../../../data/cancelarcompra/models/entrada_cancelada_model.dart';

class EntradaCanceladaEntity {
  final String eventoId;
  final String numeroEntrada;

  EntradaCanceladaEntity({
    required this.eventoId,
    required this.numeroEntrada,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'numeroEntrada': numeroEntrada,
    };
  }

  factory EntradaCanceladaEntity.fromMap(Map<String, dynamic> map) {
    return EntradaCanceladaEntity(
      eventoId: map['eventoId'] as String,
      numeroEntrada: map['numeroEntrada'] as String,
    );
  }
}

extension EntradaCanceladaXEntity on EntradaCanceladaEntity {
  EntradaCanceladaModel toModel() {
    return EntradaCanceladaModel(
      eventoId: eventoId,
      numeroEntrada: numeroEntrada,
    );
  }
}

