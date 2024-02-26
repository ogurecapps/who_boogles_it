import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:who_boogles_it/generated/locale_keys.g.dart';

class NicknameGenerator {
  late List<String> _what;
  late List<String> _who;

  reloadTranslations() {
    _what = LocaleKeys.what.tr().split(',');
    _who = LocaleKeys.who.tr().split(',');
  }

  String getRandomNickname({String exclude = ''}) {
    var r = Random(DateTime.now().millisecondsSinceEpoch);
    var nickname = "${_what[r.nextInt(_what.length)]}_${_who[r.nextInt(_who.length)]}";
    while (nickname == exclude) {
      nickname = "${_what[r.nextInt(_what.length)]}_${_who[r.nextInt(_who.length)]}";
    }
    return nickname;
  }
}
