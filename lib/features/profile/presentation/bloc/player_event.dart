part of 'player_bloc.dart';

sealed class PlayerEvent extends Equatable {
  const PlayerEvent();

  @override
  List<Object> get props => [];
}

final class GetPlayerEvent extends PlayerEvent {
  const GetPlayerEvent();
}

final class RandomPlayerEvent extends PlayerEvent {
  const RandomPlayerEvent();
}

final class PutPlayerEvent extends PlayerEvent {
  final Player player;
  const PutPlayerEvent({required this.player});
}
