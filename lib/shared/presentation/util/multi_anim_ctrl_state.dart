import 'package:flutter/material.dart';
import 'package:who_boogles_it/core/di/locator.dart';

class MultiAnimCtrlState extends State with RouteAware, TickerProviderStateMixin {
  List<AnimationController> controllers = [];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      locator.get<RouteObserver<ModalRoute>>().subscribe(this, ModalRoute.of(context)!);
    });
    super.initState();
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _onScreenShow() {
    for (var controller in controllers) {
      controller.reset();
      controller.forward();
    }
  }

  @override
  void didPopNext() {
    _onScreenShow();
    super.didPopNext();
  }

  @override
  void didPush() {
    _onScreenShow();
    super.didPush();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
