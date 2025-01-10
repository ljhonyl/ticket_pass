import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:ticket_pass/core/configs/theme/app_colors.dart';
import 'package:ticket_pass/domain/misentradas/entity/mi_entrada_entity.dart';

class CodigoQrPage extends StatelessWidget {
  final MiEntradaEntity entrada;

  const CodigoQrPage({
    required this.entrada,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Escanea tu entrada')),
        backgroundColor: AppColors.primario,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: QrImageView(
          data: entrada.numeroEntrada,
          version: QrVersions.auto,
          size: 200.0,
        ),
      ),
    );
  }
}