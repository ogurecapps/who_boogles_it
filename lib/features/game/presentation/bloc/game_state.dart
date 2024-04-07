part of 'game_bloc.dart';

sealed class GameState extends Equatable {
  const GameState();

  static const points = [
    [140, 80, 40, 20, 10, 5],
    [220, 140, 80, 40, 20, 10],
    [300, 200, 120, 60, 30, 15],
    [20, 40, 80, 160, 260, 380]
  ];

  @override
  List<Object> get props => [];
}

final class GameInitialState extends GameState {}

final class GameReadyState extends GameState {
  final String question;
  final List<String> rightAnswers;
  final List<String> wrongAnswers;
  final Player me;
  final Player enemy;
  final int round;

  const GameReadyState(
    this.question,
    this.rightAnswers,
    this.wrongAnswers,
    this.me,
    this.enemy,
    this.round,
  );
}

final class GameErrorState extends GameState {}

final class PlayerTurnState extends GameState {
  final Player me;
  final Player enemy;
  final bool isMe;

  const PlayerTurnState(
    this.me,
    this.enemy,
    this.isMe,
  );
}

final class SayAnswerState extends GameState {
  final String answer;
  final Player me;
  final Player enemy;

  const SayAnswerState(
    this.answer,
    this.me,
    this.enemy,
  );
}

final class CheckAnswerState extends GameState {
  final String answer;
  final Player me;
  final Player enemy;

  const CheckAnswerState(
    this.answer,
    this.me,
    this.enemy,
  );
}

final class ProcessAnswerState extends GameState {
  final int points;
  final Player me;
  final Player enemy;

  const ProcessAnswerState(
    this.points,
    this.me,
    this.enemy,
  );
}
