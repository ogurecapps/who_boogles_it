import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:isar/isar.dart';
import 'package:who_boogles_it/app/app_color.dart';
import 'package:who_boogles_it/core/util/analytics_engine.dart';
import 'package:who_boogles_it/core/util/avatar_generator.dart';

part 'player.g.dart';

typedef LevelStats = ({int level, int progress, Color grade});

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

  Player({required this.nickname, this.isMe = false, this.winCounter = 0});

  Future<Player> buildAvatar(Size size) async {
    avatar = await AvatarGenerator(nickname, size.width, size.height).generate();
    return this;
  }

  void setRandomLevel() {
    var level = 'Beginner';
    if (Random().nextInt(100) < 50) {
      winCounter = Random().nextInt(4) + 1; // Beginner
    } else {
      if (Random().nextInt(100) < 60) {
        winCounter = 5 + Random().nextInt(20 - 4); // User
        level = 'User';
      } else {
        if (Random().nextInt(100) < 60) {
          winCounter = 21 + Random().nextInt(40 - 20); // Professional
          level = 'Professional';
        } else {
          if (Random().nextInt(100) < 60) {
            winCounter = 41 + Random().nextInt(70 - 40); // Expert
            level = 'Expert';
          } else {
            winCounter = 71 + Random().nextInt(101 - 70); // Elite
            level = 'Elite';
          }
        }
      }
    }

    winCounter = winCounter * 3 - 1;

    AnalyticsEngine.logEvent(
      name: 'Get enemy',
      parameters: {
        'name': nickname,
        'wins': winCounter,
        'level': level,
      },
    );
  }

  // One level every 3 win
  LevelStats getLevelStats() {
    var level = (winCounter / 3).floor() + 1;
    var closedWin = (level - 1) * 3;

    var grade = AppColor.grades[0];
    switch (level) {
      case > 100:
        grade = AppColor.grades[5];
        break;
      case > 70:
        grade = AppColor.grades[4];
        break;
      case > 40:
        grade = AppColor.grades[3];
        break;
      case > 20:
        grade = AppColor.grades[2];
        break;
      case > 4:
        grade = AppColor.grades[1];
        break;
    }
    return (level: level, progress: (winCounter - closedWin), grade: grade);
  }
}
