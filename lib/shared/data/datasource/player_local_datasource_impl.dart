import 'dart:math';

import 'package:isar/isar.dart';
import 'package:who_boogles_it/core/database/local_database.dart';
import 'package:who_boogles_it/core/di/locator.dart';
import 'package:who_boogles_it/core/models/player.dart';
import 'package:who_boogles_it/core/util/nickname_generator.dart';
import 'package:who_boogles_it/core/util/performance_trace.dart';
import 'package:who_boogles_it/shared/data/datasource/player_local_datasource.dart';

class PlayerLocalDatasourceImpl extends PlayerLocalDatasource {
  LocalDatabase db;

  PlayerLocalDatasourceImpl({required this.db});

  @override
  Future<Player> getEnemy() async {
    final PerformanceTrace trace = PerformanceTrace(traceName: 'get-enemy-trace');
    await trace.start();

    final players = await db.getDb().players.where().isMeEqualTo(false).findAll();

    if (players.isEmpty) {
      // Generating a new one
      final me = await getMe();
      var enemyNickname = locator<NicknameGenerator>().getRandomNickname(exclude: me.nickname);
      final enemy = Player(nickname: enemyNickname);
      enemy.setRandomLevel();

      await trace.stop(attributes: {'generating': 'true'});
      return enemy;
    } else {
      await trace.stop(attributes: {'generating': 'false'});
      return players[Random().nextInt(players.length)];
    }
  }

  @override
  Future<Player> getMe() async {
    final PerformanceTrace trace = PerformanceTrace(traceName: 'get-me-trace');
    await trace.start();

    var me = await db.getDb().players.where().isMeEqualTo(true).findFirst();

    if (me == null) {
      var nickname = locator<NicknameGenerator>().getRandomNickname();
      me = Player(nickname: nickname, isMe: true);
      await putPlayer(me);
      await trace.stop(attributes: {'generating': 'true'});
    } else {
      await trace.stop(attributes: {'generating': 'false'});
    }

    return me;
  }

  @override
  Future<void> putPlayer(Player player) async {
    await db.getDb().writeTxn(() async {
      await db.getDb().players.put(player);
    });
  }
}
