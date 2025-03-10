import 'package:flutter/material.dart';

class Descripcion extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hintText;
  final TextInputType tipoDetexto;

  const Descripcion({
    super.key,
    required this.controller,
    required this.label,
    this.hintText = "",
    this.tipoDetexto = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        keyboardType: tipoDetexto,
        maxLines: 5,
        minLines: 1,
        decoration: InputDecoration(
          labelText: label,
          hintText: hintText,
          border: const OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor ingresa un valor valido para : $label';
          }
          return null;
        },
      ),
    );
  }
}
