import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticket_pass/domain/auth/usecases/sesion_en_curso_caso_de_uso.dart';
import 'package:ticket_pass/presentation/splash/bloc/splash_state.dart';

import '../../../service_locator.dart';

class SplashCubit extends Cubit<SplashState>{
  SplashCubit() : super(MostrarSplash());

  void iniciarApp() async {
    await Future.delayed(const Duration(seconds: 2));
    var sesionYaIniciada = await sl<SesionEnCursoCasoDeUso>().call();
    if(sesionYaIniciada){
      emit(SesionIniciada());
    }
    else{
      emit(SesionNoIniciada());
    }
  }
}