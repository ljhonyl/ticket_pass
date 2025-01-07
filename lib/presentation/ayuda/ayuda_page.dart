import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:ticket_pass/core/configs/theme/app_colors.dart';

class AyudaPage extends StatelessWidget {
  final String pdfUrl;

  AyudaPage({
    required this.pdfUrl,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ayuda'),
        backgroundColor: AppColors.primario,
      ),
      body: SfPdfViewer.network(pdfUrl),
    );
  }
}
