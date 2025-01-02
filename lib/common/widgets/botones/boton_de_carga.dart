import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/button/boton_state.dart';
import '../../bloc/button/boton_state_cubit.dart';

class BotonDeCarga extends StatelessWidget {
  final VoidCallback onPressed;
  final String titulo;
  final Widget? contenido;
  final double? height;
  final double? width;

  const BotonDeCarga(
      {required this.onPressed,
        this.titulo = '',
        this.height,
        this.width,
        this.contenido,
        super.key
      });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BotonStateCubit, BotonState>(
        builder: (context,state){
          if (state is BotonCargandoState){
            return _cargando();
          }
          else{
            return _inicial();
          }
        }
    );
  }

  Widget _cargando(){
    return ElevatedButton(
        onPressed: null,
        style: ElevatedButton.styleFrom(
            minimumSize: Size.fromHeight(height ?? 50)
        ),
        child: Container(
          height: height ?? 50,
          alignment: Alignment.center,
          child: const CircularProgressIndicator(),
        )
    );
  }

  Widget _inicial(){
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          minimumSize: Size.fromHeight(height ?? 50)
      ),
      child: contenido ?? Text(
        titulo,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
