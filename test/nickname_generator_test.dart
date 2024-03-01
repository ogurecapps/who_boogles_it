import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:who_boogles_it/core/util/nickname_generator.dart';

final NicknameGenerator gen = NicknameGenerator();

Future<List<String>> loadListFromAssets(String filePath, String arrayName) async {
  String jsonString = await rootBundle.loadString(filePath);
  Map<String, dynamic> json = jsonDecode(jsonString);
  return json[arrayName].split(',');
}

Future<void> printGenerated(String locale, int total) async {
  gen.what = await loadListFromAssets('assets/translations/$locale.json', 'what');
  gen.who = await loadListFromAssets('assets/translations/$locale.json', 'who');

  var exclude = '';
  for (var i = 0; i <= total; i++) {
    var name = gen.getRandomNickname(exclude: exclude);

    if (kDebugMode) {
      print(name);
    }

    expect(name.length <= 18, isTrue);
    expect(name != exclude, isTrue);
    exclude = name;
  }
}

void main() {
  setUpAll(() => TestWidgetsFlutterBinding.ensureInitialized());
  test('Nickname generator [RU]', () => printGenerated('ru-RU', 100));
  test('Nickname generator [EN]', () => printGenerated('en-US', 100));
}
