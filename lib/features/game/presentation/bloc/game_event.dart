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

final class ProcessAnswerEvent extends GameEvent {
  final bool isMe;
  final int points;

  const ProcessAnswerEvent(this.points, this.isMe);
}

final class DieEvent extends GameEvent {
  final bool isMe;

  const DieEvent(this.isMe);
}

final class NextTurnEvent extends GameEvent {
  final bool isMe;

  const NextTurnEvent(this.isMe);
}
