import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticket_pass/common/bloc/evento/evento_cubit.dart';

class Buscador extends StatelessWidget {
  Buscador({super.key});


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 8
      ),
      child: TextField(
        onChanged: (value){
          if(value.isEmpty){
            context.read<EventoCubit>().setEstadoInicial();
          }
          else {
            context.read<EventoCubit>().mostrarEntradas(params: value);
          }
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(12),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50)
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50)
            ),
            hintText: 'Buscar'
        ),
      ),
    );
  }
}