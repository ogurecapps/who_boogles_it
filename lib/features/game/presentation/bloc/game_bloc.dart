import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:who_boogles_it/core/di/locator.dart';
import 'package:who_boogles_it/features/game/domain/use_cases/get_question_use_case.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  final GetQuestionUseCase _getQuestionUseCase = locator.get<GetQuestionUseCase>();

  GameBloc() : super(GameInitialState()) {
    on<LoadGameEvent>(_loadQuestion);
  }

  Future<void> _loadQuestion(LoadGameEvent event, Emitter<GameState> emit) async {
    try {
      final question = await _getQuestionUseCase.execute(event.langCode);
      await Future.delayed(400.ms);
      emit(GameReadyState(question.text, question.rightAnswers.toSet(), question.wrongAnswers.toSet()));
    } catch (e) {
      log(e.toString());
    }
  }
}
