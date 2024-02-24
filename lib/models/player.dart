import 'package:isar/isar.dart';

part 'player.g.dart';

@collection
class Player {
  Id isarId = Isar.autoIncrement;
  @Index(unique: true)
  String nickname; // Check is available
  bool isMe;

  Player({required this.nickname, this.isMe = false});
}
