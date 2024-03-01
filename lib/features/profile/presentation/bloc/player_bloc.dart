import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:who_boogles_it/core/di/locator.dart';
import 'package:who_boogles_it/core/models/player.dart';
import 'package:who_boogles_it/features/profile/domain/use_cases/get_player_use_case.dart';

part 'player_event.dart';
part 'player_state.dart';

class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  final GetPlayerUseCase _getPlayerUseCase = locator.get<GetPlayerUseCase>();

  PlayerBloc() : super(PlayerInitialState()) {
    on<GetPlayerEvent>(_getPlayer);
  }

  Future<void> _getPlayer(GetPlayerEvent event, Emitter<PlayerState> emit) async {
    final player = await _getPlayerUseCase.execute();
    emit(PlayerReadyState(player));
  }
}
