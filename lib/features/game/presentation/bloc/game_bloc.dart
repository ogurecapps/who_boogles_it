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
  late List<String> rightAnswers;
  late List<String> wrongAnswers;

  int round = 0;
  int _score = 0;

  final GetQuestionUseCase _getQuestionUseCase = locator.get<GetQuestionUseCase>();
  final GetPlayerUseCase _getPlayerUseCase = locator.get<GetPlayerUseCase>();

  GameBloc() : super(GameInitialState()) {
    on<LoadGameEvent>(_loadGameData);
    on<PlayerSaysEvent>(_playerSays);
    on<ProcessAnswerEvent>(_processAnswer);
    on<DieEvent>(_lifesOver);
    on<NextTurnEvent>(_turnMove);
  }

  Future<void> _turnMove(NextTurnEvent event, Emitter<GameState> emit) async {
    await _nextTurn(event.isMe, false, emit);
  }

  Future<void> _lifesOver(DieEvent event, Emitter<GameState> emit) async {
    emit(EndRoundState(!event.isMe, false, _score));
  }

  Future<void> _nextTurn(bool isCurrentMe, bool isWin, Emitter<GameState> emit) async {
    var playerTurn = isWin ? isCurrentMe : !isCurrentMe;
    emit(PlayerTurnState(playerTurn));

    if (!playerTurn) {
      await Future.delayed(1000.ms);
      emit(EnemyWritingState());

      var answer = Random().nextInt(100) > 60
          ? rightAnswers[Random().nextInt(rightAnswers.length)].split(',')[0]
          : wrongAnswers[Random().nextInt(wrongAnswers.length)];

      await Future.delayed(Duration(milliseconds: answer.length * 380)); // Writing
      await _sayAnswer(emit, answer, false);
    }
  }

  Future<void> _processAnswer(ProcessAnswerEvent event, Emitter<GameState> emit) async {
    _score += event.points;

    emit(ProcessAnswerState(event.points, event.isMe));

    if (rightAnswers.isEmpty) {
      // Win
      await Future.delayed(2000.ms);
      emit(EndRoundState(event.isMe, true, _score));
    } else if (event.points == 0) {
      // Spend one life point
      emit(SpendLifeState(event.isMe));
    } else {
      // Next turn
      await Future.delayed(2000.ms);
      await _nextTurn(event.isMe, true, emit);
    }
  }

  Future<void> _sayAnswer(Emitter<GameState> emit, String answer, bool isMe) async {
    _removeFromAnswers(answer);

    emit(SayAnswerState(answer, isMe));
    await Future.delayed(2500.ms);
    emit(CheckAnswerState(answer, isMe)); // Need delay before showing the result
  }

  void _removeFromAnswers(String answer) {
    wrongAnswers.remove(answer.toLowerCase());
    rightAnswers.removeWhere((element) => element.split(',').contains(answer.toLowerCase()));
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
    rightAnswers = List.from(question.rightAnswers);
    wrongAnswers = List.from(question.wrongAnswers);

    await Future.delayed(400.ms);
    emit(GameReadyState(
      question.text,
      question.rightAnswers,
      question.wrongAnswers,
      me,
      enemy,
    ));

    await Future.delayed(2000.ms);
    emit(const PlayerTurnState(true));
  }
}
