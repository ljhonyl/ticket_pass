import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticket_pass/common/bloc/button/boton_state_cubit.dart';
import 'package:ticket_pass/common/helper/navigator/app_navegacion.dart';
import 'package:ticket_pass/common/widgets/botones/boton_de_carga.dart';
import 'package:ticket_pass/domain/compra/entity/peticion_compra_entity.dart';
import 'package:ticket_pass/domain/compra/usescases/compra_caso_de_uso.dart';
import 'package:ticket_pass/presentation/resumencompra/pages/resumen_compra.dart';

import '../../../common/bloc/button/boton_state.dart';
import '../../styles/app_styles.dart';

class FinalizarCompra extends StatelessWidget {
  final PeticionCompraEntity compra;

  const FinalizarCompra({
    required this.compra,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<BotonStateCubit, BotonState>(
      listener: (context, state) {
        if (state is BotonStateHecho) {
          AppNavegacion.pushReplacement(context, ResumenCompra(eventoId: compra.eventoId, imagen: compra.imagen,));
        }
        if (state is BotonStateError) {
          var snackbar = SnackBar(content: Text(state.msgError), behavior: SnackBarBehavior.floating, );
          ScaffoldMessenger.of(context).showSnackBar(snackbar);
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: BotonDeCarga(
          onPressed: () {
            context.read<BotonStateCubit>().finalizar(
                casoDeUso: CompraCasoDeUso(),
                params: compra
            );
          },
          contenido: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Finalizar Compra',
                style: AppStyles.textoBotonesPrimarios,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
