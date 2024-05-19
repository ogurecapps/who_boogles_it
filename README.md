# who_boogles_it

The game where you must guess the end of search requests

# Generation:

// easy_localization
flutter pub run easy_localization:generate -f keys -S .\assets\translations\ -o locale_keys.g.dart

// flutter_native_splash
dart run flutter_native_splash:create

// build_runner (models)
flutter packages pub run build_runner build

# .env:
SUPABASE_URL=xxx
SUPABASE_API_KEY=xxx