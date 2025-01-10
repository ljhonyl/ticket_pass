import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ticket_pass/core/configs/layaout/app_sizes.dart';
import '../../../domain/misentradas/entity/mi_compra_entity.dart';
import 'mi_entrada_card.dart';

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
    String fecha = DateFormat('dd-MM-yyyy  HH:mm').format(
        compra.entradas.isNotEmpty
            ? compra.entradas[0].fechaCompra.toDate()
            : DateTime.now());

    return Card(
      elevation: 4,
      margin: EdgeInsets.all(AppSizes.getMaxWidth(context)*0.02),
      child: Padding(
        padding: EdgeInsets.all(AppSizes.getMaxWidth(context)*0.04),
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
              'Fecha de compra: $fecha',
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            Text(
              'Entradas compradas: ${compra.cantidad}',
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 8),
            Text(
              'Precio total: ${compra.precioTotal.toStringAsFixed(2)}€',
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
