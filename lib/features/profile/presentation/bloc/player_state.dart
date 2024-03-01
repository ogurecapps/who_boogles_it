part of 'player_bloc.dart';

sealed class PlayerState extends Equatable {
  const PlayerState();

  @override
  List<Object> get props => [];
}

final class PlayerInitialState extends PlayerState {}

final class PlayerRefreshState extends PlayerState {}

final class PlayerReadyState extends PlayerState {
  final Player player;

  const PlayerReadyState(this.player);
}
