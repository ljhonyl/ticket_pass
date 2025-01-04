import 'package:flutter/material.dart';
import 'package:ticket_pass/core/configs/theme/app_colors.dart';

class AppTheme {
  static final temaAplicacion = ThemeData(
    primaryColor: AppColors.primario,
    scaffoldBackgroundColor: AppColors.fondo,
    brightness: Brightness.light,
    fontFamily: 'CircularStd',
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: AppColors.fondo, // Fondo para Snackbar
      contentTextStyle: TextStyle(color: Colors.black),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.fondoSecundario, // Fondo del campo de entrada
      hintStyle: const TextStyle(
        color: AppColors.colorTextoTarjeta, // Color del texto de ayuda
        fontWeight: FontWeight.w400,
      ),
      contentPadding: const EdgeInsets.all(16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide.none,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primario,
        elevation: 0,
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
      ),
    ),
    cardTheme: CardTheme(
      color: AppColors.fondo, // Fondo de las tarjetas
      elevation: 1, // Sombra de las tarjetas
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(
          color: AppColors.fondoSecundario, // Borde de las tarjetas
          width: 1,
        ),
      ),
    ),
  );
}
