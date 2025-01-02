import 'package:flutter/material.dart';

class BotonSimple extends StatelessWidget {
  final VoidCallback onPressed;
  final String titulo;
  final Widget? contenido;
  final double? altura;
  final double? anchura;

  const BotonSimple(
      {required this.onPressed,
      this.titulo = '',
      this.altura,
      this.anchura,
      this.contenido,
      super.key
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(
          altura ?? MediaQuery.of(context).size.width,
          anchura ?? 45
        )
      ),
      child: contenido ?? Text(
        titulo,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
