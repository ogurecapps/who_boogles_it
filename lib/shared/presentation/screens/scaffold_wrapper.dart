import 'package:flutter/material.dart';
import 'package:who_boogles_it/app/app_size.dart';
import 'package:who_boogles_it/shared/presentation/widgets/abstract_background.dart';

/// Background can be Color, Image, or Widget
class ScaffoldWrapper extends StatelessWidget {
  const ScaffoldWrapper(
      {Key? key,
      required this.body,
      this.background,
      this.padding = const EdgeInsets.all(AppSize.defaultSpace)})
      : super(key: key);

  final Widget body;
  final Object? background;
  final EdgeInsets padding;

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
      backClass = (background ?? const AbstractBackground()) as Widget?; // default
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
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
