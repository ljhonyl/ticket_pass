import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:ticket_pass/common/helper/navigator/app_navegacion.dart';
import 'package:ticket_pass/common/widgets/botones/boton_simple.dart';
import 'package:ticket_pass/core/configs/layaout/app_sizes.dart';
import 'package:ticket_pass/core/configs/theme/app_colors.dart';
import 'package:ticket_pass/domain/compra/entity/compra_entity.dart';
import 'package:ticket_pass/presentation/menuinferior/pages/menu_inferior.dart';
import 'package:ticket_pass/presentation/resumencompra/bloc/compra_realizada_cubit.dart';
import 'package:ticket_pass/presentation/resumencompra/bloc/compra_realizada_state.dart';
import 'package:ticket_pass/presentation/resumencompra/widgets/compra_card.dart';

class ResumenCompra extends StatelessWidget {
  final String eventoId;
  final String imagen;

  const ResumenCompra(
      {required this.eventoId, required this.imagen, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Resumen de la Compra'),
        ),
        backgroundColor: AppColors.primario,
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
                const Gap(20),
              ],
            );
          }
          return Container();
        }),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(AppSizes.getMaxWidth(context)*0.02),
        child: BotonSimple(
          onPressed: () {
            AppNavegacion.pushReplacement(context, const MenuInferior());
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
        return CompraCard(
          compra: compra,
          imagen: imagen,
        );
      },
    );
  }
}
