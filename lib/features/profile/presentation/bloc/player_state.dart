part of 'player_bloc.dart';

sealed class PlayerState extends Equatable {
  const PlayerState();

  @override
  List<Object> get props => [];
}

final class PlayerInitialState extends PlayerState {}

final class PlayerRefreshState extends PlayerState {}

final class PlayerReadyState extends PlayerState {
  final Widget avatar;
  final String nickname;
  final int level;
  final Color levelGrade;
  final double levelIndicatorValue;
  final String levelIndicatorLegend;

  const PlayerReadyState(this.avatar, this.nickname, this.level, this.levelGrade, this.levelIndicatorValue,
      this.levelIndicatorLegend);

  @override
  List<Object> get props => [nickname];
}
