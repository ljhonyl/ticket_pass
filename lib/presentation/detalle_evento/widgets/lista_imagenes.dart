import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ticket_pass/common/helper/imagenes/get_url_imagen.dart';

class ListaImagenes extends StatelessWidget {
  final List<String> imagenes;
  const ListaImagenes({
    required this.imagenes,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context,index){
            return Container(
              width: 250,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(
                   GetUrlImagen.getImagenEntradaUrl(imagenes[index])
                  )
                )
              ),
            );
          },
          separatorBuilder: (context,index) => const Gap(10),
          itemCount: imagenes.length
      ),
    );
  }
}
