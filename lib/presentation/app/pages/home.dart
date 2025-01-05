import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ticket_pass/presentation/app/widgets/categorias.dart';
import 'package:ticket_pass/presentation/app/widgets/todos_eventos.dart';
import 'package:ticket_pass/presentation/app/widgets/proximamente.dart';

import '../../../core/configs/theme/app_colors.dart';
import '../widgets/buscador.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Inicio'),
        ),
        backgroundColor: AppColors.primario,
        automaticallyImplyLeading: false,
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
