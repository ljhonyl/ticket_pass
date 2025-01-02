import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ticket_pass/presentation/app/widgets/categorias.dart';
import 'package:ticket_pass/presentation/app/widgets/todos_eventos.dart';
import 'package:ticket_pass/presentation/app/widgets/proximamente.dart';

import '../widgets/buscador.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Gap(20),
            Buscador(),
            Gap(10),
            Categorias(),
            Gap(10),
            Proximamente(),
            Gap(10),
            Entradas()
          ],
        ),
      ),
    );
  }
}
