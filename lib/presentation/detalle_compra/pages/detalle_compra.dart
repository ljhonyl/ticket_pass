import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:ticket_pass/common/bloc/button/boton_state_cubit.dart';
import 'package:ticket_pass/common/widgets/tarjetas/evento_card.dart';
import 'package:ticket_pass/domain/compra/entity/peticion_compra_entity.dart';
import 'package:ticket_pass/domain/compra/entity/peticion_entrada_compra_entity.dart';
import 'package:ticket_pass/domain/evento/entity/evento_entity.dart';
import 'package:ticket_pass/domain/venta/entity/entrada_en_venta_entity.dart';
import 'package:ticket_pass/presentation/detalle_compra/widgets/finalizar_compra.dart';
import '../../../core/configs/theme/app_colors.dart';
import '../../../domain/cancelarcompra/entity/entrada_cancelada_entity.dart';
import '../../../domain/cancelarcompra/usecases/cancelar_compra_caso_de_uso.dart';

class DetalleCompra extends StatefulWidget {
  final EventoEntity evento;
  final List<EntradaEnVentaEntity> entradas;
  final num precioTotal;

  DetalleCompra({required this.evento, required this.entradas, required this.precioTotal});

  @override
  _DetalleCompraState createState() => _DetalleCompraState();
}

class _DetalleCompraState extends State<DetalleCompra> with WidgetsBindingObserver {
  final CancelarCompraCasoDeUso cancelarCompraCasoDeUso = CancelarCompraCasoDeUso();
  bool _cancelacionRealizada = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this); // Observamos cambios en el ciclo de vida
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this); // Dejamos de observar
    super.dispose();
  }

  Future<void> cancelarCompra() async {
    if (_cancelacionRealizada) return; // Evitamos múltiples ejecuciones
    setState(() {
      _cancelacionRealizada = true;
    });

    List<EntradaCanceladaEntity> entradas = widget.entradas.map((entrada) {
      return EntradaCanceladaEntity(
        eventoId: widget.evento.id,
        numeroEntrada: entrada.numeroEntrada,
      );
    }).toList();

    final result = await cancelarCompraCasoDeUso.call(params: entradas);
    result.fold(
          (l) => print("Error al cancelar la compra: $l"),
          (r) => print("Compra cancelada y entradas liberadas"),
    );
  }

  Future<void> cancelarCompraYSalir() async {
    await cancelarCompra(); // Cancela la compra
    if (mounted) {
      Navigator.pop(context); // Redirige a la pantalla anterior
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      cancelarCompraYSalir(); // Cancela y navega hacia atrás si la app se minimiza
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    String fechaEvento = DateFormat('dd-MM-yyyy HH:mm').format(
      widget.evento.fecha.toDate(),
    );
    return BlocProvider(
      create: (context) => BotonStateCubit(),
      child: PopScope(
        onPopInvokedWithResult: (bool canPop, dynamic result) async {
          if (canPop) {
            await cancelarCompra();
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Center(
              child: Text('Compra'),
            ),
            backgroundColor: AppColors.primario,
            automaticallyImplyLeading: false,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  EventoCard(
                    evento: widget.evento,
                    width: MediaQuery.of(context).size.width,
                    imageHeight: 140,
                  ),
                  const Gap(10),
                  _filaText(label: "Fecha de realizacion", dato: fechaEvento),
                  const Gap(16),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Detalles del precio",),
                    ],
                  ),
                  _filaText(label: "Nº de entradas:", dato: widget.entradas.length.toString()),
                  _filaText(label: "Precio por entrada:", dato: "${widget.evento.precio.toStringAsFixed(2)}€"),
                  _filaText(label: "Precio total:", dato: "${widget.precioTotal.toStringAsFixed(2)}€"),
                  const Gap(16),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Entradas",)
                    ],
                  ),
                  _entradas(),
                ],
              ),
            ),
          ),
          bottomNavigationBar: FinalizarCompra(
            compra: PeticionCompraEntity(
                eventoId: widget.evento.id,
                nombreEvento: widget.evento.nombre,
                cantidad: widget.entradas.length,
                precioTotal: widget.precioTotal,
                entradas: _convertirEntradas(widget.entradas),
                fechaEvento: widget.evento.fecha,
                imagen: widget.evento.imagenes[0]
            ),
          ),
        ),
      ),
    );
  }

  Widget _entradas() {
    return Column(
      children: widget.entradas.map((entrada) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Numero de entrada:"),
                Text(entrada.numeroEntrada),
              ],
            ),
          ],
        );
      }).toList(),
    );
  }

  List<PeticionEntradaCompraEntity> _convertirEntradas(List<EntradaEnVentaEntity> entradas) {
    Timestamp fechaCompra = Timestamp.now();
    return entradas.map((entrada) {
      return PeticionEntradaCompraEntity(
        numeroEntrada: entrada.numeroEntrada,
        fechaCompra: fechaCompra,
      );
    }).toList();
  }

  Widget _filaText({required String label, required String dato}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label),
        Text(dato),
      ],
    );
  }
}
