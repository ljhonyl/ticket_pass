import 'package:flutter/material.dart';

class AppNavegacion {
  static void push(BuildContext context, Widget pagina){
    Navigator.push(context, MaterialPageRoute(builder: (context) => pagina));
  }

  static void pushReplacement(BuildContext context, Widget pagina){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => pagina));
  }

  static void pushAndRemoveUntil(BuildContext context, Widget page, RoutePredicate predicate) {
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => page), predicate,);
  }
}