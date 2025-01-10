import 'package:flutter/material.dart';
import 'package:ticket_pass/common/helper/navigator/app_navegacion.dart';
import 'package:ticket_pass/core/configs/layaout/app_sizes.dart';
import 'package:ticket_pass/presentation/busqueda/pages/resultado_busqueda.dart';

class Buscador extends StatelessWidget {
  const Buscador({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: true,
      onTap: () {
        AppNavegacion.push(context, const ResultadoBusqueda());
      },
      decoration: InputDecoration(
        contentPadding:  EdgeInsets.all(AppSizes.getMaxWidth(context)*0.03),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        hintText: 'Buscar...',
      ),
    );
  }
}
