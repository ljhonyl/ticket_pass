import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:ticket_pass/common/bloc/button/boton_state.dart';
import 'package:ticket_pass/common/bloc/button/boton_state_cubit.dart';
import 'package:ticket_pass/common/helper/navigator/app_navegacion.dart';
import 'package:ticket_pass/core/configs/layaout/app_sizes.dart';
import 'package:ticket_pass/domain/auth/usecases/restablecer_password_caso_de_uso.dart';
import 'package:ticket_pass/presentation/iniciosesion/pages/inicio_sesion.dart';
import 'package:ticket_pass/presentation/styles/app_styles.dart';

import '../../../common/widgets/botones/boton_de_carga.dart';
import '../../../common/widgets/entradatexto/entrada_texto.dart';
import '../../../core/configs/theme/app_colors.dart';

class RestablecerPassword extends StatelessWidget {
  RestablecerPassword({super.key});

  final TextEditingController _emailCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Restablecer Contraseña'),
        ),
        backgroundColor: AppColors.primario,
        automaticallyImplyLeading: false,
      ),
      body: BlocProvider(
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
            if (state is BotonHechoState) {
              var snackbar = const SnackBar(
                content: Text("Email enviado"),
                behavior: SnackBarBehavior.floating,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackbar);
              Future.delayed(const Duration(seconds: 2), () {
                AppNavegacion.pushReplacement(context, InicioSesion());
              });
            }
          },
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(AppSizes.getMaxWidth(context) * 0.04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Recuperacion",
                    style: AppStyles.h2,
                  ),
                  const Gap(20),
                  EntradaTexto(
                    controller: _emailCon,
                    label: "Email",
                    tipoDetexto: TextInputType.emailAddress,
                  ),
                  const Gap(20),
                  _restablecerPasswordButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _restablecerPasswordButton() {
    return Builder(builder: (context) {
      return BotonDeCarga(
        onPressed: () {
          context.read<BotonStateCubit>().finalizar(
              casoDeUso: RestablecerPasswordCasoDeUso(),
              params: _emailCon.text);
        },
        contenido: Text(
          "Solicitar recuperación",
          style: AppStyles.textoBotonesPrimarios,
        ),
      );
    });
  }
}
