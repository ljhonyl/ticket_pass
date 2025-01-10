import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ticket_pass/domain/cuenta/entity/cuenta_entity.dart';
import 'package:ticket_pass/domain/permisos/usescases/pedir_permisos_caso_de_uso.dart';
import 'package:ticket_pass/presentation/cuenta/bloc/imagen_cubit.dart';

import '../../../common/helper/imagenes/get_url_imagen.dart';
import '../../../service_locator.dart';

class DatosCuenta extends StatelessWidget {
  final CuentaEntity cuenta;
  const DatosCuenta({required this.cuenta, super.key});

  @override
  Widget build(BuildContext context) {
    var imagen = '';
    if (cuenta.imagen.isNotEmpty) {
      imagen = cuenta.imagen;
    } else {
      imagen = GetUrlImagen.getImagenUsuarioUrl();
    }
    return Row(
      children: [
        BlocProvider(
          create: (context) => ImagenCubit(imagen: imagen),
          child: BlocBuilder<ImagenCubit, dynamic>(
            builder: (context, state) => GestureDetector(
              onTap: () async {
                final permisoConcedido = await sl<PedirPermisosCasoDeUso>().call();

                permisoConcedido.fold(
                      (error) {
                    mostrarSnackbar(context, error);
                  },
                      (data) async {
                    final XFile? nuevaImagen = await sl<ImagePicker>().pickImage(
                      source: ImageSource.gallery,
                    );

                    if (nuevaImagen != null) {
                      final result = await context.read<ImagenCubit>().setImagen(nuevaImagen);

                      result.fold(
                            (error) {
                          mostrarSnackbar(context, error.toString());
                        },
                            (success) {
                          mostrarSnackbar(context, success.toString());
                        },
                      );
                    }
                  },
                );
              },
              child: CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(state),
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${cuenta.nombre} ${cuenta.apellidos}',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text(
              cuenta.email,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ],
    );
  }

  void mostrarSnackbar(BuildContext context, String mensaje) {
    var snackbar = SnackBar(
      content: Text(mensaje),
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
}
