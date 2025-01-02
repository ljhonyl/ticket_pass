import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticket_pass/common/bloc/button/boton_state_cubit.dart';
import 'package:ticket_pass/common/helper/navigator/app_navegacion.dart';
import 'package:ticket_pass/common/widgets/botones/boton_de_carga.dart';
import 'package:ticket_pass/domain/compra/entity/peticion_compra_entity.dart';
import 'package:ticket_pass/domain/compra/usescases/compra_caso_de_uso.dart';
import 'package:ticket_pass/presentation/resumencompra/pages/resumen_compra.dart';

import '../../../common/bloc/button/boton_state.dart';

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
        print(state);
        if (state is BotonHechoState) {
          AppNavegacion.pushReplacement(context, ResumenCompra(eventoId: compra.eventoId));
        }
        if (state is BotonErrorState) {
          print("estamos en finalizar compra ERROR");
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: BotonDeCarga(
          onPressed: () {
            print(compra.toString());
            print("Boton Finalizar Compra Pulsado");
            context.read<BotonStateCubit>()..finalizar(
                casoDeUso: CompraCasoDeUso(),
                params: compra
            );
          },
          contenido: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Finalizar Compra',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
