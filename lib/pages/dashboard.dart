// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:srabon/pages/appbar.dart';
import 'package:srabon/pages/chat.dart';
import 'package:srabon/pages/courses_page.dart';
import 'package:srabon/pages/course_page_creation.dart';
import 'package:srabon/pages/drawer.dart';
import 'package:srabon/pages/explore.dart';
import 'package:srabon/pages/getstarted.dart';
import 'package:srabon/pages/login.dart';
import 'package:srabon/pages/splashscreen.dart';
import 'dart:ui';

void main() {
  runApp(const Dashboard());
}

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String name = "John";

  List<String> subjects = ["Physics", "Chemistry", "Math", "A"];
  bool isBangla = false;

  void toggleLanguage(bool value) {
    setState(() {
      isBangla = value;
    });
    // You can add logic to switch app language here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isBangla: isBangla,
        onLanguageToggle: toggleLanguage,
      ),
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset("assets/main.jpg", fit: BoxFit.cover),
          ),

          // Semi-transparent overlay (optional)
          Positioned.fill(
            child: Container(color: Color.fromARGB(3, 28, 172, 163)),
          ),

          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 221, 243, 240),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(color: Colors.black, blurRadius: 5),
                        ],
                      ),
                      child: Row(
                        children: [
                          Image.asset('assets/bot.png', width: 130),
                          Expanded(
                            // Make sure text column uses available space
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10.0,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "Hey, $name!",
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    softWrap: true,
                                  ),
                                  SizedBox(height: 15),
                                  Text(
                                    "What would you like to study today?",
                                    style: TextStyle(fontSize: 18),
                                    softWrap: true,
                                    overflow: TextOverflow.visible,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(color: Colors.black, blurRadius: 5),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: 15),
                            Text(
                              "♥️ Create Your Own Course",
                              textAlign: TextAlign.center,

                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 15),
                            Text(
                              "Choose topics you love and we’ll build a course just for you.",
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 15),
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
                                            milliseconds: 400,
                                          ),
                                          pageBuilder: (_, __, ___) =>
                                              CourseCreatePage(),
                                          transitionsBuilder:
                                              (_, animation, __, child) {
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
                                        horizontal: 16,
                                        vertical: 10,
                                      ),
                                      child: Text(
                                        "S T A R T   N O W",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 15),
                          ],
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20.0,
                      right: 20.0,
                      top: 20,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 221, 243, 240),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(color: Colors.black, blurRadius: 5),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: 15),
                            Text(
                              "🧠 Solve your doubts with আভা",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 15),
                            Text(
                              "Our intelligent assistant is ready to help you understand tough topics, answer tricky questions, or even summarize lessons for you.",
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 15),
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
                                            milliseconds: 400,
                                          ),
                                          pageBuilder: (_, __, ___) =>
                                              Chat(),
                                          transitionsBuilder:
                                              (_, animation, __, child) {
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
                                        horizontal: 16,
                                        vertical: 10,
                                      ),
                                      child: Text(
                                        "T A L K   N O W",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 15),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(color: Colors.black, blurRadius: 5),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: 15),
                            Text(
                              "☑️ Your Courses",
                              textAlign: TextAlign.center,

                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 15),
                            Text(
                              "Access and manage the courses you've created or uploaded.",
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 15),
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
                                            milliseconds: 400,
                                          ),
                                          pageBuilder: (_, __, ___) =>
                                              CoursesPage(),
                                          transitionsBuilder:
                                              (_, animation, __, child) {
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
                                        horizontal: 16,
                                        vertical: 10,
                                      ),
                                      child: Text(
                                        "B R O W S E",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 15),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15,),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 218, 242, 240),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(color: Colors.black, blurRadius: 5),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: 15),
                            Text(
                              "🗺️ Explore Community Courses",
                              textAlign: TextAlign.center,

                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 15),
                            Text(
                              "Discover and learn from courses created by other users.",
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 15),
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
                                            milliseconds: 400,
                                          ),
                                          pageBuilder: (_, __, ___) =>
                                              Explore(),
                                          transitionsBuilder:
                                              (_, animation, __, child) {
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
                                        horizontal: 16,
                                        vertical: 10,
                                      ),
                                      child: Text(
                                        "E X P L O R E",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 15),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20.0,
                      right: 20.0,
                      top: 20,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(color: Colors.black, blurRadius: 5),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: 15),
                            Text(
                              "⭐ Selected Subjects",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 15),
                            Container(
                              width: double.infinity,
                              child: AllSubjects(
                                subjectList: [
                                  "Math",
                                  "Chemistry",
                                  "Physics",
                                  "Geography",
                                ],
                              ),
                            ),

                            SizedBox(height: 13),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  
                ],
              ),
            ),
          ),
        ],
      ),

      drawer: CustomDrawer()
    );
  }
}

class AllSubjects extends StatelessWidget {
  final List<String> subjectList;

  const AllSubjects({required this.subjectList});

  @override
  Widget build(BuildContext context) {
    final List<Color> colors = [
      Colors.blueAccent,
      Colors.greenAccent,
      Colors.orangeAccent,
      Colors.purpleAccent,
      Colors.redAccent,
      Colors.tealAccent,
      Colors.amberAccent,
    ];

    return Padding(
      padding: const EdgeInsets.only(left: 10.0, bottom: 10.0),
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        alignment: WrapAlignment.start,
        children: List.generate(subjectList.length, (index) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: colors[index % colors.length], // cycle through colors
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              subjectList[index],
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
          );
        }),
      ),
    );
  }
}
