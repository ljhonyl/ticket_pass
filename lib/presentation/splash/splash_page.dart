import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticket_pass/common/helper/navigator/app_navegacion.dart';
import 'package:ticket_pass/presentation/iniciosesion/pages/inicio_sesion.dart';
import 'package:ticket_pass/presentation/menuinferior/pages/menu_inferior.dart';
import 'package:ticket_pass/presentation/splash/bloc/splash_cubit.dart';
import 'package:ticket_pass/presentation/splash/bloc/splash_state.dart';

import '../../core/configs/theme/app_colors.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashState>(
      listener: (context, state) {
        if(state is SesionNoIniciada){
          AppNavegacion.pushReplacement(context, InicioSesion());
        }
        if(state is SesionIniciada){
          AppNavegacion.pushReplacement(context,  const MenuInferior());
        }
      },
      child: const Scaffold(
        backgroundColor: AppColors.primario,
        body: Center(
          child: Text("APP"),
        ),
      ),
    );
  }
}
