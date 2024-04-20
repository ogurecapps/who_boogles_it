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
  final bool isBonus;

  const ProcessAnswerEvent(this.points, this.isMe, this.isBonus);
}

final class DieEvent extends GameEvent {
  final bool isMe;
  final bool isBonusClaim;

  const DieEvent(this.isMe, this.isBonusClaim);
}

final class NextTurnEvent extends GameEvent {
  final bool isMe;
  final bool isBonusClaim;

  const NextTurnEvent(this.isMe, this.isBonusClaim);
}
