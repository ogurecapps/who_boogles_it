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
  final Set<String> rightAnswers;
  final Set<String> wrongAnswers;
  final Player me;
  final Player enemy;
  final int roundBank = 0;

  const GameReadyState(
    this.question,
    this.rightAnswers,
    this.wrongAnswers,
    this.me,
    this.enemy,
  );

  @override
  List<Object> get props => [question];
}
