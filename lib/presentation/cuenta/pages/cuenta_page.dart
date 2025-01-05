import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:ticket_pass/core/configs/theme/app_colors.dart';
import 'package:ticket_pass/domain/cerrarsesion/usescases/cerrar_sesion_caso_de_uso.dart';
import 'package:ticket_pass/presentation/cuenta/bloc/cuenta_cubit.dart';
import 'package:ticket_pass/presentation/cuenta/bloc/cuenta_state.dart';
import 'package:ticket_pass/presentation/cuenta/widgets/datos_cuenta.dart';
import 'package:ticket_pass/presentation/iniciosesion/pages/inicio_sesion.dart';
import 'package:ticket_pass/presentation/miseventos/pages/mis_eventos_page.dart';
import 'package:ticket_pass/presentation/crearevento/pages/crear_evento_page.dart';
import 'package:ticket_pass/common/helper/navigator/app_navegacion.dart';
import '../../../service_locator.dart';

class CuentaPage extends StatelessWidget {
  const CuentaPage({super.key});

  void _mostrarSnackbar(BuildContext context, String mensaje) {
    var snackbar = SnackBar(
      content: Text(mensaje),
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  void _cerrarSesion(BuildContext context) async {
    final result = await sl<CerrarSesionCasoDeUso>().call();
    result.fold(
            (error) {
          _mostrarSnackbar(context, error);
        },
            (data) {
          _mostrarSnackbar(context, data);
        }
    );

    AppNavegacion.pushAndRemoveUntil(context, InicioSesion(), (route) => false);
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
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _cerrarSesion(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocProvider(
              create: (context) => CuentaCubit()..getCuenta(),
              child: SizedBox(
                height: 100,
                child: BlocBuilder<CuentaCubit, CuentaState>(
                  builder: (context, state) {
                    if (state is CuentaStateCargando) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state is CuentaStateCargada) {
                      return DatosCuenta(cuenta: state.cuenta);
                    }
                    return Container();
                  },
                ),
              ),
            ),
            const Gap(20),
            const Text('Mis Tickets', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const Gap(8),
            _card(icono: Icons.airplane_ticket, texto: 'Ver mis tickets', onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MisEventosPage()),
              );
            }),
            const Gap(20),
            const Text('Crear Eventos', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const Gap(8),
            _card(icono: Icons.event, texto: 'Crear un nuevo evento', onTap: () {
              AppNavegacion.push(context, const CrearEventoPage());
            }),
          ],
        ),
      ),
    );
  }

  Widget _card({required IconData icono, required String texto, required VoidCallback onTap}) {
    return Card(
      elevation: 4,
      child: ListTile(
        title: Text(texto),
        leading: Icon(icono),
        onTap: onTap,
      ),
    );
  }
}
