import 'package:flutter/material.dart';
import 'package:who_boogles_it/app/app_size.dart';
import 'package:who_boogles_it/shared/presentation/widgets/abstract_background.dart';

/// Background can be Color, Image, or Widget
class ScaffoldWrapper extends StatelessWidget {
  const ScaffoldWrapper({
    Key? key,
    required this.body,
    this.background,
    this.padding = const EdgeInsets.all(AppSize.defaultSpace),
    this.resizeToAvoidBottomInset = true,
  }) : super(key: key);

  final Widget body;
  final Object? background;
  final EdgeInsets padding;
  final bool resizeToAvoidBottomInset;

  @override
  Widget build(BuildContext context) {
    Color? backColor;
    DecorationImage? backImage;
    Widget? backClass;

    if (background is Color) {
      backColor = background as Color?;
    } else if (background is DecorationImage) {
      backImage = background as DecorationImage?;
    } else {
      backClass = (background ?? const AbstractBackground(brightness: 0.3)) as Widget?; // default
    }

    return Scaffold(
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: backImage,
            color: backColor,
          ),
          child: Stack(
            children: [
              if (backClass != null) backClass,
              Padding(
                padding: padding,
                child: body,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
