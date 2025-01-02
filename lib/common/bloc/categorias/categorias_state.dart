import 'package:ticket_pass/domain/categorias/entity/categoria_entity.dart';

abstract class CategoriasState{}

class CategoriasCargando extends CategoriasState{}

class CategoriasCargadas extends CategoriasState{
  final List<CategoriaEntity> categorias;

  CategoriasCargadas({required this.categorias});
}

class CategoriasError extends CategoriasState{}