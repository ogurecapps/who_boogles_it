import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:who_boogles_it/generated/locale_keys.g.dart';

class NicknameGenerator {
  List<String> what = [];
  List<String> who = [];

  loadTranslations() {
    what = LocaleKeys.what.tr().split(',');
    who = LocaleKeys.who.tr().split(',');
  }

  String getRandomNickname({String exclude = ''}) {
    if (what.isEmpty || who.isEmpty) {
      loadTranslations();
    }

    String nickname;
    do {
      nickname = "${what[Random().nextInt(what.length)]}_${who[Random().nextInt(who.length)]}";
    } while (nickname == exclude);

    return nickname;
  }
}
