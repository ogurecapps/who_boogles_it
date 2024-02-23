import 'package:isar/isar.dart';

part 'player.g.dart';

@collection
class Player {
  Id isarId = Isar.autoIncrement;
  String nickname;
  bool isMe;

  Player({required this.nickname, this.isMe = false});
}
