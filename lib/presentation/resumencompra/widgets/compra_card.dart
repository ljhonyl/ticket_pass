import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Asegúrate de importar intl
import 'package:ticket_pass/domain/compra/entity/compra_entity.dart';
import 'entrada_card.dart'; // Asegúrate de importar EntradaCard

class CompraCard extends StatelessWidget {
  final CompraEntity compra;

  const CompraCard({required this.compra, super.key});

  @override
  Widget build(BuildContext context) {
    // Convertir Timestamp a DateTime y formatear la fecha
    String formattedDateCompra = DateFormat('dd-MM-yyyy').format(compra.entradas.isNotEmpty ? compra.entradas[0].fechaCompra.toDate() : DateTime.now());

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
              'Fecha de compra: $formattedDateCompra', // Formatear la fecha
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
            // Mostrar las entradas compradas
            ...compra.entradas.map((entrada) => EntradaCard(entrada: entrada)).toList(),
          ],
        ),
      ),
    );
  }
}
