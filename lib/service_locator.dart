import 'package:get_it/get_it.dart';
import 'package:ticket_pass/data/auth/repository/inicio_sesion_repository_impl.dart';
import 'package:ticket_pass/data/auth/source/inicio_sesion_firebase_service.dart';
import 'package:ticket_pass/data/categorias/repository/categorias_repository_impl.dart';
import 'package:ticket_pass/data/categorias/source/categorias_firebase_service.dart';
import 'package:ticket_pass/domain/auth/usecases/iniciar_sesion_caso_de_uso.dart';
import 'package:ticket_pass/domain/auth/usecases/registro_caso_de_uso.dart';
import 'package:ticket_pass/domain/auth/repository/inicio_sesion_repository.dart';
import 'package:ticket_pass/domain/auth/usecases/restablecer_password_caso_de_uso.dart';
import 'package:ticket_pass/domain/auth/usecases/sesion_en_curso_caso_de_uso.dart';
import 'package:ticket_pass/domain/categorias/repository/categorias_repository.dart';

final sl = GetIt.instance;

Future<void> iniciarDependencias() async {
  // Inicio de Sesion
  sl.registerSingleton<InicioSesionFirebaseService>(
      InicioSesionFirebaseServiceImpl()
  );

  sl.registerSingleton<InicioSesionRepository>(
      InicioSesionRepositoryImpl()
  );

  sl.registerSingleton<RegistroCasoDeUso>(
      RegistroCasoDeUso()
  );

  sl.registerSingleton<IniciarSesionCasoDeUso>(
      IniciarSesionCasoDeUso()
  );

  sl.registerSingleton<RestablecerPasswordCasoDeUso>(
      RestablecerPasswordCasoDeUso()
  );

  sl.registerSingleton<SesionEnCursoCasoDeUso>(
      SesionEnCursoCasoDeUso()
  );

  // Home
  sl.registerSingleton<CategoriasRepository>(
      CategoriasRepositoryImpl()
  );
}