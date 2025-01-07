import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticket_pass/common/bloc/categorias/categorias_state.dart';
import 'package:ticket_pass/domain/categorias/usecases/get_categorias_caso_de_uso.dart';

import '../../../service_locator.dart';

class CategoriasCubit extends Cubit<CategoriasState> {
  CategoriasCubit() : super(CategoriasCargando());

  Future<void> mostrarCategorias() async {
    var categorias = await sl<GetCategoriasCasoDeUso>().call();

    categorias.fold((error) {
      emit(CategoriasError());
    }, (data) {
      emit(CategoriasCargadas(categorias: data));
    });
  }
}
