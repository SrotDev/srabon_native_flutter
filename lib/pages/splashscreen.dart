import 'package:flutter/material.dart';
import 'dart:async';

import 'package:srabon/pages/getstarted.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();

    // Scale animation
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..forward();

    _scale = Tween<double>(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    // Navigate after delay
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 1200),
          pageBuilder: (_, __, ___) => GetStarted(),
          transitionsBuilder: (_, animation, __, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image or color
          Positioned.fill(
            child: Image.asset(
              "assets/main.jpg", // Your background image
              fit: BoxFit.cover,
            ),
          ),
          // Centered animated logo
          Center(
            child: ScaleTransition(
              scale: _scale,
              child: Image.asset(
                "assets/srabon-logo.png", // Your logo
                width: 150,
                height: 150,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
