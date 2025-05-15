import 'dart:async';
import 'package:flutter/material.dart';
import 'game_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _glowController;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();

    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _glowAnimation = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(parent: _glowController, curve: Curves.easeInOut),
    );

    Timer(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const GameScreen()), // 👈 Replace this
      );
    });
  }

  @override
  void dispose() {
    _glowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: AnimatedBuilder(
          animation: _glowAnimation,
          builder: (context, _) {
            return Text(
              'Tic Tac Toe',
              style: TextStyle(
                fontSize: 52,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
                color: Colors.white,
                shadows: [
                  Shadow(
                    blurRadius: 30 * _glowAnimation.value,
                    color: Colors.white.withOpacity(_glowAnimation.value),
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
