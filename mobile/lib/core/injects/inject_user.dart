import 'package:auto_park/core/injects/userSingleton/user_global_singleton.dart';
import 'package:get_it/get_it.dart';

void injectUser(GetIt getIt) {
  getIt.registerLazySingleton<UserDtoGlobal>(() => UserDtoGlobalImp());
}
