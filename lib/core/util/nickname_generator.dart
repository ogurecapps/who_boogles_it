import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NicknameGenerator {
  late List<String> what;
  late List<String> who;

  Future<void> reloadSources(Locale locale) async {
    what = await parseJsonList('assets/translations/what_${locale.languageCode}.json');
    who = await parseJsonList('assets/translations/who_${locale.languageCode}.json');
  }

  Future<List<String>> parseJsonList(String assetsPath) async {
    return rootBundle.loadString(assetsPath).then((jsonStr) => jsonDecode(jsonStr));
  }

  String getRandomNickname({String exclude = ''}) {
    var r = Random(DateTime.now().millisecondsSinceEpoch);
    var nickname = "${what[r.nextInt(what.length)]} ${who[r.nextInt(who.length)]}";
    while (nickname == exclude) {
      nickname = "${what[r.nextInt(what.length)]} ${who[r.nextInt(who.length)]}";
    }
    return nickname;
  }
}
