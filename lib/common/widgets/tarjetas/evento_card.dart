import 'package:flutter/material.dart';
import 'package:ticket_pass/common/helper/imagenes/get_url_imagen.dart';
import 'package:ticket_pass/common/helper/navigator/app_navegacion.dart';
import 'package:ticket_pass/domain/evento/entity/evento_entity.dart';
import 'package:ticket_pass/presentation/detalle_evento/pages/detalle_evento.dart';


class EventoCard extends StatelessWidget {
  final EventoEntity evento;
  final double width; // Parámetro obligatorio para el ancho.
  final double imageHeight; // Parámetro obligatorio para la altura de la imagen.

  const EventoCard({
    required this.evento,
    required this.width, // Ancho obligatorio.
    required this.imageHeight, // Altura obligatoria de la imagen.
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppNavegacion.push(context, DetalleEntrada(entrada: evento));
      },
      child: Container(
        width: width, // Usa el ancho proporcionado (ya es obligatorio).
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen en la parte superior
            Container(
              height: imageHeight, // Usa la altura de imagen proporcionada (ya es obligatoria).
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    GetUrlImagen.getImagenEntradaUrl(evento.imagenes[0]),
                  ),
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
              ),
            ),
            // Nombre y ubicación
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Nombre en negrita
                Text(
                  evento.nombre,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 4),
                // Ubicación en texto normal
                Text(
                  evento.ubicacion ?? "Ubicación no disponible",
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                    overflow: TextOverflow.ellipsis,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}