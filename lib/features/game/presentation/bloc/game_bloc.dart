import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:who_boogles_it/core/di/locator.dart';
import 'package:who_boogles_it/core/models/player.dart';
import 'package:who_boogles_it/core/models/question.dart';
import 'package:who_boogles_it/features/game/domain/repositories/game_repository.dart';
import 'package:who_boogles_it/features/game/domain/use_cases/get_player_use_case.dart';
import 'package:who_boogles_it/features/game/domain/use_cases/get_question_use_case.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  final GameRepository gameRepository = GameRepository();

  final GetQuestionUseCase _getQuestionUseCase = locator.get<GetQuestionUseCase>();
  final GetPlayerUseCase _getPlayerUseCase = locator.get<GetPlayerUseCase>();

  GameBloc() : super(GameInitialState()) {
    on<NextRoundEvent>(_nextRound);
    on<LoadGameEvent>(_loadGameData);
    on<PlayerSaysEvent>(_playerSays);
    on<ProcessAnswerEvent>(_processAnswer);
    on<DieEvent>(_gameOver);
    on<NextTurnEvent>(_turnMove);
    on<DiceRollEvent>(_diceRollStart);
    on<DiceStopEvent>(_diceRollStop);
  }

  Future<void> _nextRound(NextRoundEvent event, Emitter<GameState> emit) async {
    if (gameRepository.nextRound()) {
      // Start new round
      emit(GameInitialState());
      await _loadGameData(LoadGameEvent(gameRepository.langCode), emit);
    } else {
      // End of the game
      emit(const GameOverState());
      await Future.delayed(3000.ms);
      emit(GameInitialState());
      await Future.delayed(100.ms);
      emit(GameOverDialogState(
        gameRepository.myScore > gameRepository.enemyScore
            ? gameRepository.me.nickname
            : gameRepository.enemy.nickname,
        gameRepository.myScore,
        gameRepository.enemyScore,
      ));
    }
  }

  Future<void> _diceRollStop(DiceStopEvent event, Emitter<GameState> emit) async {
    var diceMe = gameRepository.myDiceRoll();

    emit(DiceResultState(true, diceMe));
    await Future.delayed(1500.ms);

    emit(DiceCompareState(diceMe, gameRepository.diceEnemy)); // Show status
    await Future.delayed(1500.ms);
    emit(BubblesResetState());
    await Future.delayed(1000.ms);

    if (gameRepository.diceEnemy > diceMe) {
      await _turnMove(const NextTurnEvent(true, false), emit);
    } else if (gameRepository.diceEnemy < diceMe) {
      await _turnMove(const NextTurnEvent(false, false), emit);
    } else {
      // Roll again
      await _diceRollStart(DiceRollEvent(), emit);
    }
  }

  Future<void> _diceRollStart(DiceRollEvent event, Emitter<GameState> emit) async {
    if (gameRepository.isFinalRound()) {
      if (gameRepository.myScore < gameRepository.enemyScore) {
        await _turnMove(const NextTurnEvent(false, false), emit); // Next turn for player
      } else if (gameRepository.myScore > gameRepository.enemyScore) {
        await _turnMove(const NextTurnEvent(true, false), emit); // Next turn for AI
      } else {
        await _diceRoll(emit);
      }
    } else {
      await _diceRoll(emit);
    }
  }

  Future<void> _diceRoll(Emitter<GameState> emit) async {
    emit(const DiceRollState(false));
    await Future.delayed(Duration(milliseconds: 1000 + Random().nextInt(10) * 100));
    emit(DiceResultState(false, gameRepository.enemyDiceRoll()));
    await Future.delayed(1500.ms);
    emit(const DiceRollState(true));
  }

  Future<void> _turnMove(NextTurnEvent event, Emitter<GameState> emit) async {
    if (event.isBonusClaim) {
      emit(GetsBonusState(!event.isMe));
      await Future.delayed(1800.ms);
    }
    await _shiftTurn(event.isMe, emit);
  }

  Future<void> _gameOver(DieEvent event, Emitter<GameState> emit) async {
    final bool winnerIsMe = !event.isMe;

    if (event.isBonusClaim) {
      emit(GetsBonusState(winnerIsMe));
      await Future.delayed(1800.ms);
    }

    emit(EndRoundState(winnerIsMe, gameRepository.roundScore));
    await Future.delayed(1800.ms);
    gameRepository.payWin(winnerIsMe);

    if (gameRepository.rightAnswers.isNotEmpty) {
      // Show not opened answers
      for (int i = 0; i < gameRepository.rightAnswers.length; i++) {
        emit(OpenAnswerState(gameRepository.rightAnswers[i].split(',')[0], false));
        await Future.delayed(1200.ms);
      }
    }

    emit(NextRoundDialogState(winnerIsMe, gameRepository.getRoundResults(winnerIsMe)));
  }

  Future<void> _shiftTurn(bool isCurrentMe, Emitter<GameState> emit) async {
    var playerTurn = !isCurrentMe;
    emit(PlayerTurnState(playerTurn));

    // AI turn
    if (!playerTurn) {
      await Future.delayed(1000.ms); // Hide animation
      emit(EnemyWritingState());

      final String answer = gameRepository.getAnswer();

      await Future.delayed(Duration(milliseconds: answer.length * 450)); // Writing
      await _sayAnswer(emit, answer, false);
    }
  }

  Future<void> _processAnswer(ProcessAnswerEvent event, Emitter<GameState> emit) async {
    gameRepository.addScore(event.points);

    if (event.points > 0) {
      emit(RightAnswerState(event.points, event.isMe, event.isBonus));
    } else {
      emit(WrongAnswerState());
      await Future.delayed(2000.ms);
      await _shiftTurn(event.isMe, emit);
    }
  }

  Future<void> _showFinalResults(Emitter<GameState> emit) async {
    emit(FinalCheckState());
    // Open answers
    List<String> answer;
    bool skipDelay = false;

    for (int i = 0; i < gameRepository.rightAnswers.length; i++) {
      await Future.delayed(Duration(milliseconds: i == 0 ? 1500 : 2500));
      answer = gameRepository.rightAnswers[i].split(',');
      emit(OpenAnswerState(answer[0], true));

      if (answer.contains(gameRepository.enemyAnswer)) {
        await Future.delayed(100.ms);
        emit(FinalRightAnswerState(gameRepository.getPoints(i), false, i + 1));
        gameRepository.addPlayerScore(gameRepository.getPoints(i), false);
        skipDelay = false;
      } else if (answer.contains(gameRepository.myAnswer)) {
        await Future.delayed(100.ms);
        emit(FinalRightAnswerState(gameRepository.getPoints(i), true, i + 1));
        gameRepository.addPlayerScore(gameRepository.getPoints(i), true);
        skipDelay = false;
      } else {
        skipDelay = true;
      }
    }
    if (!skipDelay) await Future.delayed(2500.ms);
    await _nextRound(NextRoundEvent(), emit);
  }

  Future<void> _sayAnswer(Emitter<GameState> emit, String answer, bool isMe) async {
    gameRepository.makeAnswerUnavailable(answer);
    emit(SayAnswerState(answer, isMe));

    if (gameRepository.isFinalRound()) {
      gameRepository.setAnswer(answer, isMe);
      await Future.delayed(1000.ms);

      if (gameRepository.isAnswersReceived()) {
        await _showFinalResults(emit);
      } else {
        await _shiftTurn(isMe, emit);
      }
    } else {
      await Future.delayed(2500.ms);
      emit(CheckAnswerState(answer, isMe)); // Need delay before showing the result
    }
  }

  Future<void> _playerSays(PlayerSaysEvent event, Emitter<GameState> emit) async {
    await _sayAnswer(emit, event.answer, true);
  }

  Future<void> _loadGameData(LoadGameEvent event, Emitter<GameState> emit) async {
    if (!gameRepository.isStarted) {
      final Player me = await _getPlayerUseCase.execute(true);
      final Player enemy = await _getPlayerUseCase.execute(false);

      gameRepository.startGame(me, enemy, event.langCode);

      emit(EnemySearchStartState(enemy));
    } else {
      Question question;

      try {
        question = await _getQuestionUseCase.execute(event.langCode);
        gameRepository.setQuestion(question);
      } catch (e) {
        emit(GameErrorState());
        return;
      }

      await Future.delayed(100.ms);
      emit(GameReadyState(
        question.text,
        question.rightAnswers,
        question.wrongAnswers,
        gameRepository.me,
        gameRepository.enemy,
        gameRepository.myScore,
        gameRepository.enemyScore,
      ));

      await Future.delayed(3000.ms); // Wait for opening
      emit(RoundTipState(gameRepository.round));
    }
  }
}
