import 'package:covid_19_informator/service/covid_service.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

setupServiceLocator() {
  locator.registerLazySingleton<CovidService>(() => CovidService());
}
