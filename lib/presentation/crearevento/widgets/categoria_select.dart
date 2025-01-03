import 'package:flutter/material.dart';

import '../../../domain/categorias/entity/categoria_entity.dart';

class CategoriaSelect extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hintText;
  final List<CategoriaEntity> categorias;
  final CategoriaEntity? selectedCategory;
  final void Function(CategoriaEntity?)? onChanged;

  const CategoriaSelect({
    super.key,
    required this.controller,
    required this.label,
    this.hintText = "",
    required this.categorias,
    this.selectedCategory,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<CategoriaEntity>(
        value: selectedCategory,
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: label,
          hintText: hintText,
          border: OutlineInputBorder(),
        ),
        items: categorias.map((categoria) {
          return DropdownMenuItem<CategoriaEntity>(
            value: categoria,
            child: Text(categoria.nombre),
          );
        }).toList(),
        validator: (value) {
          if (value == null) {
            return 'Por favor selecciona una categoría';
          }
          return null;
        },
      ),
    );
  }
}
