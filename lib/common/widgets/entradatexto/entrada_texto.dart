import 'package:flutter/material.dart';
import 'package:ticket_pass/core/configs/layaout/app_sizes.dart';

class EntradaTexto extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hintText;
  final bool esTipoEmail;
  final TextInputType tipoDetexto;

  const EntradaTexto({
    super.key,
    required this.controller,
    required this.label,
    this.hintText = "",
    this.esTipoEmail = false,
    this.tipoDetexto = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppSizes.getMaxHeight(context)*0.01),
      child: TextFormField(
        controller: controller,
        keyboardType: tipoDetexto,
        decoration: InputDecoration(
          labelText: label,
          hintText: hintText,
          border: const OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor ingresa un valor valido para : $label';
          }
          if (esTipoEmail){
            String validarEmail = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
            RegExp regExp = RegExp(validarEmail);
            if (!regExp.hasMatch(value)) {
              return 'Por favor ingresa un correo electrónico válido';
            }
          }
          return null;
        },
      ),
    );
  }
}
