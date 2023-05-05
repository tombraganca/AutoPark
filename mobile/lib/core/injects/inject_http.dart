import 'package:auto_park/core/services/http_connections_service.dart';
import 'package:auto_park/packages/http_connections_service_imp.dart';
import 'package:get_it/get_it.dart';

void injectHttp(GetIt getIt) {
  getIt.registerLazySingleton<HttpConnectionsService>(
      () => HttpConnectiosServiceImp());
}
