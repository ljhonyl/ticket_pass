import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:ticket_pass/core/configs/theme/app_theme.dart';
import 'package:ticket_pass/core/url/app_url.dart';
import 'package:ticket_pass/presentation/splash/bloc/splash_cubit.dart';
import 'package:ticket_pass/presentation/splash/splash_page.dart';
import 'package:ticket_pass/service_locator.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await iniciarDependencias();
  await configurarMenuStripe();
  runApp(const MyApp());
}

Future<void> configurarMenuStripe()async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = AppUrl.stripepk;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashCubit()..iniciarApp(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: AppTheme.temaAplicacion,
        debugShowCheckedModeBanner: false,
        home: const SplashPage(),
      ),
    );
  }
}

