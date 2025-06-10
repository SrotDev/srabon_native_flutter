import 'package:flutter/material.dart';
import 'package:srabon/pages/appbar.dart';
import 'dart:async';

import 'package:srabon/pages/login.dart';

///TO_DO
///make "Start learning with us now" more pretty

class GetStarted extends StatefulWidget {
  _GetStartedState createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  bool isBangla = false;
  void toggleLanguage(bool value) {
    setState(() {
      isBangla = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isBangla: isBangla,
        onLanguageToggle: toggleLanguage,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: Image.asset("assets/main.jpg", fit: BoxFit.cover),
          ),

          // Semi-transparent overlay (optional)
          Positioned.fill(
            child: Container(color: Color.fromARGB(3, 54, 255, 242)),
          ),

          Positioned.fill(
            child: Column(
              // mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset('assets/get_started_book.png', width: 250),
                ),
                Center(
                  child: Text(
                    "START LEARNING",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40.0,
                      fontFamily: 'Sans Serif',
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    "WITH US NOW",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40.0,
                      fontFamily: 'Sans Serif',
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, top: 23),
                  child: Text(
                    "An inclusive, gamified learning web app for secondary schoolers that personalizes science education through storytelling, quizzes, and AI-generated courses with multilingual and accessibility support.",
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 35),
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color.fromARGB(255, 25, 219, 193),
                          const Color.fromARGB(255, 89, 248, 211),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(30),
                        onTap: () {
                          
                            Navigator.of(context).pushReplacement(
                              PageRouteBuilder(
                                transitionDuration: Duration(
                                  milliseconds: 500,
                                ),
                                pageBuilder: (_, __, ___) => Login(),
                                transitionsBuilder: (_, animation, __, child) {
                                  return FadeTransition(
                                    opacity: animation,
                                    child: child,
                                  );
                                },
                              ),
                            );
                          
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 12,
                          ),
                          child: Text(
                            "G E T  S T A R T E D",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color.fromARGB(255, 214, 214, 214),
                          const Color.fromARGB(255, 242, 255, 252),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(30),
                        onTap: () {},
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 12,
                          ),
                          child: Text(
                            "L E A R N  M O R E",
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
