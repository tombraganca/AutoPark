import 'package:auto_park/features/minha_conta/cubit/minha_conta_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MinhaContaCubit extends Cubit<MinhaContaState> {
  MinhaContaCubit()
      : super(const MinhaContaState(statusMinhaConta: StatusMinhaConta.inital));

  void changeObscureText() =>
      emit(state.copyWith(obscureText: !state.obscureText));
}
