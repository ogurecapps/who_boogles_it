part of 'game_bloc.dart';

sealed class GameState extends Equatable {
  const GameState();

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

  const GameReadyState(
    this.question,
    this.rightAnswers,
    this.wrongAnswers,
    this.me,
    this.enemy,
  );
}

final class GameErrorState extends GameState {}

final class PlayerTurnState extends GameState {
  final bool isMe;

  const PlayerTurnState(this.isMe);
}

final class EndRoundState extends GameState {
  final bool isPlayerWin;
  final bool isSolved;

  const EndRoundState(this.isPlayerWin, this.isSolved);
}

final class EnemyWritingState extends GameState {}

final class SayAnswerState extends GameState {
  final bool isMe;
  final String answer;

  const SayAnswerState(this.answer, this.isMe);
}

final class CheckAnswerState extends GameState {
  final bool isMe;
  final String answer;

  const CheckAnswerState(this.answer, this.isMe);
}

final class ProcessAnswerState extends GameState {
  final bool isMe;
  final int points;

  const ProcessAnswerState(this.points, this.isMe);
}
