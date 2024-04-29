import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:who_boogles_it/core/di/locator.dart';
import 'package:who_boogles_it/core/models/player.dart';
import 'package:who_boogles_it/core/models/question.dart';
import 'package:who_boogles_it/features/game/domain/use_cases/get_player_use_case.dart';
import 'package:who_boogles_it/features/game/domain/use_cases/get_question_use_case.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  static const points = [
    [140, 80, 40, 20, 10, 5],
    [220, 140, 80, 40, 20, 10],
    [300, 200, 120, 60, 30, 15],
    [20, 40, 80, 160, 260, 380]
  ];

  late Player me;
  late Player enemy;
  // Mutable lists
  late List<String> _rightAnswers;
  late List<String> _wrongAnswers;

  int round = 0;
  int _score = 0;
  int _diceEnemy = 0;

  final GetQuestionUseCase _getQuestionUseCase = locator.get<GetQuestionUseCase>();
  final GetPlayerUseCase _getPlayerUseCase = locator.get<GetPlayerUseCase>();

  GameBloc() : super(GameInitialState()) {
    on<LoadGameEvent>(_loadGameData);
    on<PlayerSaysEvent>(_playerSays);
    on<ProcessAnswerEvent>(_processAnswer);
    on<DieEvent>(_gameOver);
    on<NextTurnEvent>(_turnMove);
    on<DiceRollEvent>(_diceRollStart);
    on<DiceStopEvent>(_diceStop);
  }

  Future<void> _diceStop(DiceStopEvent event, Emitter<GameState> emit) async {
    var diceMe = Random().nextInt(6);

    emit(DiceResultState(true, diceMe));
    await Future.delayed(1500.ms);

    emit(DiceCompareState(diceMe, _diceEnemy)); // Show status
    await Future.delayed(1500.ms);
    emit(BubblesResetState());
    await Future.delayed(1000.ms);

    if (_diceEnemy > diceMe) {
      await _turnMove(const NextTurnEvent(true, false), emit);
    } else if (_diceEnemy < diceMe) {
      await _turnMove(const NextTurnEvent(false, false), emit);
    } else {
      await _diceRollStart(DiceRollEvent(), emit);
    }
  }

  Future<void> _diceRollStart(DiceRollEvent event, Emitter<GameState> emit) async {
    emit(const DiceRollState(false));
    await Future.delayed(Duration(milliseconds: 1800 + Random().nextInt(10) * 100));
    _diceEnemy = Random().nextInt(6);
    emit(DiceResultState(false, _diceEnemy));
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
    if (event.isBonusClaim) {
      emit(GetsBonusState(!event.isMe));
      await Future.delayed(1800.ms);
    }
    emit(EndRoundState(!event.isMe, _score));
    await Future.delayed(1800.ms);

    if (_rightAnswers.isNotEmpty) {
      // Show not opened answers
      for (int i = 0; i < _rightAnswers.length; i++) {
        emit(OpenAnswerState(_rightAnswers[i].split(',')[0]));
        await Future.delayed(1200.ms);
      }
    }

    //emit(NextRoundDialogState());
  }

  Future<void> _shiftTurn(bool isCurrentMe, Emitter<GameState> emit) async {
    var playerTurn = !isCurrentMe;
    emit(PlayerTurnState(playerTurn));

    // AI turn
    if (!playerTurn) {
      await Future.delayed(1000.ms); // Hide animation
      emit(EnemyWritingState());

      var answer = (_wrongAnswers.isEmpty ? true : Random().nextInt(100) > 60)
          ? _rightAnswers[Random().nextInt(_rightAnswers.length)].split(',')[0]
          : _wrongAnswers[Random().nextInt(_wrongAnswers.length)];

      await Future.delayed(Duration(milliseconds: answer.length * 450)); // Writing
      await _sayAnswer(emit, answer, false);
    }
  }

  Future<void> _processAnswer(ProcessAnswerEvent event, Emitter<GameState> emit) async {
    _score += event.points;

    if (event.points > 0) {
      emit(RightAnswerState(event.points, event.isMe, event.isBonus));
    } else {
      emit(WrongAnswerState());
      await Future.delayed(2000.ms);
      await _shiftTurn(event.isMe, emit);
    }
  }

  Future<void> _sayAnswer(Emitter<GameState> emit, String answer, bool isMe) async {
    _removeFromAnswers(answer);

    emit(SayAnswerState(answer, isMe));
    await Future.delayed(2500.ms);
    emit(CheckAnswerState(answer, isMe)); // Need delay before showing the result
  }

  void _removeFromAnswers(String answer) {
    _wrongAnswers.remove(answer.toLowerCase());
    _rightAnswers.removeWhere((element) => element.split(',').contains(answer.toLowerCase()));
  }

  Future<void> _playerSays(PlayerSaysEvent event, Emitter<GameState> emit) async {
    await _sayAnswer(emit, event.answer, true);
  }

  Future<void> _loadGameData(LoadGameEvent event, Emitter<GameState> emit) async {
    Question question;

    try {
      question = await _getQuestionUseCase.execute(event.langCode);
    } catch (e) {
      emit(GameErrorState());
      return;
    }

    me = await _getPlayerUseCase.execute(true);
    enemy = await _getPlayerUseCase.execute(false);
    _rightAnswers = List.from(question.rightAnswers);
    _wrongAnswers = List.from(question.wrongAnswers);

    await Future.delayed(400.ms);
    emit(GameReadyState(
      question.text,
      question.rightAnswers,
      question.wrongAnswers,
      me,
      enemy,
    ));

    await Future.delayed(3000.ms);
    emit(RoundTipState(round));
  }
}
