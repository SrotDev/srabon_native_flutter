import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:srabon/pages/appbar.dart';
import 'dart:async';
import 'package:srabon/pages/ApiService.dart';
import 'package:srabon/pages/article.dart';
import 'package:srabon/pages/chat.dart';
import 'package:srabon/pages/course_page_creation.dart';
import 'package:srabon/pages/courses_page.dart';
import 'package:srabon/pages/dashboard.dart';
import 'package:srabon/pages/drawer.dart';
import 'package:srabon/pages/exam.dart';
import 'package:srabon/pages/flashcards.dart';
import 'package:srabon/pages/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';


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

class Flashcard {
  final int id;
  final String? keyword;
  final String? explanation;

  Flashcard(this.id, this.keyword, this.explanation);
}

class Question {
  final String? question;
  final String? option1;
  final String? option2;
  final String? option3;
  final String? option4;
  final String? ans;
  final String? explanation;

  Question(
    this.question,
    this.option1,
    this.option2,
    this.option3,
    this.option4,
    this.ans,
    this.explanation,
  );
}

class CourseContent extends StatefulWidget {
  final String id;

  CourseContent({required this.id});

  @override
  _CourseContentState createState() => _CourseContentState();
}

class _CourseContentState extends State<CourseContent> {
  bool _loading = true;
  Map<String, dynamic>? info;
  String? title;
  String? subtitle;
  String? description;
  String? Subject;
  String? coveredTopic;
  String? article;

  List<Flashcard> flashcards = List<Flashcard>.empty();
  List<Question> questions = List<Question>.empty();

  @override
  void initState() {
    super.initState();
    _getAndSetInfos();
  }

  Future<void> _getAndSetInfos() async {
    final token = await getToken();
    if (token != null) {
      auth.setToken(token);

      info = await auth.getCourse(widget.id);

      flashcards = [];
      questions = [];

      setState(() {
        title = info?['title'] ?? '';
        subtitle = info?['subtitle'] ?? '';
        description = info?['description'] ?? '';
        Subject = info?['subject'] ?? '';
        coveredTopic = info?['covered_topic'] ?? '';
        article = info?['article'] ?? '';

        if (info?['flashcards'] != null) {
          int i = 0;
          for (var flashcardMap in info!['flashcards']) {
            String text = flashcardMap.values.first ?? '';
            List<String> parts = text.split(':');
            String? keyword = parts.isNotEmpty ? parts[0].trim() : null;
            String? explanation = parts.length > 1
                ? parts.sublist(1).join(' ').trim()
                : null;
            flashcards.add(
              Flashcard(
                i,
                keyword?.isNotEmpty == true ? keyword : null,
                explanation?.isNotEmpty == true ? explanation : null,
              ),
            );
            i++;
          }
        }

        if (info?["questions"] != null) {
          for (var question in info!['questions']) {
            String q = question['question'] ?? '';
            String o1 = question['option1'] ?? '';
            String o2 = question['option2'] ?? '';
            String o3 = question['option3'] ?? '';
            String o4 = question['option4'] ?? '';
            String ans = question['ans'] ?? '';
            String explanation = question['explanation'] ?? '';

            questions.add(Question(q, o1, o2, o3, o4, ans, explanation));
          }
        }

        _loading = false;
      });
    } else {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    bool isBangla = false;
    void toggleLanguage(bool value) {
      setState(() {
        isBangla = value;
      });
    }

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
                  SpinKitChasingDots(color: Colors.blue, size: 70),
                  SizedBox(height: 20),
                  Text(
                    "Loading Course...",
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

          Column(
            children: [
              Container(
                decoration: BoxDecoration(color: const Color(0xFF183059)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20.0,
                    horizontal: 20,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      // Align(
                      //   alignment: Alignment.centerLeft,
                      //   child: Container(
                      //     decoration: BoxDecoration(
                      //       color: Colors.white,
                      //       borderRadius: BorderRadius.circular(7),
                      //     ),

                      //     child: Icon(Icons.keyboard_double_arrow_left, size: 30,)
                      //   ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Text(
                          "${this.title}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF84E6F8),
                          borderRadius: BorderRadius.circular(10),
                        ),

                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 4.0,
                            vertical: 2,
                          ),
                          child: Text(
                            "${this.Subject} | Grade ${grade}",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ) /* fix thisssssssssssssssssssssssssss */,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(color: Colors.white),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 18),
                child: Column(
                  mainAxisSize: MainAxisSize.max,

                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "My Progress",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "62%",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    LinearProgressIndicator(
                      value: 0.7,
                      color: const Color(0xFFCB429F),
                      minHeight: 4,
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20.0,
                  horizontal: 15,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        Navigator.of(context).pushReplacement(
                          PageRouteBuilder(
                            transitionDuration: Duration(milliseconds: 400),
                            pageBuilder: (_, __, ___) => Article(
                              id: widget.id,
                              title: title,
                              subtitle: subtitle,
                              description: description,
                              article: article,
                              Subject: Subject,
                              flashes: flashcards,
                              queses: this.questions,
                            ),
                            transitionsBuilder: (_, animation, __, child) {
                              return FadeTransition(
                                opacity: animation,
                                child: child,
                              );
                            },
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 15.0,
                          horizontal: 10,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 5,
                              offset: Offset(2, 2),
                            ),
                          ],
                        ),

                        child: Row(
                          //mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 15.0),
                              child: Icon(Icons.file_open_outlined, size: 35),
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "All about ${this.title}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                    ),
                                    maxLines:
                                        1, // or 2, depending on your design
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Article",
                                      style: TextStyle(
                                        color: const Color(0xFFCB429F),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    GestureDetector(
                      onTap: () async {
                        Navigator.of(context).pushReplacement(
                          PageRouteBuilder(
                            transitionDuration: Duration(milliseconds: 400),
                            pageBuilder: (_, __, ___) => ShowFlashcards(
                              id: widget.id,
                              flashes: this.flashcards,
                              title: this.title,
                              Subject: this.Subject,
                              queses: this.questions,
                            ),
                            transitionsBuilder: (_, animation, __, child) {
                              return FadeTransition(
                                opacity: animation,
                                child: child,
                              );
                            },
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 15.0,
                          horizontal: 10,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 5,
                              offset: Offset(2, 2),
                            ),
                          ],
                        ),

                        child: Row(
                          //mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 15.0),
                              child: Icon(Icons.copy, size: 35),
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${this.title}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                    ),
                                    maxLines:
                                        1, // or 2, depending on your design
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Flashcards",
                                      style: TextStyle(
                                        color: const Color(0xFFCB429F),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    GestureDetector(
                      onTap: () async {
                        Navigator.of(context).pushReplacement(
                          PageRouteBuilder(
                            transitionDuration: Duration(milliseconds: 400),
                            pageBuilder: (_, __, ___) => Exam(
                              id: widget.id,
                              title: this.title!,
                              Subject: this.Subject!,
                              queses: this.questions,
                            ),
                            transitionsBuilder: (_, animation, __, child) {
                              return FadeTransition(
                                opacity: animation,
                                child: child,
                              );
                            },
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 15.0,
                          horizontal: 10,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 5,
                              offset: Offset(2, 2),
                            ),
                          ],
                        ),

                        child: Row(
                          //mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 15.0),
                              child: Icon(Icons.quiz_outlined, size: 35),
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Unit test: ${this.title}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                    ),
                                    maxLines:
                                        1, // or 2, depending on your design
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Take the quiz",
                                      style: TextStyle(
                                        color: const Color(0xFFCB429F),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    GestureDetector(
                      onTap: () async{
                        await auth.downloadAndOpenPdf(widget.id, "ahis");
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 15.0,
                          horizontal: 10,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 5,
                              offset: Offset(2, 2),
                            ),
                          ],
                        ),

                        child: Row(
                          //mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 15.0),
                              child: Icon(
                                Icons.file_download_outlined,
                                size: 35,
                              ),
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Download Notes",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                    ),
                                    maxLines:
                                        1, // or 2, depending on your design
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "PDF",
                                      style: TextStyle(
                                        color: const Color(0xFFCB429F),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    //SizedBox(height: 5),

                    // Padding(
                    //   padding: const EdgeInsets.all(10.0),
                    //   child: Text(
                    //     "Up Next",
                    //     style: TextStyle(
                    //       color: const Color(0xFF183059),
                    //       fontWeight: FontWeight.bold
                    //     )
                    //     ),
                    // ),

                    /* 
                    * TO IMPLEMENT (Up-next LOGIC) ... or... duck this s#!7
                    */

                    // GestureDetector(
                    //   onTap: () {},
                    //   child: Container(
                    //     padding: const EdgeInsets.symmetric(
                    //       vertical: 10.0,
                    //       horizontal: 20,
                    //     ),
                    //     decoration: BoxDecoration(
                    //       color: Colors.white,
                    //       borderRadius: BorderRadius.circular(10),
                    //       boxShadow: [
                    //         BoxShadow(
                    //           color: Colors.grey,
                    //           blurRadius: 5,
                    //           offset: Offset(2, 2),
                    //         ),
                    //       ],
                    //     ),

                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //       children: [
                    //         Column(
                    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //           crossAxisAlignment: CrossAxisAlignment.start,
                    //           children: [
                    //             Text(
                    //               "Download Notes",
                    //               style: TextStyle(
                    //                 fontWeight: FontWeight.bold,
                    //                 fontSize: 17,
                    //               ),
                    //               maxLines: 1, // or 2, depending on your design
                    //               overflow: TextOverflow.ellipsis,
                    //             ),
                    //             Align(
                    //               alignment: Alignment.centerLeft,
                    //               child: Text(
                    //                 "PDF",
                    //                 style: TextStyle(
                    //                   color: const Color(0xFFCB429F),
                    //                   fontWeight: FontWeight.bold,
                    //                   fontSize: 14,
                    //                 ),
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //         Icon(Icons.file_download_outlined, size: 35),

                    //       ],
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  //decoration: BoxDecoration(color: const Color(0xFF183059)),
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              const Color(0xFFA698CD),
                              const Color.fromARGB(255, 105, 164, 183),
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
                                  pageBuilder: (_, __, ___) => CoursesPage(),
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
                                horizontal: 28,
                                vertical: 11,
                              ),
                              child: Text(
                                "B A C K",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              const Color(0xFF72397C),
                              const Color(0xFFBA4098),
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
                                horizontal: 28,
                                vertical: 11,
                              ),
                              child: Text(
                                "S H A R E",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
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
            ],
          ),
        ],
      ),
      drawer: CustomDrawer(),
    );
  }
}

extension on String {
  List<String> parse(String s) {
    return split(s);
  }
}
