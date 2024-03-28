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
  }

  Future<void> _loadGameData(LoadGameEvent event, Emitter<GameState> emit) async {
    late Question question;

    try {
      question = await _getQuestionUseCase.execute(event.langCode);
    } catch (e) {
      log(e.toString());
      return;
    }

    Player me = await _getPlayerUseCase.execute(true);
    Player enemy = await _getPlayerUseCase.execute(false);

    await Future.delayed(400.ms);
    emit(GameReadyState(
      question.text,
      question.rightAnswers.toSet(),
      question.wrongAnswers.toSet(),
      me,
      enemy,
    ));
  }
}
