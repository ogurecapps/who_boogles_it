import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:who_boogles_it/core/di/locator.dart';
import 'package:who_boogles_it/core/models/player.dart';
import 'package:who_boogles_it/features/profile/domain/use_cases/get_me_use_case.dart';
import 'package:who_boogles_it/features/profile/domain/use_cases/set_my_name_use_case.dart';

part 'player_event.dart';
part 'player_state.dart';

class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  final GetMeUseCase _getPlayerUseCase = locator.get<GetMeUseCase>();
  final SetMyNameUseCase _setPlayerNameUseCase = locator.get<SetMyNameUseCase>();

  PlayerBloc() : super(PlayerInitialState()) {
    on<GetPlayerEvent>(_getPlayer);
    on<RandomPlayerNameEvent>(_updatePlayerName);
    on<SetPlayerNameEvent>(_updatePlayerName);
  }

  Future<void> _updatePlayerName(PlayerEvent event, Emitter<PlayerState> emit) async {
    emit(PlayerRefreshState());
    final player = await _setPlayerNameUseCase.execute(name: event is SetPlayerNameEvent ? event.name : '');
    await Future.delayed(100.ms); // bloc rebuild at 60 fps
    emit(_constructReadyState(player));
  }

  PlayerReadyState _constructReadyState(Player player) {
    final LevelStats stats = player.getLevelStats();

    var levelIndicatorLegend = '${player.winCounter}/${stats.level * 3}';
    var levelIndicatorValue = stats.progress / 3;
    return PlayerReadyState(
        player.avatar, player.nickname, stats.level, stats.grade, levelIndicatorValue, levelIndicatorLegend);
  }

  Future<void> _getPlayer(PlayerEvent event, Emitter<PlayerState> emit) async {
    final player = await _getPlayerUseCase.execute();
    emit(_constructReadyState(player));
  }
}
