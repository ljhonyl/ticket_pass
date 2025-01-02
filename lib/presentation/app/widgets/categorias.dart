import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticket_pass/common/bloc/categorias/categorias_cubit.dart';
import 'package:ticket_pass/common/bloc/categorias/categorias_state.dart';
import 'package:ticket_pass/common/helper/navigator/app_navegacion.dart';
import 'package:ticket_pass/domain/categorias/entity/categoria_entity.dart';
import 'package:ticket_pass/presentation/entradas_por_categoria/pages/entradas_por_categoria.dart';

class Categorias extends StatelessWidget {
  const Categorias({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoriasCubit()..mostrarCategorias(),
      child: BlocBuilder<CategoriasCubit, CategoriasState>(
          builder: (context, state){
            if(state is CategoriasCargando){
              return CircularProgressIndicator();
            }
            if(state is CategoriasCargadas){
              return Column(
                children: [
                  _verTodoText(context),
                  _categoriasListView(state.categorias)
                ],
              );
            }
            return Container();
          },
      ),
    );
  }

  Widget _verTodoText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 16
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Categorias',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16
            ),
          ),
          GestureDetector(
            onTap: (){
              //AppNavigator.push(context, const AllCategoriesPage());
            },
            child: const Text(
              'Ver todo',
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _categoriasListView(List<CategoriaEntity> categorias) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemBuilder: (context, index) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: (){
                  AppNavegacion.push(
                      context,
                      EntradasPorCategoria(categoria: categorias[index])
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.blueAccent.withOpacity(0.2), // Color de fondo de la burbuja
                    borderRadius: BorderRadius.circular(20), // Borde redondeado
                  ),
                  child: Text(
                    categorias[index].nombre,
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
        separatorBuilder: (context, index) => const SizedBox(width: 15),
        itemCount: categorias.length,
      ),
    );
  }

}
