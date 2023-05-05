import 'dart:core';

mixin Validators {
  String? email(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);
    if (value.isEmpty) {
      return "Informe o Email";
    } else if (!regExp.hasMatch(value)) {
      return "Email inválido";
    } else {
      return null;
    }
  }

  String? isNotEmpty(String? value) {
    if (value!.isEmpty) return "Este campo é obrigatório.";
    return null;
  }

  String? menorTresCaracteres(String? value) =>
      value!.length < 3 ? "Campo deve ter mais de 3 caracteres." : null;

  String? hasSeisCaracteres(String? value) =>
      value!.length < 6 ? "Campo deve ter 6 caracteres." : null;

  String? combineValidators(
      String? value, List<String? Function(String?)> validators) {
    for (var validator in validators) {
      String? result = validator(value);
      if (result != null) return result;
    }
    return null;
  }
}
