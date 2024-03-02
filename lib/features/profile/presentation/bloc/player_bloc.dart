import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:who_boogles_it/core/di/locator.dart';
import 'package:who_boogles_it/core/models/player.dart';
import 'package:who_boogles_it/features/profile/domain/use_cases/get_player_use_case.dart';
import 'package:who_boogles_it/features/profile/domain/use_cases/get_random_use_case.dart';

part 'player_event.dart';
part 'player_state.dart';

class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  final GetPlayerUseCase _getPlayerUseCase = locator.get<GetPlayerUseCase>();
  final GetRandomUseCase _getRandomUseCase = locator.get<GetRandomUseCase>();

  PlayerBloc() : super(PlayerInitialState()) {
    on<GetPlayerEvent>(_getPlayer);
    on<RandomPlayerEvent>(_getRandomPlayer);
  }

  Future<void> _getRandomPlayer(PlayerEvent event, Emitter<PlayerState> emit) async {
    emit(PlayerRefreshState());
    final player = await _getRandomUseCase.execute();
    emit(PlayerReadyState(player));
  }

  Future<void> _getPlayer(PlayerEvent event, Emitter<PlayerState> emit) async {
    final player = await _getPlayerUseCase.execute();
    emit(PlayerReadyState(player));
  }
}
