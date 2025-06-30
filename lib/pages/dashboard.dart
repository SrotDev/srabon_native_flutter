// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:srabon/pages/appbar.dart';
import 'package:srabon/pages/chat.dart';
import 'package:srabon/pages/courses_page.dart';
import 'package:srabon/pages/course_page_creation.dart';
import 'package:srabon/pages/drawer.dart';
import 'package:srabon/pages/explore.dart';
import 'package:srabon/pages/getstarted.dart';
import 'package:srabon/pages/login.dart';
import 'package:srabon/pages/splashscreen.dart';
import 'package:srabon/pages/ApiService.dart';
import 'dart:ui';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
int? grade;
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

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  ApiService auth = new ApiService();
  bool _loading = true;
  Map<String, dynamic>? infos;
  String name = "John";
  List<String> subjects = ["Physics", "Chemistry", "Math", "A"];
  bool isBangla = false;

  void toggleLanguage(bool value) {
    setState(() {
      isBangla = value;
    });
    // You can add logic to switch app language here
  }

  Future<void> _getInfo() async {
    infos = await auth.getStudentInfo();
    if (!mounted) return;

    if (infos?['name'] == null) {
      //notify

      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 400),
          pageBuilder: (_, __, ___) => Login(),
          transitionsBuilder: (_, animation, __, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      );
    } else {
      setState(() {
        name = infos?['name'];
        subjects = List<String>.from(infos?['subjects']);
        grade = infos?['class'];
        _loading = false;
      });
    }
    //if ()
  }

  @override
  void initState() {
    super.initState();
    _loadTokenAndSet();
  }

  Future<void> _loadTokenAndSet() async {
    final token = await getToken();
    if (token != null) {
      auth.setToken(token);
    }
    _getInfo();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return Scaffold(
        appBar: CustomAppBar(
          isBangla: isBangla,
          onLanguageToggle: toggleLanguage,
        ),
        resizeToAvoidBottomInset: true,
        body: Stack(
          children: [
            Positioned.fill(
              child: Image.asset("assets/main.png", fit: BoxFit.cover),
            ),

            // Semi-transparent overlay (optional)
            Positioned.fill(
              child: Container(color: Color.fromARGB(3, 28, 172, 163)),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SpinKitChasingDots(color: Colors.blue),
                  SizedBox(height: 20),
                  Text(
                    "Loading Dashboard...",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      //fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
    return Scaffold(
      appBar: CustomAppBar(
        isBangla: isBangla,
        onLanguageToggle: toggleLanguage,
      ),
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset("assets/main.png", fit: BoxFit.cover),
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
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF183059),
                          image: DecorationImage(
                            image: AssetImage('assets/own_course_back_con.png'),
                            fit: BoxFit.contain,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black,
                              blurRadius: 10,
                              offset: Offset(2, 2),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 25.0,
                            vertical: 20,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 0.0,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "YOUR COURSES",
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  softWrap: true,
                                ),
                                SizedBox(height: 8),
                                Text(
                                  "Study and manage the courses you're enrolled in",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w200,
                                  ),
                                  softWrap: true,
                                  overflow: TextOverflow.visible,
                                ),
                                SizedBox(height: 29),
                                GestureDetector(
                                  onTap: () async {
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
                                  child: Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          const Color(0xFFA698CD),
                                          const Color(0xFF8AD8F0),
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(
                                          30,
                                        ),
                          
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 20,
                                            vertical: 8,
                                          ),
                                          child: Text(
                                            "B R O W S E",
                                            style: TextStyle(
                                              color: const Color(0xFF183059),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF84E6F8),
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          image: AssetImage('assets/bot.png'),
                          fit: BoxFit.cover,
                        ),

                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(255, 136, 136, 136),
                            blurRadius: 20,
                            offset: Offset(4, 4),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 25.0,
                          vertical: 8,
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 10),
                            Text(
                              "Chat with আভা                ",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            Text(
                              "Talk with AI assistant about your doubts and lessons",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontSize: 18,
                                //fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 15),
                            Align(
                              alignment: Alignment.centerRight,
                              child: GestureDetector(
                                onTap: () async {
                                  Navigator.of(context).pushReplacement(
                                    PageRouteBuilder(
                                      transitionDuration: Duration(
                                        milliseconds: 400,
                                      ),
                                      pageBuilder: (_, __, ___) => Chat(),
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
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        const Color(0xFF72397C),
                                        const Color(0xFFBA4098),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(30),

                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 20,
                                          vertical: 8,
                                        ),
                                        child: Text(
                                          "C H A T",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
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
                  SizedBox(height: 20),

                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFD9D9D9),
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          image: AssetImage('assets/boi.png'),
                          fit: BoxFit.contain,
                          opacity: 0.6,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(255, 136, 136, 136),
                            blurRadius: 20,
                            offset: Offset(4, 4),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Column(
                          //crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: 15),
                            Text(
                              "Create your own course",
                              textAlign: TextAlign.left,

                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "Choose a topic you love and we’ll build a course just for you!",
                              style: TextStyle(fontSize: 18),
                              textAlign: TextAlign.left,
                            ),
                            SizedBox(height: 15),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: GestureDetector(
                                onTap: () async {
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
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        const Color(0xFFB08A99),
                                        const Color(0xFFD73945),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(30),

                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 20,
                                          vertical: 8,
                                        ),
                                        child: Text(
                                          "L E T S  G O !",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
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

                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 189, 62, 149),
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          image: AssetImage('assets/pipol.png'),
                          opacity: 0.6,
                          fit: BoxFit.cover,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(255, 136, 136, 136),
                            blurRadius: 20,
                            offset: Offset(4, 4),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 23.0),
                        child: Column(
                          //crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: 15),
                            Text(
                              "Explore Community Courses",
                              textAlign: TextAlign.right,

                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "Discover and learn from courses created by other users.",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                              textAlign: TextAlign.right,
                            ),
                            SizedBox(height: 15),
                            Align(
                              alignment: Alignment.centerRight,
                              child: GestureDetector(
                                onTap: () async {
                                  Navigator.of(context).pushReplacement(
                                    PageRouteBuilder(
                                      transitionDuration: Duration(
                                        milliseconds: 400,
                                      ),
                                      pageBuilder: (_, __, ___) => Chat(),
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
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        const Color(0xFFA698CD),
                                        const Color(0xFF8AD8F0),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(30),

                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 20,
                                          vertical: 8,
                                        ),
                                        child: Text(
                                          "E X P L O R E",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
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
                  // Padding(
                  //   padding: const EdgeInsets.only(
                  //     left: 20.0,
                  //     right: 20.0,
                  //     top: 20,
                  //   ),
                  //   child: Container(
                  //     decoration: BoxDecoration(
                  //       color: Colors.white,
                  //       borderRadius: BorderRadius.circular(20),
                  //       boxShadow: [
                  //         BoxShadow(color: Colors.black, blurRadius: 5),
                  //       ],
                  //     ),
                  //     child: Padding(
                  //       padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  //       child: Column(
                  //         crossAxisAlignment: CrossAxisAlignment.center,
                  //         children: [
                  //           SizedBox(height: 15),
                  //           Text(
                  //             "⭐ Selected Subjects",
                  //             textAlign: TextAlign.center,
                  //             style: TextStyle(
                  //               fontSize: 22,
                  //               fontWeight: FontWeight.bold,
                  //             ),
                  //           ),
                  //           SizedBox(height: 15),
                  //           Container(
                  //             width: double.infinity,
                  //             child: AllSubjects(subjectList: subjects),
                  //           ),

                  //           SizedBox(height: 13),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  SizedBox(height: 70),
                ],
              ),
            ),
          ),
        ],
      ),

      drawer: CustomDrawer(),
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
