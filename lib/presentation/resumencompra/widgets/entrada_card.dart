import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticket_pass/domain/compra/entity/entrada_comprada_entity.dart';

import '../../../core/configs/theme/app_colors.dart';

class EntradaCard extends StatelessWidget {
  final EntradaCompradaEntity entrada;
  const EntradaCard({
    required this.entrada,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: AppColors.secondBackground,
          borderRadius: BorderRadius.circular(8)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 4,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    width: 90,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(
                                "j"
                            )
                        ),
                        borderRadius: BorderRadius.circular(4)
                    ),
                  ),
                ),
                const SizedBox(width: 10, ),
                Expanded(
                  flex: 6,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        entrada.numeroEntrada,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16
                        ),
                      ),
                      Row(
                        children: [
                          Text.rich(
                              overflow: TextOverflow.ellipsis,
                              TextSpan(
                                  text: 'Size - ',
                                  style: const TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 10
                                  ),
                                  children: [
                                    TextSpan(
                                      text: entrada.fechaCompra.toString(),
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 10
                                      ),
                                    )
                                  ]
                              )
                          ),
                          const SizedBox(width: 10, ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'DEntro del expanded',
                  style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    //context.read<CartProductsDisplayCubit>().removeProduct(productOrderedEntity);
                  },
                  child: Container(
                    height: 23,
                    width: 23,
                    decoration: const BoxDecoration(
                        color: Color(0xffFF8383),
                        shape: BoxShape.circle
                    ),
                    child: const Icon(
                      Icons.remove,
                      size: 15,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}