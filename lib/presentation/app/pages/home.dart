import 'package:flutter/material.dart';
import 'package:ticket_pass/presentation/app/widgets/buscador.dart';
import 'package:ticket_pass/presentation/styles/app_styles.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Buscador(),
            _categoriasText(),
          ],
        ),
      ),
    );
  }

  Widget _categoriasText(){
    return Text(
      "Categorías",
      style: AppStyles.h2,
    );
  }
}
