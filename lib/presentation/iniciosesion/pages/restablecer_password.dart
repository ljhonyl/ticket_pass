import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:ticket_pass/common/bloc/button/boton_state.dart';
import 'package:ticket_pass/common/bloc/button/boton_state_cubit.dart';
import 'package:ticket_pass/common/helper/navigator/app_navegacion.dart';
import 'package:ticket_pass/domain/auth/usecases/restablecer_password_caso_de_uso.dart';
import 'package:ticket_pass/presentation/iniciosesion/pages/inicio_sesion.dart';

import '../../../common/widgets/botones/boton_de_carga.dart';

class RestablecerPassword extends StatelessWidget {
  RestablecerPassword({super.key});

  final TextEditingController _emailCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => BotonStateCubit(),
        child:  BlocListener<BotonStateCubit,BotonState>(
          listener: (context, state) {
            if (state is BotonErrorState) {
              var snackbar = SnackBar(
                content: Text(state.msgError),
                behavior: SnackBarBehavior.floating,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackbar);
            }
            if(state is BotonHechoState){
              var snackbar = SnackBar(
                content: Text("Email enviado"),
                behavior: SnackBarBehavior.floating,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackbar);
              Future.delayed(const Duration(seconds: 2), () {
                AppNavegacion.pushReplacement(context, InicioSesion());
              });
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 40
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _tituloText(),
                Gap(20),
                _emailTextField(),
                Gap(20),
                _restablecerPasswordButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _tituloText() {
    return const Text(
      'Restablecer Contraseña',
      style: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold
      ),
    );
  }

  Widget _emailTextField() {
    return TextField(
      controller: _emailCon,
      decoration: const InputDecoration(
          hintText: 'Intoduce el email'
      ),
    );
  }

  Widget _restablecerPasswordButton(){
    return Builder(
        builder: (context){
          return BotonDeCarga(
              onPressed: (){
                context.read<BotonStateCubit>().finalizar(
                    casoDeUso: RestablecerPasswordCasoDeUso(),
                    params: _emailCon.text
                );
              }
          );
        }
    );
  }

}