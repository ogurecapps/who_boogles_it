import 'package:flutter/material.dart';

/// Literally abstract, like abstract art
class AbstractBackground extends StatelessWidget {
  const AbstractBackground({super.key});

  static const palette = (
    Color(0xff39b8c2),
    Color(0xff62698f),
    Color(0xfffc6999),
    Color(0xff8ce5a4),
  );

  static List<({int rootFlex, List<({int flex, List<Color> colors})> boxes})> blueprint = [
    (
      rootFlex: 2,
      boxes: [
        (flex: 1, colors: [palette.$4]),
        (flex: 8, colors: [palette.$1]),
      ]
    ),
    (
      rootFlex: 4,
      boxes: [
        (flex: 2, colors: [palette.$2]),
        (flex: 2, colors: [palette.$3, palette.$4]),
        (flex: 5, colors: [palette.$2]),
      ]
    ),
    (
      rootFlex: 4,
      boxes: [
        (flex: 5, colors: [palette.$1]),
        (flex: 2, colors: [palette.$3, palette.$2]),
        (flex: 2, colors: [palette.$4]),
      ]
    ),
    (
      rootFlex: 1,
      boxes: [
        (flex: 7, colors: [palette.$3]),
        (flex: 1, colors: [palette.$1]),
        (flex: 1, colors: [palette.$3]),
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
