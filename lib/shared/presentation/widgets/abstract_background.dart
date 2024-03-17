import 'package:flutter/material.dart';
import 'package:who_boogles_it/app/app_color.dart';

/// Literally abstract, like abstract art
class AbstractBackground extends StatelessWidget {
  const AbstractBackground({super.key});

  static final List<({int rootFlex, List<({int flex, List<Color> colors})> boxes})> blueprint = [
    (
      rootFlex: 2,
      boxes: [
        (flex: 1, colors: [AppColor.backPalette.$4]),
        (flex: 8, colors: [AppColor.backPalette.$1]),
      ]
    ),
    (
      rootFlex: 4,
      boxes: [
        (flex: 2, colors: [AppColor.backPalette.$2]),
        (flex: 2, colors: [AppColor.backPalette.$3, AppColor.backPalette.$4]),
        (flex: 5, colors: [AppColor.backPalette.$2]),
      ]
    ),
    (
      rootFlex: 4,
      boxes: [
        (flex: 5, colors: [AppColor.backPalette.$1]),
        (flex: 2, colors: [AppColor.backPalette.$3, AppColor.backPalette.$2]),
        (flex: 2, colors: [AppColor.backPalette.$4]),
      ]
    ),
    (
      rootFlex: 1,
      boxes: [
        (flex: 7, colors: [AppColor.backPalette.$3]),
        (flex: 1, colors: [AppColor.backPalette.$1]),
        (flex: 1, colors: [AppColor.backPalette.$3]),
      ]
    ),
  ];

  Widget buildColumn(int rootFlex, List<({int flex, List<Color> colors})> boxes) {
    return Expanded(
      flex: rootFlex,
      child: Column(children: [
        for (var box in boxes)
          Expanded(
            flex: box.flex,
            child: Row(children: [
              for (var color in box.colors)
                Expanded(child: Container(decoration: BoxDecoration(color: color))),
            ]),
          )
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [for (var column in blueprint) buildColumn(column.rootFlex, column.boxes)],
    );
  }
}
