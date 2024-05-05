import 'package:who_boogles_it/core/models/player.dart';
import 'package:who_boogles_it/shared/domain/repositories/player_repository.dart';

class WinCounterUseCase {
  final PlayerRepository repository;

  WinCounterUseCase({required this.repository});

  Future<void> execute(Player player) async {
    player.winCounter++;
    await repository.putPlayer(player);
  }
}
