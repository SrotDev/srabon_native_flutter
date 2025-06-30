import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:srabon/pages/chat.dart';
import 'package:srabon/pages/courses_page.dart';
import 'package:srabon/pages/dashboard.dart';
import 'package:srabon/pages/getstarted.dart';
import 'package:srabon/pages/leaderboard.dart';
import 'package:srabon/pages/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.transparent,
      child: Stack(
        children: [
          // Blurred background with tint
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              color: Colors.white.withOpacity(0.4), // tint color
            ),
          ),
          // Drawer content
          Column(
            children: [
              const SizedBox(height: 80),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image.asset(
                  'assets/srabon-logo.png', // Replace with your logo path
                  height: 50,
                ),
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    //_buildDrawerTile(context, 'H O M E', '/getstarted'),
                    //_buildDrawerTile(context, 'L O G I N', '/login'),
                    _buildDrawerTile(
                      context,
                      'D A S H B O A R D',
                      '/dashboard',
                    ),
                    _buildDrawerTile(context, 'C H A T', '/chat'),
                    _buildDrawerTile(
                      context,
                      'M Y   C O U R S E S',
                      '/courses',
                    ),
                    _buildDrawerTile(
                      context,
                      'L E A D E R B O A R D',
                      '/leaderboard',
                    ),
                    FutureBuilder<String?>(
                      future: getToken(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done &&
                            snapshot.data != null) {
                          return _buildLogOutTile(context, 'L O G   O U T');
                        }
                        return SizedBox.shrink();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _getPageForRoute(String route) {
    switch (route) {
      case '/dashboard':
        return Dashboard();
      case '/chat':
        return Chat(); 
      case '/courses':
        return CoursesPage();
      // Add more cases as needed
      case '/leaderboard':
        return LeaderboardPage();
      default:
        return GetStarted();
    }
  }

  Widget _buildDrawerTile(BuildContext context, String title, String route) {
    return ListTile(
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      onTap: () {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            transitionDuration: Duration(milliseconds: 400),
            pageBuilder: (_, __, ___) => _getPageForRoute(route),
            transitionsBuilder: (_, animation, __, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          ),
        );
      },
    );
  }
}



Widget _buildLogOutTile(BuildContext context, String title) {
  return ListTile(
    title: Text(
      title,
      textAlign: TextAlign.center,
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
    onTap: () {
      logout();
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 400),
          pageBuilder: (_, __, ___) => GetStarted(),
          transitionsBuilder: (_, animation, __, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      );
    },
  );
}
