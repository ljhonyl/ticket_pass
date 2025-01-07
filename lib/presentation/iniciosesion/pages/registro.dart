import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:ticket_pass/common/bloc/button/boton_state.dart';
import 'package:ticket_pass/common/bloc/button/boton_state_cubit.dart';
import 'package:ticket_pass/common/helper/navigator/app_navegacion.dart';
import 'package:ticket_pass/common/widgets/entradatexto/entrada_texto.dart';
import 'package:ticket_pass/core/configs/layaout/app_sizes.dart';
import 'package:ticket_pass/data/auth/models/usuario.dart';
import 'package:ticket_pass/domain/auth/usecases/registro_caso_de_uso.dart';
import 'package:ticket_pass/presentation/iniciosesion/pages/inicio_sesion.dart';
import 'package:ticket_pass/presentation/iniciosesion/widgets/password.dart';
import 'package:ticket_pass/presentation/styles/app_styles.dart';

import '../../../common/widgets/botones/boton_de_carga.dart';
import '../../../core/configs/theme/app_colors.dart';

class Registro extends StatelessWidget {
  Registro({super.key});

  final TextEditingController _nombreCon = TextEditingController();
  final TextEditingController _apellidosCon = TextEditingController();
  final TextEditingController _emailCon = TextEditingController();
  final TextEditingController _passwordCon = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => BotonStateCubit()),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text('Registro'),
          ),
          backgroundColor: AppColors.primario,
          automaticallyImplyLeading: false,
        ),
        body: BlocListener<BotonStateCubit, BotonState>(
          listener: (context, state) {
            if (state is BotonErrorState) {
              var snackbar = SnackBar(
                content: Text(state.msgError),
                behavior: SnackBarBehavior.floating,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackbar);
            }
            if(state is BotonHechoState){
              AppNavegacion.pushReplacement(context, InicioSesion());
            }
          },
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(AppSizes.getMaxWidth(context)*0.04),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Introduce tus datos", style: AppStyles.h2,),
                        EntradaTexto(controller: _nombreCon, label: "Nombre", hintText: "Ingresa tu nombre",),
                        const Gap(20),
                        EntradaTexto(controller: _apellidosCon, label: "Apellidos", hintText: "Ingresa tus apellidos",),
                        const Gap(20),
                        EntradaTexto(controller: _emailCon, label: "Email", hintText: "Ingresa tu correo electrónico", esTipoEmail: true,tipoDetexto: TextInputType.emailAddress,),
                        const Gap(20),
                        Password(controller: _passwordCon),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: _registraseButton(context),
      ),
    );
  }

  Widget _registraseButton(BuildContext context) {
    return Container(
      height: 100,
      color: AppColors.fondoSecundario,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Center(
        child: Builder(
          builder: (context) {
            return BotonDeCarga(
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  var usuario = Usuario(
                    nombre: _nombreCon.text,
                    apellidos: _apellidosCon.text,
                    email: _emailCon.text,
                    password: _passwordCon.text,
                  );
                  context.read<BotonStateCubit>().finalizar(
                        casoDeUso: RegistroCasoDeUso(),
                        params: usuario,
                      );
                }
              },
              titulo: 'Registrarse',
            );
          },
        ),
      ),
    );
  }
}