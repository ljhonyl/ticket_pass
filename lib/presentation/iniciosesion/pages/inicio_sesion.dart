import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:ticket_pass/common/bloc/button/boton_state_cubit.dart';
import 'package:ticket_pass/common/widgets/entradatexto/entrada_texto.dart';
import 'package:ticket_pass/core/configs/layaout/app_sizes.dart';
import 'package:ticket_pass/core/configs/theme/app_colors.dart';
import 'package:ticket_pass/data/auth/models/usuario_inicio_sesion.dart';
import 'package:ticket_pass/domain/auth/usecases/iniciar_sesion_caso_de_uso.dart';
import 'package:ticket_pass/presentation/iniciosesion/pages/registro.dart';
import 'package:ticket_pass/presentation/iniciosesion/pages/restablecer_password.dart';
import 'package:ticket_pass/presentation/iniciosesion/widgets/password.dart';
import 'package:ticket_pass/presentation/menuinferior/pages/menu_inferior.dart';

import '../../../common/bloc/button/boton_state.dart';
import '../../../common/helper/navigator/app_navegacion.dart';
import '../../../common/widgets/botones/boton_de_carga.dart';
import '../../styles/app_styles.dart';

class InicioSesion extends StatelessWidget {
  InicioSesion({super.key});

  final TextEditingController _emailCon = TextEditingController();
  final TextEditingController _passwordCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Inicio Sesión'),
        ),
        backgroundColor: AppColors.primario,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(AppSizes.getMaxWidth(context)*0.04),
          child: BlocProvider(
            create: (context) => BotonStateCubit(),
            child: BlocListener<BotonStateCubit, BotonState>(
              listener: (context, state) {
                if (state is BotonErrorState) {
                  var snackbar = SnackBar(
                    content: Text(state.msgError),
                    behavior: SnackBarBehavior.floating,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackbar);
                }
                if(state is BotonHechoState){
                  AppNavegacion.pushReplacement(context, const MenuInferior());
                }
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: AppSizes.getMaxHeight(context)*0.2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("TICKET PASS",style: AppStyles.titulos,)
                      ],
                    ),
                  ),
                  const Gap(10),
                  _titulo(),
                  const Gap(20),
                  EntradaTexto(controller: _emailCon, label: "Email", tipoDetexto: TextInputType.emailAddress,),
                  const Gap(10),
                  Password(controller: _passwordCon),
                  const Gap(20),
                  _inicarSesionButton(context),
                  const Gap(20),
                  _crearCuentaRestablecerPasswordText(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _titulo(){
    return Text(
      "Iniciar Sesión",
      style: AppStyles.h1,
    );
  }

  Widget _inicarSesionButton(BuildContext context){
    return Builder(
      builder: (context) {
        return BotonDeCarga(
            onPressed: (){
              var usuario = UsuarioInicioSesion(email: _emailCon.text, password: _passwordCon.text);
              context.read<BotonStateCubit>().finalizar(
                  casoDeUso: IniciarSesionCasoDeUso(),
                  params: usuario
              );
            },
            titulo:  "Iniciar Sesión");
      }
    );
  }

  Widget _crearCuentaRestablecerPasswordText(BuildContext context){
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RichText(
            text: TextSpan(
                children: [
                  TextSpan(
                      text: "¿No tienes cuenta? ",
                      style: AppStyles.cuerpo
                  ),
                  TextSpan(
                      text: "Registrarse",
                      recognizer: TapGestureRecognizer()..onTap=(){
                        AppNavegacion.push(context, Registro());
                      },
                      style: AppStyles.cuerpo.copyWith(fontWeight: FontWeight.bold)
                  )
                ]
            ),
          ),
          const Gap(10),
          RichText(
              text: TextSpan(
                  text: "¿Olvidaste la contraseña?",
                  recognizer: TapGestureRecognizer()..onTap=(){
                    AppNavegacion.push(context, RestablecerPassword());
                  },
                  style: AppStyles.cuerpo.copyWith(fontWeight: FontWeight.bold)
              )
          ),
        ],
      ),
    );
  }
}

