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

  @override
  void didPopNext() {
    controller.reset();
    controller.forward();
    super.didPopNext();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
