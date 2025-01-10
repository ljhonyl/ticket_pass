import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticket_pass/common/bloc/evento/evento_cubit.dart';
import 'package:ticket_pass/core/configs/layaout/app_sizes.dart';
import 'package:ticket_pass/presentation/busqueda/bloc/buscador_cubit.dart';

class Buscador extends StatelessWidget {
  const Buscador({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BuscadorCubit, String>(
      builder: (context, state) => Column(
        children: [
          TextField(
            onChanged: (value) {
              context.read<BuscadorCubit>().actualizarTexto(value);
              if (value.isEmpty) {
                context.read<EventoCubit>().setEstadoInicial();
              } else {
                context.read<EventoCubit>().mostrarEntradas(params: value);
              }
            },
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(AppSizes.getMaxWidth(context)*0.03),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              hintText: 'Buscar',
            ),
          ),
          _busquedaText(state),
        ],
      ),
    );
  }

  Widget _busquedaText(String busqueda) {
    if (busqueda == '') {
      busqueda = 'Sin resultados';
    } else {
      busqueda = 'Resultados para $busqueda';
    }
    return Text(
      busqueda,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
    );
  }
}
