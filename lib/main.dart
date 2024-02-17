import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:who_boogles_it/app/routes/app_router.dart';
import 'package:who_boogles_it/app/themes/app_theme.dart';
import 'package:who_boogles_it/generated/locale_keys.g.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
        supportedLocales: App.supportedLocales,
        path: 'assets/translations',
        fallbackLocale: const Locale('en', 'US'),
        child: const App()),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  static const List<Locale> supportedLocales = [Locale('en', 'US'), Locale('ru', 'RU')];

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: tr(LocaleKeys.gameTitle),
      theme: AppTheme().buildThemeData(),
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
    );
  }
}
