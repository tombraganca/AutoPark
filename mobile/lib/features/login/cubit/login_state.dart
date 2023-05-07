import 'package:equatable/equatable.dart';

enum StatusLogin { form, autenticandoLogin, falhaLogin, sucessoLogin }

class LoginState extends Equatable {
  final bool obscureText;
  final StatusLogin statusLogin;
  const LoginState({
    required this.statusLogin,
    this.obscureText = false,
  });
  @override
  List<Object?> get props => [statusLogin, obscureText];

  LoginState copyWith({
    StatusLogin? statusLogin,
    bool? obscureText,
  }) {
    return LoginState(
      statusLogin: statusLogin ?? this.statusLogin,
      obscureText: obscureText ?? this.obscureText,
    );
  }
}
