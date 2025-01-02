import 'package:ticket_pass/data/venta/models/entrada_en_venta_model.dart';

class EntradaEnVentaEntity {
  final String numeroEntrada;

  EntradaEnVentaEntity({
    required this.numeroEntrada,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'numeroEntrada': numeroEntrada,
    };
  }

  factory EntradaEnVentaEntity.fromMap(Map<String, dynamic> map) {
    return EntradaEnVentaEntity(
      numeroEntrada: map['numeroEntrada'] as String,
    );
  }
}

extension EntradaEnVentaXEntity on EntradaEnVentaModel {
  EntradaEnVentaModel toModel() {
    return EntradaEnVentaModel(
      numeroEntrada: numeroEntrada,
    );
  }
}

