import 'package:auto_park/core/data/dtos/user_dto.dart';
import 'package:flutter/material.dart';

abstract class UserDtoGlobal extends ChangeNotifier {
  UserDto _user = UserDto.empty();
  void setUser(UserDto userDto);
  UserDto getUser();
  String getToken();
}

class UserDtoGlobalImp extends UserDtoGlobal {
  @override
  UserDto getUser() {
    return _user;
  }

  @override
  void setUser(UserDto userDto) {
    _user = userDto;
    notifyListeners();
  }

  @override
  String getToken() {
    return _user.token;
  }
}
