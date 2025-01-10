import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ticket_pass/common/helper/navigator/app_navegacion.dart';
import 'package:ticket_pass/core/configs/layaout/app_sizes.dart';
import 'package:ticket_pass/core/configs/theme/app_colors.dart';
import 'package:ticket_pass/presentation/codigoqr/codigo_qr_page.dart';
import '../../../domain/misentradas/entity/mi_entrada_entity.dart';

class MiEntradaCard extends StatelessWidget {
  final MiEntradaEntity entrada;
  final String imagen;

  const MiEntradaCard({
    required this.entrada,
    required this.imagen,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    DateTime fechaCompra = entrada.fechaCompra.toDate();
    String formattedDate = DateFormat('dd-MM-yyyy').format(fechaCompra);

    return GestureDetector(
      onTap: () {
        AppNavegacion.push(context, CodigoQrPage(entrada: entrada));
      },
      child: Container(
        height: 100,
        padding: EdgeInsets.all(AppSizes.getMaxWidth(context)*0.02),
        decoration: BoxDecoration(
          color: AppColors.fondoSecundario,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 4,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      width: 90,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(imagen),
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 6,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          entrada.numeroEntrada,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                        Row(
                          children: [
                            Text.rich(
                              overflow: TextOverflow.ellipsis,
                              TextSpan(
                                text: 'Size - ',
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 10,
                                ),
                                children: [
                                  TextSpan(
                                    text: formattedDate,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}