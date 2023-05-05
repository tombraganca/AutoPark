import 'package:auto_park/core/domain/entities/user_entity.dart';
import 'package:auto_park/core/domain/usecases/auth_usecase.dart';
import 'package:auto_park/core/functions/toasts.dart';
import 'package:auto_park/login/cubit/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> with ToastMessages {
  AuthUseCase authUseCase;
  UserEntity? userEntity;
  LoginCubit({required this.authUseCase})
      : super(const LoginState(statusLogin: StatusLogin.form));

  Future<void> login(String email, String senha) async {
    emit(state.copyWith(statusLogin: StatusLogin.autenticandoLogin));
    var result = await authUseCase.auth(email: email, password: senha);
    result.fold((left) {
      showMessageError('Falha ao realizar o login !!');
      emit(state.copyWith(statusLogin: StatusLogin.falhaLogin));
    }, (user) {
      userEntity = user;
      showMessagePositive('Login realizado com sucesso !!');
      emit(state.copyWith(statusLogin: StatusLogin.sucessoLogin));
    });
  }

  void changeObscureText() =>
      emit(state.copyWith(obscureText: !state.obscureText));
}
