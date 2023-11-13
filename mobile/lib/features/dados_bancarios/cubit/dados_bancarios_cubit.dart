import 'package:auto_park/features/dados_bancarios/cubit/dados_bancarios_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

class DadosBancariosCubit extends Cubit<DadosBancariosState> {
  DadosBancariosCubit()
      : super(const DadosBancariosState(
            statusDadosBancarios: StatusDadosBancarios.initial));

  void setDataCard(CreditCardModel data) => emit(state.copyWith(
      statusDadosBancarios:
          state.statusDadosBancarios == StatusDadosBancarios.insertData
              ? StatusDadosBancarios.refreshData
              : StatusDadosBancarios.insertData,
      cvvCartao: data.cvvCode,
      nomeCartao: data.cardHolderName,
      numeroCartao: data.cardNumber,
      validadeCartao: data.expiryDate,
      showBackView: data.isCvvFocused));
}
