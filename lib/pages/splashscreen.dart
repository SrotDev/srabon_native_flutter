import 'package:flutter/material.dart';
import 'package:srabon/pages/dashboard.dart';
import 'dart:async';

import 'package:srabon/pages/getstarted.dart';
import 'package:srabon/pages/ApiService.dart';
import 'package:shared_preferences/shared_preferences.dart';

ApiService auth = ApiService();

Future<void> saveToken(String token) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('jwt_token', token);
}

Future<String?> getToken() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('jwt_token');
}

Future<void> logout() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('jwt_token');
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;
  String? token;
  bool validated = false;
  @override
  void initState() {
    super.initState();

    // Scale animation
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..forward();

    _scale = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    // Navigate after delay
    _initAndNavigate();
  }

  Future<void> _initAndNavigate() async {
    token = await getToken();

    if (token != null) {
      auth.setToken(token!);
      validated = true;
    }

    await Future.delayed(Duration(seconds: 3));
    if (!mounted) return;

    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 1200),
        pageBuilder: (_, __, ___) => GetStarted(),
        transitionsBuilder: (_, animation, __, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
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
