import 'package:flutter/material.dart';
import 'package:intl/intl.dart';// Asegúrate de importar la entidad adecuada
import '../../../domain/misentradas/entity/mi_compra_entity.dart';
import 'mi_entrada_card.dart';  // Asegúrate de importar MiEntradaCard

class MiCompraCard extends StatelessWidget {
  final MiCompraEntity compra;
  final String imagen;

  const MiCompraCard({
    required this.compra,
    required this.imagen,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Convertir Timestamp a DateTime y formatear la fecha
    String formattedDateCompra = DateFormat('dd-MM-yyyy').format(
        compra.entradas.isNotEmpty ? compra.entradas[0].fechaCompra.toDate() : DateTime.now()
    );

    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              compra.nombreEvento,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Fecha de compra: $formattedDateCompra',  // Formatear la fecha
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            Text(
              'Entradas compradas: ${compra.cantidad}',
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 8),
            Text(
              'Precio total: €${compra.precioTotal}',
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Column(
              children: compra.entradas
                  .map((entrada) => Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: MiEntradaCard(entrada: entrada, imagen: imagen),
              ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
