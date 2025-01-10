import 'package:flutter/material.dart';
import 'package:ticket_pass/core/configs/layaout/app_sizes.dart';

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
      padding: EdgeInsets.symmetric(vertical: AppSizes.getMaxHeight(context)*0.01),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: hintText,
          border: const OutlineInputBorder(),
        ),
        onTap: () async {
          FocusScope.of(context).requestFocus(FocusNode());

          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2024),
            lastDate: DateTime(2101),
          );

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

              controller.text =
                  '${'${finalDateTime.toLocal()}'.split(' ')[0]} ${pickedTime.format(context)}';
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
