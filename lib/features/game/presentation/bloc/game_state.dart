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

  const GameReadyState(this.question, this.rightAnswers, this.wrongAnswers);

  @override
  List<Object> get props => [question];
}
