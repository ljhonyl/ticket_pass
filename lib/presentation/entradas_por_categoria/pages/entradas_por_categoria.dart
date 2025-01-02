import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:ticket_pass/common/bloc/evento/evento_cubit.dart';
import 'package:ticket_pass/common/bloc/evento/evento_state.dart';
import 'package:ticket_pass/domain/categorias/entity/categoria_entity.dart';
import 'package:ticket_pass/domain/evento/entity/evento_entity.dart';
import 'package:ticket_pass/domain/evento/usescases/get_evento_por_categoria_caso_de_uso.dart';

import '../../../common/widgets/tarjetas/evento_card.dart';
import '../../../service_locator.dart';

class EntradasPorCategoria extends StatelessWidget {
  final CategoriaEntity categoria;
  const EntradasPorCategoria({
    required this.categoria,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
          create: (context) => EventoCubit(casoDeUso: sl<GetEventoPorCategoriaCasoDeUso>())..mostrarEntradas(params: categoria.id),
        child: BlocBuilder<EventoCubit,EventoState>(
            builder: (context,state){
              if(state is EventoStateCargando){
                return Center(child: CircularProgressIndicator());
              }
              if(state is EventoStateCargado){
                return Column(
                  children: [
                    Gap(80),
                    _datosCatgeoriaText(state.entradas),
                    Gap(10),
                    _entradasGridview(state.entradas)
                  ],
                );
              }
              return Container(child: Text("ERROR"),);
            }
        ),
      ),
    );
  }

  Widget _datosCatgeoriaText(List<EventoEntity> entradas) {
    return Text(
      '${categoria.nombre} (${entradas.length})',
      style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16
      ),
    );
  }

  Widget _entradasGridview(List<EventoEntity> entradas) {
    return Expanded(
      child: GridView.builder(
        itemCount: entradas.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.6
        ),
        itemBuilder: (BuildContext context, int index) {
          return EventoCard(
              evento: entradas[index],
              width: 50,
              imageHeight:100
          );
        },
      ),
    );
  }
}
