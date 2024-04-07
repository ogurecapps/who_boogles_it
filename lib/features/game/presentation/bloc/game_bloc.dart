import 'dart:developer';

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
  final GetQuestionUseCase _getQuestionUseCase = locator.get<GetQuestionUseCase>();
  final GetPlayerUseCase _getPlayerUseCase = locator.get<GetPlayerUseCase>();

  GameBloc() : super(GameInitialState()) {
    on<LoadGameEvent>(_loadGameData);
    on<PlayerSaysEvent>(_playerSays);
    on<ProcessAnswerEvent>(_processAnswer);
  }

  Future<void> _processAnswer(ProcessAnswerEvent event, Emitter<GameState> emit) async {
    emit(ProcessAnswerState(event.points, event.me, event.enemy));
    await Future.delayed(2000.ms);
    emit(PlayerTurnState(event.me, event.enemy, event.points != 0));
  }

  Future<void> _playerSays(PlayerSaysEvent event, Emitter<GameState> emit) async {
    emit(SayAnswerState(event.answer, event.me, event.enemy));
    await Future.delayed(2500.ms);
    emit(CheckAnswerState(event.answer, event.me, event.enemy)); // Need delay before showing the result
  }

  Future<void> _loadGameData(LoadGameEvent event, Emitter<GameState> emit) async {
    late Question question;

    try {
      question = await _getQuestionUseCase.execute(event.langCode);
    } catch (e) {
      log(e.toString());
      emit(GameErrorState());
      return;
    }

    Player me = await _getPlayerUseCase.execute(true);
    Player enemy = await _getPlayerUseCase.execute(false);

    await Future.delayed(400.ms);
    emit(GameReadyState(
      question.text,
      question.rightAnswers,
      question.wrongAnswers,
      me,
      enemy,
      0,
    ));

    await Future.delayed(2500.ms);
    emit(PlayerTurnState(me, enemy, true));
  }
}
