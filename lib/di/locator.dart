import 'package:get_it/get_it.dart';
import 'package:who_boogles_it/core/database/local_database.dart';
import 'package:who_boogles_it/core/database/local_database_impl.dart';
import 'package:who_boogles_it/core/util/nickname_generator.dart';

final locator = GetIt.I;

Future<void> initSingletons() async {
  locator.registerLazySingleton<NicknameGenerator>(() => NicknameGenerator());
  locator.registerLazySingleton<LocalDatabase>(() => LocalDatabaseImpl());

  await locator<LocalDatabase>().initDb();
  locator<NicknameGenerator>().reloadTranslations();
}

void registerDatasources() {}

void registerRepositories() {}

void registerUseCases() {}
