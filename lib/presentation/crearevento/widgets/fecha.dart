import 'package:flutter/material.dart';

class Fecha extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  const Fecha({
    super.key,
    required this.controller,
    this.hintText = "Fecha y Hora",
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: hintText,
          border: OutlineInputBorder(),
        ),
        onTap: () async {
          // Ocultar el teclado cuando el usuario toque el campo de fecha y hora
          FocusScope.of(context).requestFocus(FocusNode());

          // Fecha
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2024),
            lastDate: DateTime(2101),
          );

          //Cuando se ha seleccionado una fecha permitimos seleccionar una hora
          if (pickedDate != null) {
            TimeOfDay? pickedTime = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.fromDateTime(pickedDate),
            );

            if (pickedTime != null) {
              DateTime finalDateTime = DateTime(
                pickedDate.year,
                pickedDate.month,
                pickedDate.day,
                pickedTime.hour,
                pickedTime.minute,
              );

              // Formatear la fecha y hora seleccionadas en el formato adecuado
              controller.text = '${finalDateTime.toLocal()}'.split(' ')[0] + ' ${pickedTime.format(context)}';
            }
          }
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor ingresa una fecha y hora';
          }
          return null;
        },
      ),
    );
  }
}
