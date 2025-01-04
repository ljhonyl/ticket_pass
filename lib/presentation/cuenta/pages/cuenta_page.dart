import 'package:flutter/material.dart';
import 'package:ticket_pass/common/helper/navigator/app_navegacion.dart';
import 'package:ticket_pass/core/configs/theme/app_colors.dart';
import 'package:ticket_pass/presentation/crearevento/pages/crear_evento_page.dart';
import 'package:ticket_pass/presentation/miseventos/pages/mis_eventos_page.dart';

import '../../../common/helper/imagenes/get_url_imagen.dart';
import '../../../common/widgets/menuinferior/menu_navegacion.dart';
import '../../app/pages/home.dart'; // Importar cualquier widget adicional que necesites

class CuentaPage extends StatefulWidget {
  const CuentaPage({super.key});

  @override
  _CuentaPageState createState() => _CuentaPageState();
}

class _CuentaPageState extends State<CuentaPage> {
  int _selectedIndex = 2; // El índice de la cuenta es 2

  // Método para gestionar la navegación
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (_selectedIndex == 0) {
      // Si seleccionas "Home", navegas a Home
      AppNavegacion.pushReplacement(context, Home());
    } else if (_selectedIndex == 1) {
      // Si seleccionas "Tickets", navegas a la página de Tickets
      //AppNavegacion.pushReplacement(context, TicketsPage());
    } else if (_selectedIndex == 2) {
      // En la página de cuenta no hacemos nada porque ya estamos ahí
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Cuenta'),
        ),
        backgroundColor: AppColors.primario,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Sección de perfil (imagen redonda, nombre, apellidos y email)
            Row(
              children: [
                // Imagen redonda
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(
                    GetUrlImagen.getImagenUsuarioUrl()
                  ), // Reemplaza con la URL de la imagen
                ),
                const SizedBox(width: 16),
                // Información personal
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Nombre Apellido',
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Text(
                      'Apellido Segundo',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      'email@example.com',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Bloque Mis Tickets
            const Text(
              'Mis Tickets',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 10),
            // Card que lleva a la pantalla de Tickets
            Card(
              elevation: 4,
              child: ListTile(
                title: const Text('Ver mis tickets'),
                leading: const Icon(Icons.airplane_ticket),
                onTap: () {
                  AppNavegacion.push(context, MisEventosPage());
                },
              ),
            ),
            const SizedBox(height: 20),

            // Bloque Crear Eventos
            const Text(
              'Crear Eventos',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 10),
            // Card que lleva a la pantalla de Crear Eventos
            Card(
              elevation: 4,
              child: ListTile(
                title: const Text('Crear un nuevo evento'),
                leading: const Icon(Icons.event),
                onTap: () {
                  AppNavegacion.push(context, CrearEventoPage());
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: MenuNavegacion(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
