import '../../../domain/venta/entity/entrada_en_venta_entity.dart';

class EntradaEnVentaModel {
  final String numeroEntrada;

  EntradaEnVentaModel({
    required this.numeroEntrada,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'numeroEntrada': numeroEntrada,
    };
  }

  factory EntradaEnVentaModel.fromMap(Map<String, dynamic> map) {
    return EntradaEnVentaModel(
      numeroEntrada: map['numeroEntrada'] as String,
    );
  }
}

extension EntradaEnVentaXModel on EntradaEnVentaModel {
  EntradaEnVentaEntity toEntity() {
    return EntradaEnVentaEntity(
      numeroEntrada: numeroEntrada,
    );
  }
}
