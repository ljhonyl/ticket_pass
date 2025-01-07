import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ticket_pass/common/helper/navigator/app_navegacion.dart';
import 'package:ticket_pass/core/url/app_url.dart';
import 'package:ticket_pass/presentation/app/widgets/categorias.dart';
import 'package:ticket_pass/presentation/app/widgets/todos_eventos.dart';
import 'package:ticket_pass/presentation/app/widgets/proximamente.dart';
import 'package:ticket_pass/presentation/ayuda/ayuda_page.dart';

import '../../../core/configs/layaout/app_sizes.dart';
import '../../../core/configs/theme/app_colors.dart';
import '../widgets/buscador.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding (
          padding: EdgeInsets.only(left: AppSizes.getMaxWidth(context)*0.135),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Inicio'),
            ],
          ),
        ),
        backgroundColor: AppColors.primario,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline), // Icono de ayuda
            tooltip: 'Ayuda',
            onPressed: () {
              AppNavegacion.push(context, AyudaPage(pdfUrl: AppUrl.ayudaHome,));
            },
          ),
        ],
      ),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Buscador(),
              Gap(10),
              Categorias(),
              Gap(10),
              Proximamente(),
              Gap(10),
              TodosEventos()
            ],
          ),
        ),
      ),
    );
  }
}
