import 'package:flutter/material.dart';

import '../../../core/configs/layaout/app_sizes.dart';
import '../../../domain/evento/entity/evento_entity.dart';
import '../tarjetas/evento_card.dart';

class GridviewEventos extends StatelessWidget {
  final List<EventoEntity> eventos;

  const GridviewEventos({
    required this.eventos,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double aspectRatio = AppSizes.getMaxWidth(context) > AppSizes.getMaxHeight(context) ? 2.2 : 1.1;

    return Expanded(
      child: GridView.builder(
        itemCount: eventos.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 0,
          childAspectRatio: aspectRatio,
        ),
        itemBuilder: (BuildContext context, int index) {
          return EventoCard(
            evento: eventos[index],
            width: 50,
            imageHeight: 100,
          );
        },
      ),
    );
  }
}
