import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ListaImagenes extends StatelessWidget {
  final List<String> imagenes;
  const ListaImagenes({required this.imagenes, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Container(
              width: 250,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill, image: NetworkImage(imagenes[index]))),
            );
          },
          separatorBuilder: (context, index) => const Gap(10),
          itemCount: imagenes.length),
    );
  }
}
