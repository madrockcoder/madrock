import 'dart:math';

import 'package:flutter/material.dart';

// USAGE:
//
// customLoaderController = CustomLoaderController()
// ..initialize(this, const Duration(milliseconds: 1000))
// ..start();
//
// ...
//
// CustomLoader(size: 104, controller: customLoaderController)),

class CustomLoaderController {
  late AnimationController controller;

  void initialize(vsync, Duration speed) {
    controller = AnimationController(vsync: vsync, duration: speed);
  }

  void start({bool reverse = false}) {
    controller.repeat(reverse: reverse);
  }

  void stop() {
    controller.stop();
  }
}

class CustomLoaderScreen extends StatefulWidget {
  const CustomLoaderScreen({Key? key}) : super(key: key);

  static Future<void> show(BuildContext context) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const CustomLoaderScreen(),
      ),
    );
  }

  @override
  State<CustomLoaderScreen> createState() => _CustomLoaderScreenState();
}

class _CustomLoaderScreenState extends State<CustomLoaderScreen> with TickerProviderStateMixin {
  late CustomLoaderController customLoaderController;
  @override
  void dispose() {
    customLoaderController.stop();
    super.dispose();
  }
  @override
  void initState() {
    customLoaderController = CustomLoaderController()
      ..initialize(this, const Duration(milliseconds: 1000))
      ..start();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: CustomLoader(
              size: 104, controller: customLoaderController)),
    );
  }
}


class CustomLoader extends StatefulWidget {
  final double size;
  final CustomLoaderController controller;

  const CustomLoader({Key? key, required this.size, required this.controller})
      : super(key: key);

  @override
  _CustomLoaderState createState() => _CustomLoaderState();
}

class _CustomLoaderState extends State<CustomLoader> {
  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: Tween(begin: 0.0, end: 1.0).animate(widget.controller.controller),
      child: Transform(
        transform: Matrix4.rotationY(pi),
        alignment: Alignment.center,
        child: Image.asset("assets/images/custom_loader.png",
            width: widget.size / 1.8),
      ),
    );
  }
}