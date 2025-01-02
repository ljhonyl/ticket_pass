import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:ticket_pass/domain/evento/entity/evento_entity.dart';
import 'package:ticket_pass/domain/evento/usescases/get_evento_caso_de_uso.dart';
import 'package:ticket_pass/service_locator.dart';

import '../../../common/bloc/evento/evento_cubit.dart';
import '../../../common/bloc/evento/evento_state.dart';
import '../../../common/widgets/tarjetas/evento_card.dart';

class Entradas extends StatelessWidget {
  const Entradas({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EventoCubit(casoDeUso: sl<GetEventoCasoDeUso>())..mostrarEntradas(),
      child: BlocBuilder<EventoCubit,EventoState>(
        builder: (context, state) {
          if (state is EventoStateCargando) {
            return const CircularProgressIndicator();
          }
          if (state is EventoStateCargado) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _entradasText(),
                const Gap(20),
                _entradasList(context,state.entradas)
              ],
            );
          }
          return Container();
        },
      ),
    );
  }

  Widget _entradasText() {
    return const Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: Text(
        'Entradas',
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16
        ),
      ),
    );
  }

  Widget _entradasList(BuildContext context, List<EventoEntity> entradas) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16), // Mantén el mismo padding.
      child: SizedBox(
        height: 310, // La altura específica de la lista.
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return EventoCard(
              evento: entradas[index],
              width: 150,
              imageHeight: 200,// Pasamos el ancho a la tarjeta.
            );
          },
          separatorBuilder: (context, index) => const SizedBox(width: 10),
          itemCount: entradas.length,
        ),
      ),
    );
  }
}