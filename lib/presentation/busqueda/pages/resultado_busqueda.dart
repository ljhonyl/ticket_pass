import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:ticket_pass/domain/evento/usescases/get_evento_por_nombre_caso_de_uso.dart';

import '../../../common/bloc/evento/evento_cubit.dart';
import '../../../common/bloc/evento/evento_state.dart';
import '../../../common/widgets/tarjetas/evento_card.dart';
import '../../../domain/evento/entity/evento_entity.dart';
import '../../../service_locator.dart';
import '../widgets/buscador.dart';

class ResultadoBusqueda extends StatelessWidget {
  const ResultadoBusqueda({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          EventoCubit(casoDeUso: sl<GetEventoPorNombreCasoDeUso>()),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16), // Aplicando padding como en la Home
          child: Column(
            children: [
              Gap(80),
              Buscador(),
              Gap(20),
              _busquedaText(),
              BlocBuilder<EventoCubit, EventoState>(
                builder: (context, state) {
                  if (state is EventoStateCargando) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is EventoStateCargado) {
                    return state.entradas.isEmpty
                        ? Container()
                        : _entradasGridview(state.entradas);
                  }
                  return Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _busquedaText() {
    return const Text(
      "Resultados para",
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
    );
  }

  Widget _entradasGridview(List<EventoEntity> entradas) {
    return Expanded(
      child: GridView.builder(
        itemCount: entradas.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 0,
            childAspectRatio: 1),
        itemBuilder: (BuildContext context, int index) {
          return EventoCard(
              evento: entradas[index], width: 50, imageHeight: 100);
        },
      ),
    );
  }
}