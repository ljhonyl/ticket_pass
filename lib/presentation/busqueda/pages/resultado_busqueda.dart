import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:ticket_pass/common/widgets/gridview/gridview_eventos.dart';
import 'package:ticket_pass/core/configs/layaout/app_sizes.dart';
import 'package:ticket_pass/core/configs/theme/app_colors.dart';
import 'package:ticket_pass/domain/evento/usescases/get_evento_por_nombre_caso_de_uso.dart';
import 'package:ticket_pass/presentation/busqueda/bloc/buscador_cubit.dart';

import '../../../common/bloc/evento/evento_cubit.dart';
import '../../../common/bloc/evento/evento_state.dart';
import '../../../service_locator.dart';
import '../widgets/buscador.dart';

class ResultadoBusqueda extends StatelessWidget {
  const ResultadoBusqueda({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) =>
                EventoCubit(casoDeUso: sl<GetEventoPorNombreCasoDeUso>())),
        BlocProvider(create: (context) => BuscadorCubit())
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text('Busqueda'),
          ),
          backgroundColor: AppColors.primario,
          automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: EdgeInsets.all(AppSizes.getMaxWidth(context)*0.04),
          child: Column(
            children: [
              const Buscador(),
              const Gap(20),
              BlocBuilder<EventoCubit, EventoState>(
                builder: (context, state) {
                  if (state is EventoStateCargando) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is EventoStateCargado) {
                    return state.eventos.isEmpty
                        ? Container()
                        : GridviewEventos(eventos: state.eventos);
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
}
