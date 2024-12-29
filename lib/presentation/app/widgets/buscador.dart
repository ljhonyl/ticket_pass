import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Buscador extends StatelessWidget {
  Buscador({super.key});

  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          top: 40,
          left: 8,
          right: 8
      ),
      child: TextField(
        controller: textEditingController,
        onChanged: (value){
          if (value.isEmpty) {
          } else {
          }
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(12),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50)
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50)
            ),
            hintText: 'Buscar'
        ),
      ),
    );
  }
}