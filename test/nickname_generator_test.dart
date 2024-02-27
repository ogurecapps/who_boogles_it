import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:who_boogles_it/core/util/nickname_generator.mock.dart';

NicknameGeneratorMock gen = NicknameGeneratorMock();

void printGenerated(String lang, int total) {
  gen.reloadTranslationsByLang(lang);
  var name = '';
  for (var i = 0; i <= total; i++) {
    name = gen.getRandomNickname(exclude: name);
    if (kDebugMode) {
      print(name);
    }
  }
}

void main() {
  test('Nickname generator [RU]', () => printGenerated('ru', 100));
  test('Nickname generator [EN]', () => printGenerated('en', 100));
}
