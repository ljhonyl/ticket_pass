import 'package:flutter/material.dart';

import '../../../domain/evento/entity/evento_entity.dart';
import '../tarjetas/evento_card.dart';

class GridviewEventos extends StatelessWidget {
  final List<EventoEntity> eventos;


  const GridviewEventos({
    required this.eventos,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        itemCount: eventos.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 0,
            childAspectRatio: 1.1
        ),
        itemBuilder: (BuildContext context, int index) {
          return EventoCard(
              evento: eventos[index], width: 50, imageHeight: 100);
        },
      ),
    );
  }
}

