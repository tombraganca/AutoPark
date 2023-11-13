// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class MinhaContaState extends Equatable {
  final bool obscureText;
  final StatusMinhaConta statusMinhaConta;

  const MinhaContaState(
      {required this.statusMinhaConta, this.obscureText = true});
  @override
  List<Object?> get props => [
        statusMinhaConta,
        obscureText,
      ];

  MinhaContaState copyWith({
    bool? obscureText,
    StatusMinhaConta? statusMinhaConta,
  }) {
    return MinhaContaState(
      obscureText: obscureText ?? this.obscureText,
      statusMinhaConta: statusMinhaConta ?? this.statusMinhaConta,
    );
  }
}

enum StatusMinhaConta { inital }
