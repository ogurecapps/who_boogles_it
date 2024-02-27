import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:who_boogles_it/generated/locale_keys.g.dart';

class NicknameGenerator {
  late List<String> what;
  late List<String> who;

  reloadTranslations() {
    what = LocaleKeys.what.tr().split(',');
    who = LocaleKeys.who.tr().split(',');
  }

  String getRandomNickname({String exclude = ''}) {
    var r = Random();
    var nickname = "${what[r.nextInt(what.length)]}_${who[r.nextInt(who.length)]}";
    while (nickname == exclude) {
      nickname = "${what[r.nextInt(what.length)]}_${who[r.nextInt(who.length)]}";
    }
    return nickname;
  }
}
