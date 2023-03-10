// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'login_cubit.dart';

enum StatusLogin { form }

class LoginState extends Equatable {
  final StatusLogin statusLogin;
  const LoginState({
    required this.statusLogin,
  });
  @override
  List<Object?> get props => [statusLogin];

  LoginState copyWith({
    StatusLogin? statusLogin,
  }) {
    return LoginState(
      statusLogin: statusLogin ?? this.statusLogin,
    );
  }
}
