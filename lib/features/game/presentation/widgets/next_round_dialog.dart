import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:who_boogles_it/app/app_size.dart';
import 'package:who_boogles_it/core/models/player.dart';
import 'package:who_boogles_it/generated/locale_keys.g.dart';

class NextRoundDialog extends StatefulWidget {
  final bool isWinnerMe;
  final List<(Player, int)> players;

  const NextRoundDialog({
    super.key,
    required this.isWinnerMe,
    required this.players,
  });

  @override
  State<NextRoundDialog> createState() => _NextRoundDialogState();
}

class _NextRoundDialogState extends State<NextRoundDialog> {
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
                "Победа!",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const Text(LocaleKeys.tabTitle).tr(),
              Table(
                border: TableBorder.all(color: Theme.of(context).primaryColor, width: AppSize.buttonBorder),
                columnWidths: const <int, TableColumnWidth>{
                  0: FlexColumnWidth(4),
                  1: FlexColumnWidth(1),
                },
                children: const [
                  TableRow(
                    children: [
                      TableCell(
                        child: Padding(
                          padding: EdgeInsets.only(left: AppSize.defaultSpace / 2),
                          child: Text("Player 1"),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding: EdgeInsets.only(right: AppSize.defaultSpace / 2),
                          child: Text("100", textAlign: TextAlign.right),
                        ),
                      )
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(
                        child: Padding(
                          padding: EdgeInsets.only(left: AppSize.defaultSpace / 2),
                          child: Text("Player 2"),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding: EdgeInsets.only(right: AppSize.defaultSpace / 2),
                          child: Text("2000", textAlign: TextAlign.right),
                        ),
                      )
                    ],
                  )
                ],
              ),
              const SizedBox(height: AppSize.defaultSpace * 2),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => {},
                  child: const Text(LocaleKeys.continueButton).tr(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
