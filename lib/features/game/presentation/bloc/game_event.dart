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
  final Player me;
  final Player enemy;

  const PlayerSaysEvent(
    this.answer,
    this.me,
    this.enemy,
  );
}

final class ProcessAnswerEvent extends GameEvent {
  final int points;
  final Player me;
  final Player enemy;

  const ProcessAnswerEvent(
    this.points,
    this.me,
    this.enemy,
  );
}
