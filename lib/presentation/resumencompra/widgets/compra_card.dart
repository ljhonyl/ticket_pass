import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:ticket_pass/core/configs/layaout/app_sizes.dart';
import 'package:ticket_pass/domain/compra/entity/compra_entity.dart';
import 'package:ticket_pass/presentation/styles/app_styles.dart';
import 'entrada_card.dart';

class CompraCard extends StatelessWidget {
  final CompraEntity compra;
  final String imagen;

  const CompraCard({required this.compra, required this.imagen, super.key});

  @override
  Widget build(BuildContext context) {
    String fecha = DateFormat('dd-MM-yyyy HH-mm').format(
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
            const Gap(8),
            Text.rich(
              TextSpan(
                text: 'Fecha de compra: ',
                style: AppStyles.cuerpo,
                children: <TextSpan>[
                  TextSpan(
                    text: fecha,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const Gap(8),
            Text.rich(
              TextSpan(
                text: 'Entradas compradas: ',
                style: const TextStyle(fontSize: 14),
                children: <TextSpan>[
                  TextSpan(
                    text: '${compra.cantidad}',
                    style:
                        AppStyles.cuerpo.copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const Gap(8),
            Text(
              'Precio total: ${compra.precioTotal.toStringAsFixed(2)}€',
              style: AppStyles.cuerpo.copyWith(fontWeight: FontWeight.bold),
            ),
            const Gap(8),
            Column(
              children: compra.entradas
                  .map((entrada) => Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: EntradaCard(entrada: entrada, imagen: imagen),
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
