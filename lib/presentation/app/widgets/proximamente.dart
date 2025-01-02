import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:ticket_pass/common/bloc/evento/evento_cubit.dart';
import 'package:ticket_pass/common/bloc/evento/evento_state.dart';
import 'package:ticket_pass/domain/evento/entity/evento_entity.dart';
import 'package:ticket_pass/domain/evento/usescases/get_proximamente_caso_de_uso.dart';

import '../../../common/widgets/tarjetas/evento_card.dart';
import '../../../service_locator.dart';

class Proximamente extends StatelessWidget {
  const Proximamente({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EventoCubit(casoDeUso: sl<GetProximamenteCasoDeUso>())..mostrarEntradas(),
      child: BlocBuilder<EventoCubit, EventoState>(
        builder: (context, state) {
          if (state is EventoStateCargando) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is EventoStateCargado) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _proximamenteText(context),
                const Gap(20),
                _proximamenteList(state.entradas, context),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }

  Widget _proximamenteText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16), // Padding uniforme.
      child: Align(
        alignment: Alignment.centerLeft, // Asegura que esté alineado a la izquierda.
        child: const Text(
          'Proximamente',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _proximamenteList(List<EventoEntity> proximamente, BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width; // Obtiene el ancho de la pantalla.
    final cardWidth = screenWidth * 0.8; // Calcula el 80% del ancho para la tarjeta.

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16), // Mantén el mismo padding.
      child: SizedBox(
        height: 210, // La altura específica de la lista.
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return EventoCard(
              evento: proximamente[index],
              width: cardWidth,
              imageHeight: 150,// Pasamos el ancho a la tarjeta.
            );
          },
          separatorBuilder: (context, index) => const SizedBox(width: 10),
          itemCount: proximamente.length,
        ),
      ),
    );
  }
}
