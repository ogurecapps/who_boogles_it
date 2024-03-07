part of 'player_bloc.dart';

sealed class PlayerEvent extends Equatable {
  const PlayerEvent();

  @override
  List<Object> get props => [];
}

final class GetPlayerEvent extends PlayerEvent {
  const GetPlayerEvent();
}

final class RandomPlayerNameEvent extends PlayerEvent {
  const RandomPlayerNameEvent();
}

final class SetPlayerNameEvent extends PlayerEvent {
  final String name;
  const SetPlayerNameEvent(this.name);

  @override
  List<Object> get props => [name];
}
