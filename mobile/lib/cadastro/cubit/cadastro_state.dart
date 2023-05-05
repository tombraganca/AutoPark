// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class CadastroState extends Equatable {
  final StatusCadastro statusCadastro;
  final bool obscureText;
  const CadastroState({
    this.obscureText = false,
    required this.statusCadastro,
  });
  @override
  List<Object?> get props => [statusCadastro, obscureText];

  CadastroState copyWith({
    StatusCadastro? statusCadastro,
    bool? obscureText,
  }) {
    return CadastroState(
      statusCadastro: statusCadastro ?? this.statusCadastro,
      obscureText: obscureText ?? this.obscureText,
    );
  }
}

enum StatusCadastro { form, succesoCadastro, errorCadastro, enviandoCadastro }
