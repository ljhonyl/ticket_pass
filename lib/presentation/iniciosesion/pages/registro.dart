import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:ticket_pass/common/bloc/button/boton_state.dart';
import 'package:ticket_pass/common/bloc/button/boton_state_cubit.dart';
import 'package:ticket_pass/common/widgets/button/boton_de_carga.dart';
import 'package:ticket_pass/data/auth/models/usuario.dart';
import 'package:ticket_pass/domain/auth/usecases/registro_caso_de_uso.dart';

import '../../../core/configs/theme/app_colors.dart';

class Registro extends StatelessWidget {
  Registro({super.key});

  final TextEditingController _nombreCon = TextEditingController();
  final TextEditingController _apellidosCon = TextEditingController();
  final TextEditingController _emailCon = TextEditingController();
  final TextEditingController _passwordCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => BotonStateCubit()),
        ],
        child: BlocListener<BotonStateCubit, BotonState>(
          listener: (context, state) {
            if (state is BotonErrorState) {
              var snackbar = SnackBar(
                content: Text(state.msgError),
                behavior: SnackBarBehavior.floating,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackbar);
            }
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 40,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _nombreTextField(),
                      const Gap(20),
                      _apellidosTextField(),
                      const Gap(20),
                      _emailTextField(),
                      const Gap(20),
                      _passwordTextField(),
                    ],
                  ),
                ),
                const SizedBox(height: 20), // Añadimos espacio manualmente
                _registraseButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _nombreTextField() {
    return TextField(
      controller: _nombreCon,
      decoration: const InputDecoration(
        hintText: "Nombre",
      ),
    );
  }

  Widget _apellidosTextField() {
    return TextField(
      controller: _apellidosCon,
      decoration: const InputDecoration(
        hintText: "Apellidos",
      ),
    );
  }

  Widget _emailTextField() {
    return TextField(
      controller: _emailCon,
      decoration: const InputDecoration(
        hintText: "Email",
      ),
    );
  }

  Widget _passwordTextField() {
    return TextField(
      controller: _passwordCon,
      decoration: const InputDecoration(
        hintText: "Contraseña",
      ),
    );
  }

  Widget _registraseButton(BuildContext context) {
    return Container(
      height: 100,
      color: AppColors.secondBackground,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Center(
        child: Builder(
          builder: (context) {
            return BotonDeCarga(
              onPressed: () {
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
              },
              titulo: 'Registrarse',
            );
          },
        ),
      ),
    );
  }
}
