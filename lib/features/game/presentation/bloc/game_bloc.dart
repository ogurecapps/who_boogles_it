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
  int round = 0;

  final GetQuestionUseCase _getQuestionUseCase = locator.get<GetQuestionUseCase>();
  final GetPlayerUseCase _getPlayerUseCase = locator.get<GetPlayerUseCase>();

  GameBloc() : super(GameInitialState()) {
    on<LoadGameEvent>(_loadGameData);
    on<PlayerSaysEvent>(_playerSays);
    on<ProcessAnswerEvent>(_processAnswer);
  }

  Future<void> _processAnswer(ProcessAnswerEvent event, Emitter<GameState> emit) async {
    emit(ProcessAnswerState(event.points));

    await Future.delayed(2000.ms);

    var playerTurn = event.points != 0;
    emit(PlayerTurnState(playerTurn, playerTurn ? me.nickname : enemy.nickname));

    if (!playerTurn) {
      await Future.delayed(1000.ms);
      emit(EnemyWritingState());
    }
  }

  Future<void> _playerSays(PlayerSaysEvent event, Emitter<GameState> emit) async {
    emit(SayAnswerState(event.answer));
    await Future.delayed(2500.ms);
    emit(CheckAnswerState(event.answer)); // Need delay before showing the result
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

    await Future.delayed(400.ms);
    emit(GameReadyState(
      question.text,
      question.rightAnswers,
      question.wrongAnswers,
      me,
      enemy,
    ));

    await Future.delayed(2500.ms);
    emit(PlayerTurnState(true, me.nickname));
  }
}
