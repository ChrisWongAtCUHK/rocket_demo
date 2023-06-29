import 'package:flutter/material.dart';

const _speedOfLight = 100;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController =
      AnimationController(vsync: this, duration: const Duration(seconds: 5));

  late final Animation _textAnimation = IntTween(begin: 0, end: _speedOfLight)
      .animate(CurvedAnimation(
          parent: _animationController,
          curve: Curves.easeOut,
          reverseCurve: Curves.easeIn));

  late final Animation _colorAnimation =
      ColorTween(begin: Colors.green, end: Colors.amber)
          .animate(_animationController);

  late final Animation _sizeAnimation = Tween(
    begin: 200.0,
    end: 300.0,
  ).animate(_animationController);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              '🚀',
              style: theme.textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            AnimatedBuilder(
                animation: _animationController,
                builder: (BuildContext context, _) {
                  return Center(
                    child: Container(
                      color: Colors.red,
                      height: _sizeAnimation.value,
                      width: _sizeAnimation.value,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            _textAnimation.value.toString(),
                            style: theme.textTheme.headlineLarge?.copyWith(
                              fontSize: 70,
                              color: _colorAnimation.value,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                }),
            const Text(
              'm/s',
              textAlign: TextAlign.center,
            ),
            TextButton(
              onPressed: () {
                _animationController.forward();
              },
              child: const Text('Accelerate'),
            ),
            TextButton(
              onPressed: () {
                _animationController.reverse();
              },
              child: const Text('Decelerate'),
            ),
          ],
        ),
      ),
    );
  }
}
