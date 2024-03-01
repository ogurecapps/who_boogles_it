import 'package:who_boogles_it/core/models/player.dart';
import 'package:who_boogles_it/shared/domain/repositories/player_repository.dart';

class PutPlayerUseCase {
  final PlayerRepository playerRepository;

  PutPlayerUseCase({required this.playerRepository});

  Future<void> execute(Player player) async {
    return playerRepository.putPlayer(player);
  }
}
