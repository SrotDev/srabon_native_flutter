import 'dart:ui';
import 'package:flutter/material.dart';

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
                    _buildDrawerTile(context, 'H O M E', '/getstarted'),
                    _buildDrawerTile(context, 'L O G I N', '/login'),
                    _buildDrawerTile(context, 'D A S H B O A R D', '/dashboard'),
                    _buildDrawerTile(context, 'C H A T', '/chat'),
                    _buildDrawerTile(context, 'C O U R S E S', '/courses'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerTile(BuildContext context, String title, String route) {
    return ListTile(
      title: Text(title, textAlign: TextAlign.center),
      onTap: () {
        Navigator.pushNamed(context, route);
      },
    );
  }
}
