import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:ticket_pass/domain/compra/entity/compra_entity.dart';
import 'package:ticket_pass/presentation/resumencompra/bloc/compra_realizada_cubit.dart';
import 'package:ticket_pass/presentation/resumencompra/bloc/compra_realizada_state.dart';

import '../../../common/helper/navigator/app_navegacion.dart';
import '../../../common/widgets/botones/boton_simple.dart';
import '../../app/pages/home.dart';
import '../widgets/compra_card.dart';

class ResumenCompra extends StatelessWidget {
  final String eventoId;

  const ResumenCompra({
    required this.eventoId,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Center(
            child: const Text('Resumen de la Compra'),
          ),
          backgroundColor: Colors.blue,
          automaticallyImplyLeading: false,
      ),
      body: BlocProvider(
        create: (context) => CompraRealizadaCubit()..mostrarCompra(eventoId),
        child: BlocBuilder<CompraRealizadaCubit, CompraRealizadaState>(
            builder: (context, state) {
              if (state is CompraRealizadaCargando) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is CompraRealizadaCargada) {
                return Column(
                  children: [
                    Expanded(child: _entradas(state.entradas)),
                    const Gap(20),  // Espacio entre las entradas y el botón
                  ],
                );
              }
              return Container();
            }
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BotonSimple(
          onPressed: () {
            AppNavegacion.pushReplacement(context, Home());
          },
          titulo: 'Volver al Inicio',
        ),
      ),
    );
  }

  Widget _entradas(List<CompraEntity> compras) {
    return ListView.builder(
      itemCount: compras.length,
      itemBuilder: (context, index) {
        final compra = compras[index];
        return CompraCard(compra: compra);
      },
    );
  }
}
