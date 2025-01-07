import 'package:flutter/material.dart';

class TotalEntradas extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  const TotalEntradas({
    super.key,
    required this.controller,
    this.hintText = "100",
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: "Total entradas a la venta",
          hintText: hintText,
          border: const OutlineInputBorder(),
        ),
        validator: (value) {
          var msg = 'Por favor ingresa un numero válido';
          if (value == null || value.isEmpty) {
            return msg;
          }
          final number = int.tryParse(value);
          if (number == null || number <= 0) {
            return msg;
          }
          return null;
        },
      ),
    );
  }
}
