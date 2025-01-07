import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticket_pass/common/bloc/button/boton_state.dart';
import 'package:ticket_pass/common/bloc/button/boton_state_cubit.dart';
import 'package:ticket_pass/common/widgets/botones/boton_de_carga.dart';
import 'package:ticket_pass/domain/categorias/usecases/get_categorias_caso_de_uso.dart';
import 'package:ticket_pass/presentation/crearevento/widgets/categoria_select.dart';
import 'package:ticket_pass/common/widgets/entradatexto/entrada_texto.dart';
import 'package:ticket_pass/presentation/crearevento/widgets/fecha.dart';
import 'package:ticket_pass/presentation/crearevento/widgets/image_picker_widget.dart';
import 'package:ticket_pass/presentation/crearevento/widgets/precio.dart';
import 'package:ticket_pass/presentation/crearevento/widgets/total_entradas.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/configs/theme/app_colors.dart';
import '../../../domain/categorias/entity/categoria_entity.dart';
import '../../../domain/categorias/repository/categorias_repository.dart';
import '../../../domain/crearevento/entity/crear_evento_entity.dart';
import '../../../domain/crearevento/usescases/crear_evento_caso_de_uso.dart';
import '../../../service_locator.dart';
import '../../styles/app_styles.dart';

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
    _getCategorias();
  }

  Future<void> _getCategorias() async {
    final resultado = await sl<GetCategoriasCasoDeUso>().call();
    resultado.fold(
      (error) {
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
        appBar: AppBar(
          title: const Center(
            child: Text('Crear Evento'),
          ),
          backgroundColor: AppColors.primario,
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
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
                      : const Center(child: CircularProgressIndicator()),
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
                    listener: (context, state) {
                      if (state is BotonHechoState) {
                        var snackbar = const SnackBar(
                          content: Text("Evento Creado"),
                          behavior: SnackBarBehavior.floating,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackbar);
                        _formKey.currentState?.reset();
                        setState(() {
                          _imagenes = [];
                        });
                        _categoriaController.clear();
                        _nombreController.clear();
                        _descripcionController.clear();
                        _ubicacionController.clear();
                        _precioController.clear();
                        _fechaController.clear();
                        _totalEntradasController.clear();
                      }
                      if (state is BotonErrorState) {
                        var snackbar = SnackBar(
                          content: Text(state.msgError),
                          behavior: SnackBarBehavior.floating,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackbar);
                      }
                    },
                    child: Builder(builder: (context) {
                      return BotonDeCarga(
                        onPressed: () async {
                          if (_formKey.currentState?.validate() ?? false) {
                            if (_imagenes.isEmpty) {
                              var snackbar = const SnackBar(
                                content: Text(
                                    "Por favor seleccione al menos una imagen"),
                                behavior: SnackBarBehavior.floating,
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackbar);
                              return;
                            }
                            context.read<BotonStateCubit>().finalizar(
                                  casoDeUso: CrearEventoCasoDeUso(),
                                  params: CrearEventoEntity(
                                      categoriaId: _categoriaSeleccionada!.id,
                                      nombre: _nombreController.text,
                                      imagenes: _imagenes,
                                      fecha: Timestamp.fromDate(DateTime.parse(
                                          _fechaController.text)),
                                      descripcion: _descripcionController.text,
                                      ubicacion: _ubicacionController.text,
                                      precio:
                                          double.parse(_precioController.text),
                                      totalEntradas: double.parse(
                                          _totalEntradasController.text)),
                                );
                          }
                        },
                        contenido: Text('Crear Evento',
                            style: AppStyles.textoBotonesPrimarios),
                      );
                    }),
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
