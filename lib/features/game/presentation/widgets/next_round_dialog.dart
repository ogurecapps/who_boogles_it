import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:who_boogles_it/app/app_size.dart';
import 'package:who_boogles_it/core/models/player.dart';
import 'package:who_boogles_it/features/game/presentation/bloc/game_bloc.dart';
import 'package:who_boogles_it/generated/locale_keys.g.dart';

class NextRoundDialog extends StatefulWidget {
  final bool winnerIsMe;
  final List<(Player, int, int)> players;

  const NextRoundDialog({
    super.key,
    required this.winnerIsMe,
    required this.players,
  });

  @override
  State<NextRoundDialog> createState() => _NextRoundDialogState();
}

class _NextRoundDialogState extends State<NextRoundDialog> {
  static const EdgeInsetsGeometry padding = EdgeInsets.symmetric(horizontal: 8, vertical: 4);
  TableRow buildTableRow(Player player, int roundScore, int totalScore) {
    return TableRow(
      children: [
        TableCell(
          child: Padding(
            padding: padding,
            child: Text(
              '${player.nickname} (${LocaleKeys.levelShort.tr()} ${player.getLevelStats().level})',
              style: TextStyle(color: player.getLevelStats().grade),
            ),
          ),
        ),
        TableCell(
          child: Padding(
            padding: padding,
            child: Text(roundScore > 0 ? '+$roundScore' : '0', textAlign: TextAlign.right),
          ),
        ),
        TableCell(
          child: Padding(
            padding: padding,
            child: Text(totalScore.toString(), textAlign: TextAlign.right),
          ),
        )
      ],
    );
  }

  TableRow buildTableHeader() {
    return TableRow(children: [
      TableCell(
        child: Padding(
          padding: padding,
          child: const Text(LocaleKeys.columnName, textAlign: TextAlign.center).tr(),
        ),
      ),
      TableCell(
        child: Padding(
          padding: padding,
          child: const Text(LocaleKeys.columnRound, textAlign: TextAlign.center).tr(),
        ),
      ),
      TableCell(
        child: Padding(
          padding: padding,
          child: const Text(LocaleKeys.columnTotal, textAlign: TextAlign.center).tr(),
        ),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(AppSize.dialogPadding),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.winnerIsMe ? LocaleKeys.win : LocaleKeys.lose,
                style: Theme.of(context).textTheme.titleLarge,
              )
                  .tr()
                  .animate()
                  .slideY(delay: 200.ms, begin: 0.3, end: 0, curve: Curves.fastOutSlowIn)
                  .fadeIn(delay: 200.ms),
              const Text(LocaleKeys.subtotals)
                  .tr()
                  .animate()
                  .slideX(delay: 400.ms, duration: 400.ms, begin: 0.1, end: 0, curve: Curves.fastOutSlowIn)
                  .fadeIn(delay: 400.ms, duration: 400.ms),
              const SizedBox(height: AppSize.defaultSpace / 2),
              Table(
                border: TableBorder.all(color: Theme.of(context).primaryColor, width: AppSize.buttonBorder),
                columnWidths: const <int, TableColumnWidth>{
                  0: FlexColumnWidth(6),
                  1: FlexColumnWidth(2),
                  2: FlexColumnWidth(2),
                },
                children: [
                  buildTableHeader(),
                  for ((Player, int, int) player in widget.players)
                    buildTableRow(player.$1, player.$2, player.$3),
                ],
              )
                  .animate()
                  .slideX(delay: 600.ms, duration: 400.ms, begin: 0.1, end: 0, curve: Curves.fastOutSlowIn)
                  .fadeIn(delay: 600.ms, duration: 400.ms),
              const SizedBox(height: AppSize.defaultSpace * 2),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    context.read<GameBloc>().add(NextRoundEvent());
                    Navigator.of(context).pop();
                  },
                  child: const Text(LocaleKeys.continueButton).tr(),
                ).animate().flip(
                      delay: 800.ms,
                      curve: Curves.fastOutSlowIn,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
