import 'package:flutter/material.dart';

class AppBottomSheet {
  Future<void> display(BuildContext context, Widget widget) {
    return showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25)
          )
        ),
        builder: (_){
          return widget;
        }
    );
  }
}