import 'package:flutter/material.dart';
import 'package:ticket_pass/core/configs/layaout/app_sizes.dart';

class Precio extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  const Precio({
    super.key,
    required this.controller,
    this.hintText = "55.55",
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppSizes.getMaxHeight(context)*0.01),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: "Precio",
          hintText: hintText,
          border: const OutlineInputBorder(),
        ),
        validator: (value) {
          var msg = 'Por favor ingresa un numero válido';
          if (value == null || value.isEmpty) {
            return msg;
          }
          final number = double.tryParse(value);
          if (number == null || number <= 0) {
            return msg;
          }
          return null;
        },
      ),
    );
  }
}
