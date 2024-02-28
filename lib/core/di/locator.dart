import 'package:get_it/get_it.dart';
import 'package:who_boogles_it/core/database/local_database.dart';
import 'package:who_boogles_it/core/database/local_database_impl.dart';
import 'package:who_boogles_it/core/util/nickname_generator.dart';
import 'package:who_boogles_it/features/profile/domain/use_cases/get_player_use_case.dart';
import 'package:who_boogles_it/features/profile/domain/use_cases/put_player_use_case.dart';
import 'package:who_boogles_it/shared/data/datasource/player_local_datasource.dart';
import 'package:who_boogles_it/shared/data/datasource/player_local_datasource_impl.dart';
import 'package:who_boogles_it/shared/data/repositories/player_repository_impl.dart';
import 'package:who_boogles_it/shared/domain/repositories/player_repository.dart';

final locator = GetIt.I;

Future<void> initSingletons() async {
  locator.registerLazySingleton<NicknameGenerator>(() => NicknameGenerator());
  locator.registerLazySingleton<LocalDatabase>(() => LocalDatabaseImpl());

  await locator<LocalDatabase>().initDb();
}

void provideDatasources() {
  locator.registerFactory<PlayerLocalDatasource>(
      () => PlayerLocalDatasourceImpl(db: locator.get<LocalDatabase>()));
}

void provideRepositories() {
  locator.registerFactory<PlayerRepository>(
      () => PlayerRepositoryImpl(playerLocalDatasource: locator.get<PlayerLocalDatasource>()));
}

void provideUseCases() {
  locator.registerFactory<GetPlayerUseCase>(
      () => GetPlayerUseCase(playerRepository: locator.get<PlayerRepository>()));
  locator.registerFactory<PutPlayerUseCase>(
      () => PutPlayerUseCase(playerRepository: locator.get<PlayerRepository>()));
}
