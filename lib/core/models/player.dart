import 'dart:ui';

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

  Player({required this.nickname, this.isMe = false, this.winCounter = 0});

  Future<Player> buildAvatar(Size size) async {
    avatar = await AvatarGenerator(nickname, size.width, size.height).generate();
    return this;
  }

  // One level every 3 win
  ({int level, int progress}) getLevel() {
    var level = (winCounter / 3).floor() + 1;
    var closedWin = (level - 1) * 3;
    return (level: level, progress: (winCounter - closedWin));
  }
}
