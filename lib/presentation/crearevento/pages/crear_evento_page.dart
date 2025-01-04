import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticket_pass/common/bloc/button/boton_state.dart';
import 'package:ticket_pass/common/bloc/button/boton_state_cubit.dart';
import 'package:ticket_pass/common/widgets/botones/boton_de_carga.dart';
import 'package:ticket_pass/presentation/crearevento/widgets/categoria_select.dart';
import 'package:ticket_pass/presentation/crearevento/widgets/entrada_texto.dart';
import 'package:ticket_pass/presentation/crearevento/widgets/fecha.dart';
import 'package:ticket_pass/presentation/crearevento/widgets/image_picker_widget.dart';
import 'package:ticket_pass/presentation/crearevento/widgets/precio.dart';
import 'package:ticket_pass/presentation/crearevento/widgets/total_entradas.dart';
import 'package:image_picker/image_picker.dart';
import '../../../domain/categorias/entity/categoria_entity.dart';
import '../../../domain/categorias/repository/categorias_repository.dart';
import '../../../domain/crearevento/entity/crear_evento_entity.dart';
import '../../../domain/crearevento/usescases/crear_evento_caso_de_uso.dart';
import '../../../service_locator.dart';

class CrearEventoPage extends StatefulWidget {
  const CrearEventoPage({super.key});

  @override
  _CrearEventoPageState createState() => _CrearEventoPageState();
}

class _CrearEventoPageState extends State<CrearEventoPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _categoriaController = TextEditingController();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _precioController = TextEditingController();
  final TextEditingController _fechaController = TextEditingController();
  final TextEditingController _totalEntradasController =
      TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();
  final TextEditingController _ubicacionController = TextEditingController();

  List<XFile> _imagenes = [];
  List<CategoriaEntity> _categorias = [];
  CategoriaEntity? _categoriaSeleccionada;

  @override
  void initState() {
    super.initState();
    // Llamar al backend para obtener las categorías
    _getCategorias();
  }

  // Llamada al backend para obtener las categorías
  Future<void> _getCategorias() async {
    final resultado = await sl<CategoriasRepository>().getCategorias();
    resultado.fold(
      (error) {
        // Manejo de error si no se obtienen las categorías
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error)));
      },
      (categorias) {
        setState(() {
          _categorias = categorias;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => BotonStateCubit()),
      ],
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _categorias.isNotEmpty
                      ? CategoriaSelect(
                          controller: _categoriaController,
                          label: "Categorías",
                          categorias: _categorias,
                          selectedCategory: _categoriaSeleccionada,
                          onChanged: (CategoriaEntity? value) {
                            setState(() {
                              _categoriaSeleccionada = value;
                            });
                          },
                        )
                      : const CircularProgressIndicator(),
                  EntradaTexto(controller: _nombreController, label: 'nombre'),
                  EntradaTexto(
                    controller: _descripcionController,
                    label: 'Descripción',
                  ),
                  EntradaTexto(
                    controller: _ubicacionController,
                    label: 'Ubicación',
                    hintText: "Calle de ejemplo, Madrid, ES",
                  ),
                  Precio(controller: _precioController),
                  Fecha(controller: _fechaController),
                  TotalEntradas(controller: _totalEntradasController),
                  ImagePickerWidget(
                    images: _imagenes,
                    onImagesChanged: (images) {
                      setState(() {
                        _imagenes = images;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  BlocListener<BotonStateCubit, BotonState>(
                    listener: (context,state){
                      if(state is BotonHechoState){
                        print("CONSEGUIDO");
                      }
                      if(state is BotonErrorState){
                        print("ERROR");
                      }
                      print("DEFAULT");
                    },
                    child: Builder(
                      builder: (context) {
                        return BotonDeCarga(
                          onPressed: () async {
                            if (_formKey.currentState?.validate() ?? false) {
                              if (_imagenes.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'Debes seleccionar al menos una imagen')),
                                );
                                return;
                              }
                              print(_fechaController.text);
                              context.read<BotonStateCubit>()..finalizar(
                                    casoDeUso: CrearEventoCasoDeUso(),
                                    params: CrearEventoEntity(
                                        categoriaId: _categoriaSeleccionada!.id,
                                        nombre: _nombreController.text,
                                        imagenes: _imagenes,
                                        fecha: Timestamp.fromDate(
                                            DateTime.parse(_fechaController.text)),
                                        descripcion: _descripcionController.text,
                                        ubicacion: _ubicacionController.text,
                                        precio: double.parse(_precioController.text),
                                        totalEntradas: double.parse(
                                            _totalEntradasController.text)),
                                  );
                            }
                          },
                          contenido: const Text('Crear Evento'),
                        );
                      }
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
