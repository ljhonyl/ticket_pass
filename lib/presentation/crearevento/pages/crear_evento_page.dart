import 'package:flutter/material.dart';
import 'package:ticket_pass/presentation/crearevento/widgets/categoria_select.dart';
import 'package:ticket_pass/presentation/crearevento/widgets/entrada_texto.dart';
import 'package:ticket_pass/presentation/crearevento/widgets/fecha.dart';
import 'package:ticket_pass/presentation/crearevento/widgets/image_picker_widget.dart';
import 'package:ticket_pass/presentation/crearevento/widgets/precio.dart';
import 'package:ticket_pass/presentation/crearevento/widgets/total_entradas.dart';
import 'package:image_picker/image_picker.dart';

import '../../../domain/categorias/entity/categoria_entity.dart';
import '../../../domain/categorias/repository/categorias_repository.dart';
import '../../../service_locator.dart';

class CrearEventoPage extends StatefulWidget {
  const CrearEventoPage({super.key});

  @override
  _CrearEventoPageState createState() => _CrearEventoPageState();
}

class _CrearEventoPageState extends State<CrearEventoPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _categoriaController = TextEditingController();
  final TextEditingController _precioController = TextEditingController();
  final TextEditingController _fechaController = TextEditingController();
  final TextEditingController _totalEntradasController = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();
  final TextEditingController _ubicacionController = TextEditingController();

  List<XFile> _selectedImages = [];
  List<CategoriaEntity> _categorias = [];
  CategoriaEntity? _selectedCategory;

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
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Crear Evento"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
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
            selectedCategory: _selectedCategory,
            onChanged: (CategoriaEntity? value) {
              setState(() {
                _selectedCategory = value;
              });
            },
          )
                : const CircularProgressIndicator(),
              // Descripción del evento
              EntradaTexto(
                controller: _descripcionController,
                label: 'Descripción',
              ),
              // Ubicación del evento
              EntradaTexto(
                controller: _ubicacionController,
                label: 'Ubicación',
                hintText: "Calle de ejemplo, Madrid, ES",
              ),
              // Precio
              Precio(controller: _precioController),
              // Fecha
              Fecha(controller: _fechaController),
              // Total Entradas
              TotalEntradas(controller: _totalEntradasController),
              // Selector de Imágenes
              ImagePickerWidget(
                images: _selectedImages,
                onImagesChanged: (images) {
                  setState(() {
                    _selectedImages = images;
                  });
                },
              ),
              const SizedBox(height: 20),
              // Botón para enviar el formulario
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    print(_selectedCategory!.id);
                    print(_descripcionController.text);
                    print(_ubicacionController.text);
                    print(_precioController.text);
                    print(_fechaController.text);
                    print(_totalEntradasController.text);
                  }
                },
                child: const Text('Crear Evento'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
