import 'package:auto_park/core/domain/entities/pagamento_entity.dart';
import 'package:auto_park/features/notificacao/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class CardPagamentos extends StatelessWidget {
  final PagamentosEntity pagamentosEntity;
  const CardPagamentos({super.key, required this.pagamentosEntity});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: ClipPath(
          clipper: ShapeBorderClipper(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(
                    color: pagamentosEntity.status
                            .toLowerCase()
                            .contains('em aberto')
                        ? const Color.fromARGB(255, 93, 252, 90)
                        : pagamentosEntity.status
                                .toLowerCase()
                                .contains('vencido')
                            ? Colors.yellow
                            : Colors.grey,
                    width: 10),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    pagamentosEntity.nomeEstacionamento,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                CustomText(
                  label: 'VALOR: ',
                  value: 'R\$${pagamentosEntity.valor}',
                ),
                Visibility(
                  visible:
                      !pagamentosEntity.status.toLowerCase().contains('pago'),
                  child: CustomText(
                      label: 'Data de Abertura: ',
                      value: pagamentosEntity.dataAbertura),
                ),
                Visibility(
                  visible:
                      !pagamentosEntity.status.toLowerCase().contains('pago'),
                  child: CustomText(
                      label: 'Data de Vencimento: ',
                      value: pagamentosEntity.dataVencimento),
                ),
                Visibility(
                  visible:
                      pagamentosEntity.status.toLowerCase().contains('pago'),
                  child: CustomText(
                      label: 'Data de Pagamento: ',
                      value: pagamentosEntity.dataPagamento),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
