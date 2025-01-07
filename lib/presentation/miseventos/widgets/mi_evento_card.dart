import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ticket_pass/common/helper/navigator/app_navegacion.dart';
import 'package:ticket_pass/domain/misventos/entity/mi_evento_entity.dart';
import 'package:ticket_pass/presentation/misentradas/pages/mis_entradas_page.dart';

class MiEventoCard extends StatelessWidget {
  final MiEventoEntity evento;

  const MiEventoCard({
    required this.evento,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    String fechaEvento = DateFormat('dd-MM-yyyy HH:mm').format(
      evento.fechaEvento.toDate(),
    );

    return GestureDetector(
      onTap: () {
        AppNavegacion.push(context,
            MisEntradasPage(eventoId: evento.eventoId, imagen: evento.imagen));
      },
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.all(8),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              evento.imagen.isNotEmpty
                  ? Image.network(
                      evento.imagen,
                      height: 150,
                      width: 900,
                      fit: BoxFit.cover,
                    )
                  : Container(
                      height: 150,
                      color: Colors.grey[300],
                      child: const Center(
                        child: Icon(Icons.image, size: 50, color: Colors.grey),
                      ),
                    ),
              const SizedBox(height: 12),
              Text(
                evento.nombreEvento,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Fecha del evento: $fechaEvento',
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
