part of 'game_bloc.dart';

sealed class GameEvent extends Equatable {
  const GameEvent();

  @override
  List<Object> get props => [];
}

final class LoadGameEvent extends GameEvent {
  final String langCode;
  const LoadGameEvent(this.langCode);
}

final class PlayerSaysEvent extends GameEvent {
  final String answer;
  const PlayerSaysEvent(this.answer);
}
