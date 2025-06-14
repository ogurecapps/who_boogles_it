import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wakelock/wakelock.dart';
import 'package:who_boogles_it/core/database/local_database.dart';
import 'package:who_boogles_it/core/database/local_database_impl.dart';
import 'package:who_boogles_it/core/util/nickname_generator.dart';
import 'package:who_boogles_it/features/game/data/datasource/question_local_datasource.dart';
import 'package:who_boogles_it/features/game/data/datasource/question_local_datasource_impl.dart';
import 'package:who_boogles_it/features/game/data/datasource/question_remote_datasource.dart';
import 'package:who_boogles_it/features/game/data/datasource/question_remote_datasource_impl.dart';
import 'package:who_boogles_it/features/game/data/repositories/question_repository_impl.dart';
import 'package:who_boogles_it/features/game/domain/repositories/question_repository.dart';
import 'package:who_boogles_it/features/game/domain/use_cases/get_player_use_case.dart';
import 'package:who_boogles_it/features/game/domain/use_cases/get_question_use_case.dart';
import 'package:who_boogles_it/features/game/domain/use_cases/publish_answer_use_case.dart';
import 'package:who_boogles_it/features/game/domain/use_cases/update_questions_use_case.dart';
import 'package:who_boogles_it/features/game/domain/use_cases/win_counter_use_case.dart';
import 'package:who_boogles_it/features/profile/domain/use_cases/get_me_use_case.dart';
import 'package:who_boogles_it/features/profile/domain/use_cases/set_my_name_use_case.dart';
import 'package:who_boogles_it/firebase_options.dart';
import 'package:who_boogles_it/shared/data/datasource/player_local_datasource.dart';
import 'package:who_boogles_it/shared/data/datasource/player_local_datasource_impl.dart';
import 'package:who_boogles_it/shared/data/datasource/setting_datasource.dart';
import 'package:who_boogles_it/shared/data/datasource/setting_datasource_impl.dart';
import 'package:who_boogles_it/shared/data/repositories/player_repository_impl.dart';
import 'package:who_boogles_it/shared/data/repositories/setting_repository_impl.dart';
import 'package:who_boogles_it/shared/domain/repositories/player_repository.dart';
import 'package:who_boogles_it/shared/domain/repositories/setting_repository.dart';
import 'package:who_boogles_it/shared/domain/use_cases/get_setting_use_case.dart';
import 'package:who_boogles_it/shared/domain/use_cases/put_setting_use_case.dart';

final locator = GetIt.I;
final bool isMobile = !kIsWeb && (Platform.isAndroid || Platform.isIOS);

Future<void> initApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  Wakelock.enable();
  await dotenv.load(fileName: '.env');
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Supabase.initialize(url: dotenv.get('SUPABASE_URL'), anonKey: dotenv.get('SUPABASE_API_KEY'));
}

Future<void> initSingletons() async {
  locator.registerLazySingleton<NicknameGenerator>(() => NicknameGenerator());
  locator.registerLazySingleton<LocalDatabase>(() => LocalDatabaseImpl());
  locator.registerLazySingleton<RouteObserver<ModalRoute>>(() => RouteObserver<ModalRoute>());

  await locator<LocalDatabase>().initDb();
}

Future<void> enableCrashlytics() async {
  if (!isMobile) return;

  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(!kDebugMode);
}

void provideDatasources() {
  locator.registerFactory<PlayerLocalDatasource>(
      () => PlayerLocalDatasourceImpl(db: locator.get<LocalDatabase>()));
  locator.registerFactory<QuestionLocalDatasource>(
      () => QuestionLocalDatasourceImpl(db: locator.get<LocalDatabase>()));
  locator.registerFactory<SettingDatasource>(() => SettingDatasourceImpl(db: locator.get<LocalDatabase>()));
  locator.registerFactory<QuestionRemoteDatasource>(() => QuestionRemoteDatasourceImpl());
}

void provideRepositories() {
  locator.registerFactory<PlayerRepository>(
      () => PlayerRepositoryImpl(localDatasource: locator.get<PlayerLocalDatasource>()));
  locator.registerFactory<QuestionRepository>(() => QuestionRepositoryImpl(
        localDatasource: locator.get<QuestionLocalDatasource>(),
        remoteDatasource: locator.get<QuestionRemoteDatasource>(),
      ));
  locator.registerFactory<SettingRepository>(
      () => SettingRepositoryImpl(datasource: locator.get<SettingDatasource>()));
}

void provideUseCases() {
  locator.registerFactory<GetMeUseCase>(() => GetMeUseCase(repository: locator.get<PlayerRepository>()));
  locator
      .registerFactory<SetMyNameUseCase>(() => SetMyNameUseCase(repository: locator.get<PlayerRepository>()));
  locator.registerFactory<GetQuestionUseCase>(
      () => GetQuestionUseCase(repository: locator.get<QuestionRepository>()));
  locator
      .registerFactory<GetPlayerUseCase>(() => GetPlayerUseCase(repository: locator.get<PlayerRepository>()));
  locator.registerFactory<WinCounterUseCase>(
      () => WinCounterUseCase(repository: locator.get<PlayerRepository>()));
  locator.registerFactory<GetSettingUseCase>(
      () => GetSettingUseCase(repository: locator.get<SettingRepository>()));
  locator.registerFactory<PutSettingUseCase>(
      () => PutSettingUseCase(repository: locator.get<SettingRepository>()));
  locator.registerFactory<UpdateQuestionsUseCase>(
      () => UpdateQuestionsUseCase(repository: locator.get<QuestionRepository>()));
  locator.registerFactory<PublishAnswerUseCase>(
      () => PublishAnswerUseCase(repository: locator.get<QuestionRepository>()));
}
