import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticket_pass/common/bloc/button/boton_state_cubit.dart';
import 'package:ticket_pass/common/helper/navigator/app_navegacion.dart';
import 'package:ticket_pass/common/widgets/botones/boton_de_carga.dart';
import 'package:ticket_pass/data/venta/models/entrada_requerida_model.dart';
import 'package:ticket_pass/domain/evento/entity/evento_entity.dart';
import 'package:ticket_pass/domain/venta/usescases/get_entradas_en_venta_caso_de_uso.dart';
import 'package:ticket_pass/presentation/detalle_compra/pages/detalle_compra.dart';
import 'package:ticket_pass/presentation/detalle_evento/bloc/seleccionar_cantidad_cubit.dart';
import 'package:ticket_pass/presentation/styles/app_styles.dart';

import '../../../common/bloc/button/boton_state.dart';

class PasarACompra extends StatelessWidget {
  final EventoEntity entrada;

  const PasarACompra({
    required this.entrada,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SeleccionarCantidadCubit, int>(
      builder: (context, cantidadSeleccionada) {
        // Calcula el precio total basado en el estado actual
        final precioTotal = entrada.precio * cantidadSeleccionada;

        return BlocListener<BotonStateCubit, BotonState>(
          listener: (context, state){
            if(state is BotonHechoState){
              AppNavegacion.push(
                context,
                DetalleCompra(
                    evento: entrada,
                    entradas: state.params,
                    precioTotal: precioTotal
                ),
              );
            }
            if(state is BotonErrorState){
              var snackbar = SnackBar(content: Text(state.msgError), behavior: SnackBarBehavior.floating, );
              ScaffoldMessenger.of(context).showSnackBar(snackbar);
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: BotonDeCarga(
              onPressed: () {
                context.read<BotonStateCubit>().finalizar(
                    casoDeUso: GetEntradasEnVentaCasoDeUso(),
                    params: EntradaRequeridaModel(
                        entrada.id,
                        context.read<SeleccionarCantidadCubit>().state
                    )
                );
              },
              contenido: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    precioTotal.toStringAsFixed(2),
                    style: AppStyles.textoBotonesPrimarios,
                  ),
                   Text(
                    'Procesar Compra',
                    style: AppStyles.textoBotonesPrimarios,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
