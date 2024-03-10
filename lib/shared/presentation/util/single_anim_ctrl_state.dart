import 'package:flutter/material.dart';
import 'package:who_boogles_it/core/di/locator.dart';

class SingleAnimCtrlState extends State with RouteAware, SingleTickerProviderStateMixin {
  late final AnimationController controller;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      locator.get<RouteObserver<ModalRoute>>().subscribe(this, ModalRoute.of(context)!);
    });
    controller = AnimationController(vsync: this);

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _onScreenShow() {
    controller.reset();
    controller.forward();
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
