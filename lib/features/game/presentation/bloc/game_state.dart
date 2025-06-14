part of 'game_bloc.dart';

sealed class GameState extends Equatable {
  const GameState();

  @override
  List<Object> get props => [];
}

final class GameInitialState extends GameState {}

final class UpdateDatabaseState extends GameState {}

final class EnemySearchStartState extends GameState {
  final Player enemy;

  const EnemySearchStartState(this.enemy);
}

final class GameReadyState extends GameState {
  final String question;
  final List<String> rightAnswers;
  final List<String> wrongAnswers;
  final Player me;
  final Player enemy;
  final int myScore;
  final int enemyScore;

  const GameReadyState(
    this.question,
    this.rightAnswers,
    this.wrongAnswers,
    this.me,
    this.enemy,
    this.myScore,
    this.enemyScore,
  );
}

final class GameErrorState extends GameState {}

final class RoundTipState extends GameState {
  final int round;

  const RoundTipState(this.round);
}

final class PlayerTurnState extends GameState {
  final bool isMe;

  const PlayerTurnState(this.isMe);
}

final class EndRoundState extends GameState {
  final bool isMe; // Winner
  final int roundScore;

  const EndRoundState(
    this.isMe,
    this.roundScore,
  );
}

final class NextRoundDialogState extends GameState {
  final bool isWinnerMe;
  final List<(Player, int, int)> players;

  const NextRoundDialogState(
    this.isWinnerMe,
    this.players,
  );
}

final class EnemyWritingState extends GameState {}

final class SayAnswerState extends GameState {
  final bool isMe;
  final String answer;

  const SayAnswerState(
    this.answer,
    this.isMe,
  );
}

final class CheckAnswerState extends GameState {
  final bool isMe;
  final String answer;

  const CheckAnswerState(
    this.answer,
    this.isMe,
  );
}

final class RightAnswerState extends GameState {
  final bool isMe;
  final int points;
  final bool isBonus;

  const RightAnswerState(
    this.points,
    this.isMe,
    this.isBonus,
  );
}

final class WrongAnswerState extends GameState {}

final class GetsBonusState extends GameState {
  final bool isMe;

  const GetsBonusState(this.isMe);
}

final class DiceRollState extends GameState {
  final bool isMe;

  const DiceRollState(this.isMe);
}

final class DiceResultState extends GameState {
  final bool isMe;
  final int result;

  const DiceResultState(
    this.isMe,
    this.result,
  );
}

final class DiceCompareState extends GameState {
  final int diceMe;
  final int diceEnemy;

  const DiceCompareState(
    this.diceMe,
    this.diceEnemy,
  );
}

final class BubblesResetState extends GameState {}

final class OpenAnswerState extends GameState {
  final String answer;
  final bool isFinalRound;

  const OpenAnswerState(
    this.answer,
    this.isFinalRound,
  );

  @override
  List<Object> get props => [answer];
}

final class FinalCheckState extends GameState {}

final class FinalRightAnswerState extends GameState {
  final bool isMe;
  final int points;
  final int pos;

  const FinalRightAnswerState(
    this.points,
    this.isMe,
    this.pos,
  );
}

final class GameOverState extends GameState {
  const GameOverState();
}

final class GameOverDialogState extends GameState {
  final String winnerNickname;
  final int myScore;
  final int enemyScore;

  const GameOverDialogState(
    this.winnerNickname,
    this.myScore,
    this.enemyScore,
  );
}
