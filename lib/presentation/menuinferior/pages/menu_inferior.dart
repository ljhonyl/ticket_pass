import 'package:flutter/material.dart';
import 'package:ticket_pass/presentation/app/pages/home.dart';
import 'package:ticket_pass/presentation/cuenta/pages/cuenta_page.dart';
import 'package:ticket_pass/presentation/menuinferior/widgets/menu_navegacion.dart';
import 'package:ticket_pass/presentation/miseventos/pages/mis_eventos_page.dart';

class MenuInferior extends StatefulWidget {
  const MenuInferior({super.key});

  @override
  State<MenuInferior> createState() => _MenuInferiorState();
}

class _MenuInferiorState extends State<MenuInferior> {
  int _index = 0;
  static final List<Widget> paginas = <Widget>[
    const Home(),
    const MisEventosPage(),
    const CuentaPage(),
  ];

  void _cambiarPagina(int indexPagina) {
    _index = indexPagina;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: paginas[_index],
      bottomNavigationBar:
          MenuNavegacion(selectedIndex: _index, onItemTapped: _cambiarPagina),
    );
  }
}
