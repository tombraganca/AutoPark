import 'package:auto_park/features/home/cubit/home_cubit.dart';
import 'package:get_it/get_it.dart';

injectHome(GetIt getIt) {
  getIt.registerFactory<HomeCubit>(() => HomeCubit());
}
