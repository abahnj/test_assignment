import 'package:casino_test/src/data/repository/characters_repository.dart';
import 'package:casino_test/src/data/repository/characters_repository_impl.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';

class MainDIModule {
  void configure(GetIt getIt) {
    getIt
      ..registerLazySingleton<Client>(() => Client())
      ..registerLazySingleton<CharactersRepository>(
        () => CharactersRepositoryImpl(getIt<Client>()),
      );
  }
}
