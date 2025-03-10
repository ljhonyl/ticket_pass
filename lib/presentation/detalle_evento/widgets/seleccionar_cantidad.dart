import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticket_pass/core/configs/layaout/app_sizes.dart';
import 'package:ticket_pass/core/configs/theme/app_colors.dart';
import 'package:ticket_pass/domain/evento/entity/evento_entity.dart';

import '../../styles/app_styles.dart';
import '../bloc/seleccionar_cantidad_cubit.dart';

class SeleccionarCantidad extends StatelessWidget {
  final EventoEntity entradaEntity;
  const SeleccionarCantidad({
    required this.entradaEntity,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: EdgeInsets.only(left: AppSizes.getMaxWidth(context)*0.03),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: AppColors.fondoSecundario
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Entradas',
            style: AppStyles.cuerpo.copyWith(fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              IconButton(
                  onPressed: (){
                    context.read<SeleccionarCantidadCubit>().restar();
                  },
                  icon: Container(
                    height: 40,
                    width: 40,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.remove,
                        size: 30,
                      ),
                    ),
                  )
              ),
              const SizedBox(width: 10,),
              BlocBuilder<SeleccionarCantidadCubit,int>(
                builder: (context, state) => Text(
                  state.toString(),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                  ),
                ),
              ),
              const SizedBox(width: 10,),
              IconButton(
                  onPressed: (){
                    context.read<SeleccionarCantidadCubit>().sumar();
                  },
                  icon: Container(
                    height: 40,
                    width: 40,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.add,
                        size: 30,
                      ),
                    ),
                  )
              ),
            ],
          )
        ],
      ),
    );
  }
}