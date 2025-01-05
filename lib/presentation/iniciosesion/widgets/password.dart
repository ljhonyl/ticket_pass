import 'package:flutter/material.dart';

class Password extends StatelessWidget {
  final TextEditingController controller;
  const Password({
    required this.controller,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        obscureText: true, // Oculta el texto
        decoration: const InputDecoration(
          labelText: "Contraseña",
          hintText: "Ingresa tu contraseña",
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor, ingresa una contraseña';
          }
          if (value.length < 8) {
            return 'La contraseña debe tener al menos 8 caracteres';
          }
          if (!RegExp(r'[A-Z]').hasMatch(value)) {
            return 'La contraseña debe incluir al menos una letra mayúscula';
          }
          if (!RegExp(r'[0-9]').hasMatch(value)) {
            return 'La contraseña debe incluir al menos un número';
          }
          return null;
        },
      ),
    );
  }
}
