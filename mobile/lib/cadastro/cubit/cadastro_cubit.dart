import 'package:auto_park/cadastro/cubit/cadastro_state.dart';
import 'package:auto_park/core/domain/usecases/auth_usecase.dart';
import 'package:auto_park/core/functions/toasts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CadastroCubit extends Cubit<CadastroState> with ToastMessages {
  final AuthUseCase authUseCase;
  CadastroCubit({required this.authUseCase})
      : super(const CadastroState(statusCadastro: StatusCadastro.form));
  Future<void> cadastrar(String email, String senha, String nome) async {
    emit(state.copyWith(statusCadastro: StatusCadastro.enviandoCadastro));
    var result =
        await authUseCase.create(email: email, password: senha, name: nome);
    result.fold((left) {
      showMessageError('Houve uma falha ao cadastrar !!');
      emit(state.copyWith(statusCadastro: StatusCadastro.errorCadastro));
    }, (right) {
      showMessagePositive('Cadastro realiado com sucesso !!');
      emit(state.copyWith(statusCadastro: StatusCadastro.succesoCadastro));
    });
  }

  void changeObscureText() =>
      emit(state.copyWith(obscureText: !state.obscureText));
}
