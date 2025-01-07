import 'dart:convert';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:dartz/dartz.dart';
import 'package:ticket_pass/core/url/app_url.dart';
import 'package:ticket_pass/data/compra/models/pago_model.dart';

class StripeService {
  StripeService._();

  static final StripeService instance = StripeService._();

  Future<Either<String, String>> pagar(PagoModel pago) async {
    try {
      final respuesta = await crearPago(pago);

      return await respuesta.fold(
        (error) => Left(error),
        (data) async {
          try {
            await Stripe.instance.initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                paymentIntentClientSecret: data,
                merchantDisplayName: "Ticket Pass",
              ),
            );
          } catch (e) {
            return Left("Error al inicializar la hoja de pago: $e");
          }
          return await iniciarPago();
        },
      );
    } catch (e) {
      return const Left("Ocurrió un problema con el pago, compra cancelada");
    }
  }

  Future<Either<String, String>> crearPago(PagoModel pago) async {
    try {
      final response = await http.post(
        AppUrl.stripeUrl,
        headers: {
          "Authorization": "Bearer ${AppUrl.stripesk}",
          "Content-Type": "application/x-www-form-urlencoded",
        },
        body: pago.toMap().map((key, value) => MapEntry(key, value.toString())),
      );

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        final clientSecret = body['client_secret'];

        if (clientSecret != null) {
          return Right(clientSecret);
        } else {
          return const Left(
              "Ocurrio un error al comunicarse con el pago, intentelo de nuevo más tarde");
        }
      } else {
        final error = jsonDecode(response.body)['error']?['message'] ??
            "Error desconocido";
        return Left("Fallo al intentar pagar: $error");
      }
    } catch (e) {
      return Left("Fallo al intentar crear el pago: $e");
    }
  }

  Future<Either<String, String>> iniciarPago() async {
    try {
      await Stripe.instance.presentPaymentSheet();
      return const Right("Pago completado exitosamente.");
    } catch (e) {
      return Left("Error al presentar la hoja de pago: $e");
    }
  }
}
