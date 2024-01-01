import 'dart:async';
import 'dart:math';

import 'package:covid19_tracker/screen/world_states.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 10), vsync: this)
        ..repeat();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  void initState() {
    super.initState();

    Timer(
      const Duration(seconds: 5),
      () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const WorldStatesScreen(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(36, 255, 67, 10),
      body: SafeArea(
        child: Center(
          child: AnimatedBuilder(
            animation: _controller,
            child: const SizedBox(
              height: 200,
              width: 200,
              child: Center(
                child: Image(
                  image: AssetImage('images/corona.png'),
                ),
              ),
            ),
            builder: (context, child) {
              return Transform.rotate(
                angle: _controller.value * 2.0 * pi,
                child: child,
              );
            },
          ),
        ),
      ),
    );
  }
}
