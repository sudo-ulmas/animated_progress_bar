import 'dart:math';
import 'dart:ui';

import 'package:animated_progress/half_arc.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _stripeAnimationController;
  late Animation<double> _animation;
  late double barWidth;

  @override
  void initState() {
    barWidth = window.physicalSize.shortestSide * 0.45;
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
      lowerBound: 0,
      upperBound: 100,
    );

    _stripeAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
      lowerBound: 0,
      upperBound: barWidth,
    )..repeat();

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    barWidth = MediaQuery.of(context).size.width * 0.9;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.3),
                  ),
                  width: barWidth,
                  height: 20,
                ),
                AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) => Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.7),
                        ),
                        width: barWidth * _animationController.value * 0.01,
                        height: 20,
                      ),
                      for (int i = 0; i <= barWidth ~/ 15; i += 1)
                        AnimatedBuilder(
                          animation: _stripeAnimationController,
                          builder: (context, child) => Positioned(
                            left: (i * 15 - _stripeAnimationController.value) <
                                    -15
                                ? (barWidth +
                                    i * 15 -
                                    _stripeAnimationController.value)
                                : i * 15 - _stripeAnimationController.value,
                            child: Transform(
                              transform: Matrix4.skewX(0.7),
                              child: Container(
                                height: 20,
                                width: 6,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: CustomPaint(
                    painter: RightBorder(),
                    size: const Size(20, 20),
                  ),
                ),
                Positioned(
                  left: 0,
                  top: 0,
                  child: CustomPaint(
                    painter: LeftBorder(),
                    size: const Size(20, 20),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50),
            ElevatedButton(
                onPressed: () async {
                  _animationController.forward(from: 0);
                  var random = Random();
                  var pauseAtFirst = random.nextInt(3700) + 200;
                  var pauseAtSecond = random.nextInt(3900 - pauseAtFirst);
                  var pauseForFirst = random.nextInt(1000) + 1000;
                  var pauseForSecond = random.nextInt(1000) + 1000;
                  await Future.delayed(Duration(milliseconds: pauseAtFirst));
                  print('paused first');
                  _animationController.stop(canceled: false);
                  await Future.delayed(Duration(milliseconds: pauseForFirst));
                  print('release first');
                  _animationController.forward(
                      from: _animationController.value);
                  await Future.delayed(Duration(milliseconds: pauseAtSecond));
                  print('pause second');
                  _animationController.stop(canceled: false);
                  await Future.delayed(Duration(milliseconds: pauseForSecond));
                  print('release second');
                  _animationController.forward(
                      from: _animationController.value);
                },
                child: const Text('Start')),
          ],
        ),
      ),
    );
  }
}
