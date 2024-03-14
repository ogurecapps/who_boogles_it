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

    var exWhat = '', exWho = '';

    if (exclude != '') {
      var del = exclude.indexOf('-');
      // Contains, not first, not last
      if ((del > 0) && ((del + 1) < exclude.length)) {
        exWhat = exclude.substring(0, del);
        exWho = exclude.substring(del + 1);
      }
    }

    String rWhat, rWho;
    do {
      rWhat = what[Random().nextInt(what.length)];
      rWho = who[Random().nextInt(who.length)];
    } while (rWhat == exWhat || rWho == exWho);

    return '$rWhat-$rWho';
  }
}
