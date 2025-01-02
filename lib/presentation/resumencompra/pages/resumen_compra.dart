import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:ticket_pass/domain/compra/entity/compra_entity.dart';
import 'package:ticket_pass/domain/compra/entity/entrada_comprada_entity.dart';
import 'package:ticket_pass/presentation/resumencompra/bloc/compra_realizada_cubit.dart';
import 'package:ticket_pass/presentation/resumencompra/bloc/compra_realizada_state.dart';
import 'package:ticket_pass/presentation/resumencompra/widgets/entrada_card.dart';

class ResumenCompra extends StatelessWidget {
  final String eventoId;
  const ResumenCompra({
    required this.eventoId,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => CompraRealizadaCubit()..mostrarCompra(eventoId),
        child: BlocBuilder<CompraRealizadaCubit, CompraRealizadaState>(
            builder: (context, state){
              if(state is CompraRealizadaCargando){
                return const Center(child: CircularProgressIndicator());
              }
              if(state is CompraRealizadaCargada){
                return Container(
                  child: _entradas(state.entradas),
                );
              }
              return Container();
            }
        ),
      ),
    );
  }

  Widget _entradas(List<CompraEntity> compra){
    return ListView.separated(
        itemBuilder: (context, index){
          return EntradaCard(entrada: compra[index].entradas[index]);
        },
        separatorBuilder: (context, index) => Gap(10),
        itemCount: compra.length
    );
  }
}
