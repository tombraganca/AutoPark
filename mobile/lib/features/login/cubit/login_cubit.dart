import 'package:auto_park/core/domain/entities/user_entity.dart';
import 'package:auto_park/core/domain/usecases/auth_usecase.dart';
import 'package:auto_park/core/functions/toasts.dart';
import 'package:auto_park/core/injects/userSingleton/user_global_singleton.dart';
import 'package:auto_park/core/services/firebase_messaging.dart';
import 'package:auto_park/features/login/cubit/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class LoginCubit extends Cubit<LoginState> with ToastMessages {
  AuthUseCase authUseCase;
  FirebaseMessagingService firebaseMessagingService;
  LoginCubit(
      {required this.authUseCase, required this.firebaseMessagingService})
      : super(const LoginState(statusLogin: StatusLogin.form));

  Future<void> login(String email, String senha) async {
    emit(state.copyWith(statusLogin: StatusLogin.autenticandoLogin));
    var result = await authUseCase.auth(email: email, password: senha);
    result.fold((left) {
      showMessageError('Falha ao realizar o login !!');
      emit(state.copyWith(statusLogin: StatusLogin.falhaLogin));
    }, (user) {
      GetIt.I.get<UserDtoGlobal>().setUser(user);

      showMessagePositive('Login realizado com sucesso !!');
      emit(state.copyWith(statusLogin: StatusLogin.sucessoLogin));
    });
  }

  Future<void> sabeTokenDispositivo() async {
    await firebaseMessagingService.getDeviceFirebaseToken();
  }

  void changeObscureText() =>
      emit(state.copyWith(obscureText: !state.obscureText));
}
