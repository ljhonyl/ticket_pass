import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:ticket_pass/core/configs/theme/app_colors.dart';
import 'package:ticket_pass/domain/misventos/entity/mi_evento_entity.dart';
import 'package:ticket_pass/presentation/miseventos/bloc/mi_evento_cubit.dart';
import 'package:ticket_pass/presentation/miseventos/bloc/mi_evento_state.dart';
import '../../../core/configs/layaout/app_sizes.dart';
import '../../../core/url/app_url.dart';
import '../widgets/mi_evento_card.dart';
import '../widgets/sin_eventos_card.dart';

class MisEventosPage extends StatelessWidget {

  const MisEventosPage({super.key,});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Mis eventos'),
        ),
        backgroundColor: AppColors.primario,
        automaticallyImplyLeading: false,
      ),
      body: BlocProvider(
        create: (context) => MiEventoCubit()..mostrarCompras(),
        child: BlocBuilder<MiEventoCubit, MiEventoState>(
          builder: (context, state) {
            if (state is MiEventoStateCargando) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is MiEventostateCargado) {
              if(state.eventos.isNotEmpty){
                return Column(
                  children: [
                    Expanded(child: _entradas(state.eventos)),
                    const Gap(20), // Espacio entre la lista y el botón
                  ],
                );
              }
              else{
                print(AppUrl.imagenSinEventos);
                return Center(
                  child: SinEventosCard(
                      imageUrl: AppUrl.imagenSinEventos,
                      height: AppSizes.getMaxHeight(context)*0.7,
                      width: AppSizes.getMaxWidth(context)*0.9
                  ),
                );
              }

            }
            return const Center(child: Text('No se encontraron entradas.'));
          },
        ),
      )
    );
  }

  Widget _entradas(List<MiEventoEntity> eventos) {
    return ListView.builder(
      itemCount: eventos.length,
      itemBuilder: (context, index) {
        final evento = eventos[index];
        return MiEventoCard(evento: evento,);
      },
    );
  }
}
