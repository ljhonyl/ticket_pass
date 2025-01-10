import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:ticket_pass/common/bloc/button/boton_state_cubit.dart';
import 'package:ticket_pass/core/configs/layaout/app_sizes.dart';
import 'package:ticket_pass/domain/evento/entity/evento_entity.dart';
import 'package:ticket_pass/presentation/detalle_evento/bloc/seleccionar_cantidad_cubit.dart';
import 'package:ticket_pass/presentation/detalle_evento/widgets/lista_imagenes.dart';
import 'package:ticket_pass/presentation/detalle_evento/widgets/pasar_a_compra.dart';
import 'package:ticket_pass/presentation/detalle_evento/widgets/seleccionar_cantidad.dart';
import 'package:ticket_pass/presentation/styles/app_styles.dart';

class DetalleEvento extends StatelessWidget {
  final EventoEntity entrada;
  const DetalleEvento({
    required this.entrada,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SeleccionarCantidadCubit()),
        BlocProvider(create: (context) => BotonStateCubit())
      ],
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSizes.getMaxWidth(context)*0.04),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(40),
                ListaImagenes(imagenes: entrada.imagenes),
                const Gap(20),
                _nombreUbicacionDescripcionText(),
                const Gap(20),
                SeleccionarCantidad(entradaEntity: entrada),
                const Gap(20),
              ],
            ),
          ),
        ),
        bottomNavigationBar: PasarACompra(entrada: entrada),
      ),
    );
  }

  Widget _nombreUbicacionDescripcionText() {
    String fecha = DateFormat('dd-MM-yyyy  HH:mm').format(entrada.fecha.toDate());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(entrada.nombre, style: AppStyles.h1),
        const Gap(10),
        Text("Ubicación:", style: AppStyles.h2),
        Text(entrada.ubicacion),
        const Gap(10),
        Text("Fecha de realizacion", style: AppStyles.h2,),
        Text(fecha),
        const Gap(10),
        Text("Descripción:", style: AppStyles.h2),
        Text(entrada.descripcion),
      ],
    );
  }
}
