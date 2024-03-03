import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:isar/isar.dart';
import 'package:who_boogles_it/core/util/avatar_generator.dart';

part 'player.g.dart';

@collection
class Player {
  Id isarId = Isar.autoIncrement;
  @Index(unique: true, replace: true)
  String nickname;
  @Index()
  bool isMe;
  int winCounter;
  @ignore
  late SvgPicture avatar;
  @ignore
  static const grades = [
    Color(0xff818181),
    Color(0xffed5761),
    Color(0xff0f8b61),
    Color(0xff2a60c9),
    Color(0xffffb445),
    Color(0xff6e12bd),
  ];

  Player({required this.nickname, this.isMe = false, this.winCounter = 0});

  Future<Player> buildAvatar(Size size) async {
    avatar = await AvatarGenerator(nickname, size.width, size.height).generate();
    return this;
  }

  // One level every 3 win
  ({int level, int progress, Color grade}) getLevel() {
    var level = (winCounter / 3).floor() + 1;
    var closedWin = (level - 1) * 3;

    var grade = grades[0];
    switch (level) {
      case > 44:
        grade = grades[5];
        break;
      case > 30:
        grade = grades[4];
        break;
      case > 20:
        grade = grades[3];
        break;
      case > 10:
        grade = grades[2];
        break;
      case > 3:
        grade = grades[1];
        break;
    }
    return (level: level, progress: (winCounter - closedWin), grade: grade);
  }
}
