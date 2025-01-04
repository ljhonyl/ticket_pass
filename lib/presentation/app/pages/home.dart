import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ticket_pass/common/helper/navigator/app_navegacion.dart';
import 'package:ticket_pass/presentation/app/widgets/categorias.dart';
import 'package:ticket_pass/presentation/app/widgets/todos_eventos.dart';
import 'package:ticket_pass/presentation/app/widgets/proximamente.dart';
import 'package:ticket_pass/presentation/app/widgets/buscador.dart';
import 'package:ticket_pass/presentation/cuenta/pages/cuenta_page.dart';

import '../../../common/widgets/menuinferior/menu_navegacion.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (_selectedIndex == 0) {
      // Mantener en la página actual
    } else if (_selectedIndex == 1) {
      // Añadir lógica si es necesario
    } else if (_selectedIndex == 2) {
      AppNavegacion.push(context, CuentaPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16), // Padding global
        child: SingleChildScrollView(
          child: Column(
            children: [
              Gap(40),
              Buscador(),
              Gap(10),
              Categorias(),
              Gap(10),
              Proximamente(),
              Gap(10),
              TodosEventos(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: MenuNavegacion(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
