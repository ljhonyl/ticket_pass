import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:ticket_pass/core/configs/layaout/app_sizes.dart';
import 'package:ticket_pass/core/configs/theme/app_colors.dart';
import 'package:ticket_pass/domain/misentradas/entity/mi_compra_entity.dart';
import 'package:ticket_pass/presentation/menuinferior/pages/menu_inferior.dart';
import 'package:ticket_pass/presentation/misentradas/bloc/mis_entradas_cubit.dart';
import 'package:ticket_pass/presentation/misentradas/bloc/mis_entradas_state.dart';
import 'package:ticket_pass/presentation/misentradas/widgets/mi_compra_card.dart';

import '../../../common/helper/navigator/app_navegacion.dart';
import '../../../common/widgets/botones/boton_simple.dart';

class MisEntradasPage extends StatelessWidget {
  final String eventoId;
  final String imagen;

  const MisEntradasPage(
      {required this.eventoId, required this.imagen, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Mis Entradas'),
        ),
        backgroundColor: AppColors.primario,
        automaticallyImplyLeading: false,
      ),
      body: BlocProvider(
        create: (context) => MisEntradasCubit()..mostrarCompras(eventoId),
        child: BlocBuilder<MisEntradasCubit, MisEntradasState>(
            builder: (context, state) {
          if (state is MisEntradasStateCargando) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is MisEntradasStateCargadas) {
            return Column(
              children: [
                Expanded(child: _entradas(state.compras)),
                const Gap(20),
              ],
            );
          }
          return Container();
        }),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(AppSizes.getMaxHeight(context)*0.01),
        child: BotonSimple(
          onPressed: () {
            AppNavegacion.pushReplacement(context, const MenuInferior());
          },
          titulo: 'Volver al Inicio',
        ),
      ),
    );
  }

  Widget _entradas(List<MiCompraEntity> compras) {
    return ListView.builder(
      itemCount: compras.length,
      itemBuilder: (context, index) {
        final compra = compras[index];
        return MiCompraCard(
          compra: compra,
          imagen: imagen,
        );
      },
    );
  }
}
