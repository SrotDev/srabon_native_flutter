import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:srabon/pages/appbar.dart';
import 'dart:async';
import 'package:srabon/pages/ApiService.dart';
import 'package:srabon/pages/course_content.dart';
import 'package:srabon/pages/drawer.dart';
import 'package:srabon/pages/flashcards.dart';
import 'package:srabon/pages/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Article extends StatefulWidget {
  final String id;
  final String? title;
  final String? subtitle;
  final String? description;
  final String? Subject;
  final String? article;
  final List<Flashcard> flashes;
  final List<Question> queses;

  Article({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.Subject,
    required this.article,
    required this.flashes,
    required this.queses,
  });

  _ArticleState createState() => _ArticleState();
}

class _ArticleState extends State<Article> {
  @override
  Widget build(BuildContext context) {
    bool isBangla = false;
    void toggleLanguage(bool value) {
      setState(() {
        isBangla = value;
      });
    }

    // TODO: implement build
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
                          "${widget.title}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 30,
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
                            "${widget.Subject} | Grade 7",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ) /* fix thisssssssssssssssssssssssssss */,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          blurRadius: 10,
                          offset: Offset(2, 2),
                        ),
                      ],
                      //borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 20.0,
                        right: 20,
                        top: 15,
                        bottom: 50,
                      ),
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            MarkdownBody(
                              data: widget.article!,
                              styleSheet: MarkdownStyleSheet(
                                p: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 15.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          const Color(0xFFA698CD),
                                          const Color(0xFF8AD8F0),
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(30),
                                        onTap: () async {
                                          Navigator.of(context).pushReplacement(
                                            PageRouteBuilder(
                                              transitionDuration: Duration(
                                                milliseconds: 400,
                                              ),
                                              pageBuilder: (_, __, ___) =>
                                                  CourseContent(id: widget.id),
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
                                            horizontal: 22,
                                            vertical: 11,
                                          ),
                                          child: Text(
                                            "B A C K",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold
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
                                        onTap: () async {
                                          Navigator.of(context).pushReplacement(
                                            PageRouteBuilder(
                                              transitionDuration: Duration(
                                                milliseconds: 400,
                                              ),
                                              pageBuilder: (_, __, ___) =>
                                                  ShowFlashcards(id: widget.id, flashes: widget.flashes, title: widget.title,Subject: widget.Subject ,queses: widget.queses,),
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
                                            horizontal: 22,
                                            vertical: 11,
                                          ),
                                          child: Text(
                                            "F L A S H C A R D S",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold
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
                      ),
                    ),
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
