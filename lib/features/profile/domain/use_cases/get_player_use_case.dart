import 'package:who_boogles_it/core/models/player.dart';
import 'package:who_boogles_it/shared/domain/repositories/player_repository.dart';

class GetPlayerUseCase {
  final PlayerRepository playerRepository;

  GetPlayerUseCase({required this.playerRepository});

  Future<Player> execute() async {
    return playerRepository.getMe();
  }
}
