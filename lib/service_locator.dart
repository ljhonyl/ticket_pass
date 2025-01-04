import 'package:get_it/get_it.dart';
import 'package:ticket_pass/data/auth/repository/inicio_sesion_repository_impl.dart';
import 'package:ticket_pass/data/auth/source/inicio_sesion_firebase_service.dart';
import 'package:ticket_pass/data/cancelarcompra/repository/cancelar_compra_repository_impl.dart';
import 'package:ticket_pass/data/cancelarcompra/service/cancelar_compra_firebase_service.dart';
import 'package:ticket_pass/data/categorias/repository/categorias_repository_impl.dart';
import 'package:ticket_pass/data/categorias/source/categorias_firebase_service.dart';
import 'package:ticket_pass/data/compra/repository/compra_repository_impl.dart';
import 'package:ticket_pass/data/compra/source/compra_firebase_service.dart';
import 'package:ticket_pass/data/crearevento/repository/crear_evento_repository_impl.dart';
import 'package:ticket_pass/data/crearevento/service/crear_evento_firebase_service.dart';
import 'package:ticket_pass/data/evento/repository/evento_repository_impl.dart';
import 'package:ticket_pass/data/evento/source/evento_firebase_service.dart';
import 'package:ticket_pass/data/misentradas/repository/mis_entradas_repository_impl.dart';
import 'package:ticket_pass/data/misentradas/service/mis_entradas_firebase_service.dart';
import 'package:ticket_pass/data/miseventos/repository/mis_eventos_repository_impl.dart';
import 'package:ticket_pass/data/miseventos/source/mis_eventos_firebase_service.dart';
import 'package:ticket_pass/data/venta/repository/venta_repository_impl.dart';
import 'package:ticket_pass/data/venta/source/venta_firebase_service.dart';
import 'package:ticket_pass/domain/auth/usecases/iniciar_sesion_caso_de_uso.dart';
import 'package:ticket_pass/domain/auth/usecases/registro_caso_de_uso.dart';
import 'package:ticket_pass/domain/auth/repository/inicio_sesion_repository.dart';
import 'package:ticket_pass/domain/auth/usecases/restablecer_password_caso_de_uso.dart';
import 'package:ticket_pass/domain/auth/usecases/sesion_en_curso_caso_de_uso.dart';
import 'package:ticket_pass/domain/cancelarcompra/repository/cancelar_compra_repository.dart';
import 'package:ticket_pass/domain/cancelarcompra/usecases/cancelar_compra_caso_de_uso.dart';
import 'package:ticket_pass/domain/categorias/repository/categorias_repository.dart';
import 'package:ticket_pass/domain/categorias/usecases/get_categorias_caso_de_uso.dart';
import 'package:ticket_pass/data/crearevento/service/img_bb_service.dart';
import 'package:ticket_pass/domain/compra/repository/compra_repository.dart';
import 'package:ticket_pass/domain/compra/usescases/compra_caso_de_uso.dart';
import 'package:ticket_pass/domain/compra/usescases/get_entradas_compradas_caso_de_uso.dart';
import 'package:ticket_pass/domain/crearevento/repository/crear_evento_repository.dart';
import 'package:ticket_pass/domain/crearevento/usescases/crear_evento_caso_de_uso.dart';
import 'package:ticket_pass/domain/evento/repository/evento_repository.dart';
import 'package:ticket_pass/domain/evento/usescases/get_evento_caso_de_uso.dart';
import 'package:ticket_pass/domain/evento/usescases/get_evento_por_categoria_caso_de_uso.dart';
import 'package:ticket_pass/domain/evento/usescases/get_evento_por_nombre_caso_de_uso.dart';
import 'package:ticket_pass/domain/evento/usescases/get_proximamente_caso_de_uso.dart';
import 'package:ticket_pass/domain/misentradas/repository/mis_entradas_repository.dart';
import 'package:ticket_pass/domain/misentradas/usescases/get_mis_compras_caso_de_uso.dart';
import 'package:ticket_pass/domain/misventos/usescases/get_mis_eventos_caso_de_uso.dart';
import 'package:ticket_pass/domain/venta/repository/venta_repository.dart';
import 'package:ticket_pass/domain/venta/usescases/get_entradas_en_venta_caso_de_uso.dart';

import 'domain/misventos/repository/mis_eventos_repository.dart';

final sl = GetIt.instance;

Future<void> iniciarDependencias() async {
  //  ----------------- Inicio de Sesión  -----------------
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

  // ----------------- Home -----------------
  sl.registerSingleton<CategoriasRepository>(
      CategoriasRepositoryImpl()
  );

  sl.registerSingleton<CategoriasFirebaseService>(
      CategoriasFirebaseServiceImpl()
  );

  sl.registerSingleton<GetCategoriasCasoDeUso>(
      GetCategoriasCasoDeUso()
  );

  sl.registerSingleton<EventoFirebaseService>(
      EventoFirebaseServiceImpl()
  );

  sl.registerSingleton<EventoRepository>(
      EventoRepositoryImpl()
  );

  sl.registerSingleton<GetProximamenteCasoDeUso>(
      GetProximamenteCasoDeUso()
  );

  sl.registerSingleton<GetEventoCasoDeUso>(
      GetEventoCasoDeUso()
  );

  sl.registerSingleton<GetEventoPorCategoriaCasoDeUso>(
      GetEventoPorCategoriaCasoDeUso()
  );

  sl.registerSingleton<GetEventoPorNombreCasoDeUso>(
      GetEventoPorNombreCasoDeUso()
  );


  //  ----------------- Venta -----------------
  sl.registerSingleton<VentaFirebaseService>(
      VentaFirebaseServiceImpl()
  );

  sl.registerSingleton<VentaRepository>(
      VentaRepositoryImpl()
  );

  sl.registerSingleton<GetEntradasEnVentaCasoDeUso>(
      GetEntradasEnVentaCasoDeUso()
  );


  //  ----------------- Compra  -----------------
  sl.registerSingleton<CompraFirebaseService>(
      CompraFirebaseServiceImpl()
  );

  sl.registerSingleton<CompraRepository>(
      CompraRepositoryImpl()
  );

  sl.registerSingleton<CompraCasoDeUso>(
      CompraCasoDeUso()
  );

  // ----------------- Cancelar Compra -----------------
  sl.registerSingleton<CancelarCompraFirebaseService>(
      CancelarCompraFirebaseServiceImpl()
  );

  sl.registerSingleton<CancelarCompraRepository>(
      CancelarCompraRepositoryImpl()
  );

  sl.registerSingleton<CancelarCompraCasoDeUso>(
      CancelarCompraCasoDeUso()
  );

  // ----------------- Resumen de Compra -----------------
  sl.registerSingleton<GetEntradasCompradasCasoDeUso>(
      GetEntradasCompradasCasoDeUso()
  );

  // ----------------- Crear Evento -----------------
  sl.registerSingleton<ImgBBService>(
      ImgBBService()
  );

  sl.registerSingleton<CrearEventoFirebaseService>(
      CrearEventoFirebaseServiceImpl()
  );

  sl.registerSingleton<CrearEventoRepository>(
      CrearEventoRepositoryImpl()
  );

  sl.registerSingleton<CrearEventoCasoDeUso>(
      CrearEventoCasoDeUso()
  );

  // Mis Eventos
  sl.registerSingleton<MisEventosFirebaseService>(
      MisEventosFirebaseServiceImpl()
  );

  sl.registerSingleton<MisEventosRepository>(
      MisEventosRepositoryImpl()
  );

  sl.registerSingleton<GetMisEventosCasoDeUso>(
      GetMisEventosCasoDeUso()
  );

  // Mis compras

  sl.registerSingleton<MisEntradasFirebaseService>(
      MisEntradasFirebaseServiceImpl()
  );

  sl.registerSingleton<MisEntradasRepository>(
      MisEntradasRepositoryImpl()
  );

  sl.registerSingleton<GetMisComprasCasoDeUso>(
      GetMisComprasCasoDeUso()
  );
}