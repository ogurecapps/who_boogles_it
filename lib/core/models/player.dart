import 'package:isar/isar.dart';

part 'player.g.dart';

@collection
class Player {
  Id isarId = Isar.autoIncrement;
  @Index(unique: true, replace: true)
  String nickname;
  @Index()
  bool isMe;
  int level;
  int winCounter;

  Player({required this.nickname, this.isMe = false, this.level = 1, this.winCounter = 0});
}
