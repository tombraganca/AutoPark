import 'package:auto_park/features/dados_bancarios/cubit/dados_bancarios_cubit.dart';
import 'package:auto_park/features/dados_bancarios/cubit/dados_bancarios_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart' as card;

class DadosBancariosPage extends StatefulWidget {
  final DadosBancariosCubit dadosBancariosCubit;
  const DadosBancariosPage({
    Key? key,
    required this.dadosBancariosCubit,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return DadosBancariosPageState();
  }
}

class DadosBancariosPageState extends State<DadosBancariosPage> {
  final formKey = GlobalKey<FormState>();
  final cvvController = TextEditingController();
  final validadeController = TextEditingController();
  final numberController = TextEditingController();
  final nomeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final availableHeight = (MediaQuery.sizeOf(context).height -
        (AppBar().preferredSize.height + MediaQuery.of(context).padding.top));
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dados Bancários"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: availableHeight,
          width: MediaQuery.sizeOf(context).width,
          child: BlocBuilder<DadosBancariosCubit, DadosBancariosState>(
            bloc: widget.dadosBancariosCubit,
            builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      card.CreditCardWidget(
                        cardNumber: state.numeroCartao,
                        expiryDate: state.validadeCartao,
                        cardHolderName: state.nomeCartao,
                        cvvCode: state.cvvCartao,
                        cardBgColor: Colors.black87,
                        showBackView: state.showBackView,
                        onCreditCardWidgetChange: (brand) {},
                      ),
                      card.CreditCardForm(
                        formKey: formKey,
                        cardNumber: state.numeroCartao,
                        expiryDate: state.validadeCartao,
                        cardHolderName: state.nomeCartao,
                        cvvCode: state.cvvCartao,
                        cvvValidationMessage: '',
                        dateValidationMessage: '',
                        numberValidationMessage: '',
                        onCreditCardModelChange:
                            widget.dadosBancariosCubit.setDataCard,
                        obscureCvv: state.showBackView,
                        obscureNumber: false,
                        isHolderNameVisible: true,
                        isCardNumberVisible: true,
                        isExpiryDateVisible: true,
                        enableCvv: true,
                        onFormComplete: () {},
                        autovalidateMode: AutovalidateMode.disabled,
                        disableCardNumberAutoFillHints: false,
                        inputConfiguration: const card.InputConfiguration(
                          cardNumberDecoration: InputDecoration(
                            labelText: 'Número',
                            hintText: 'XXXX XXXX XXXX XXXX',
                          ),
                          expiryDateDecoration: InputDecoration(
                            labelText: 'Data de Validade',
                            hintText: 'XX/XX',
                          ),
                          cvvCodeDecoration: InputDecoration(
                            labelText: 'CVV',
                            hintText: 'XXX',
                          ),
                          cardHolderDecoration: InputDecoration(
                            labelText: 'Nome',
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 50,
                    width: MediaQuery.sizeOf(context).width * 0.5,
                    child: ElevatedButton(
                      child: const Text(
                        "Salvar",
                        style: TextStyle(fontSize: 22),
                      ),
                      onPressed: () {},
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
