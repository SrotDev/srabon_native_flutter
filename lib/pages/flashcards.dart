import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:srabon/pages/appbar.dart';
import 'dart:async';
import 'package:srabon/pages/ApiService.dart';
import 'package:srabon/pages/course_content.dart';
import 'package:srabon/pages/dashboard.dart';
import 'package:srabon/pages/drawer.dart';
import 'package:srabon/pages/exam.dart';
import 'package:srabon/pages/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

final double pi = 3.1416;

class ShowFlashcards extends StatefulWidget {
  final String id;
  final String? title;
  final String? subtitle;
  final String? description;
  final String? Subject;
  //final String? article;
  final List<Flashcard> flashes;
  final List<Question> queses;

  ShowFlashcards({
    required this.flashes,
    required this.id,
    required this.queses,
    this.title,
    this.subtitle,
    this.description,
    this.Subject,
  });

  _ShowFlashcardsState createState() => _ShowFlashcardsState();
}

class _ShowFlashcardsState extends State<ShowFlashcards> {
  int i = 0;

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
      drawer: CustomDrawer(),
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset("assets/bak.png", fit: BoxFit.cover),
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
                            "${widget.Subject} | Grade ${grade}",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ) /* fix thisssssssssssssssssssssssssss */,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Flashcards",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF183059),
                ),
              ),
              SizedBox(height: 10),
              Text(
                "${i + 1}/${widget.flashes.length}",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF183059),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40.0,
                  vertical: 10,
                ),
                child: TweenAnimationBuilder<double>(
                  tween: Tween<double>(
                    begin: 0,
                    end: ((i + 1) / widget.flashes.length),
                  ),
                  duration: Duration(milliseconds: 400),
                  builder: (context, value, child) {
                    return LinearProgressIndicator(
                      color: const Color(0xFFCB429F),
                      value: value,
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: AnimatedSwitcher(
                  duration: Duration(milliseconds: 400),
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                        return FadeTransition(opacity: animation, child: child);
                      },
                  child: FlashcardPage(
                    key: ValueKey(i),
                    flashes: widget.flashes,
                    i: i,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                          setState(() {
                            if (i != 0) {
                              i--;
                            } else {
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
                            }
                          });
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
                        onTap: () async {
                          setState(() {
                            if (i < widget.flashes.length - 1) {
                              setState(() {
                                i++;
                              });
                            } else {
                              Navigator.of(context).pushReplacement(
                                PageRouteBuilder(
                                  transitionDuration: Duration(
                                    milliseconds: 400,
                                  ),
                                  pageBuilder: (_, __, ___) => Exam(
                                    id: widget.id,
                                    title: widget.title!,
                                    Subject: widget.Subject!,
                                    queses: widget.queses,
                                  ),
                                  transitionsBuilder:
                                      (_, animation, __, child) {
                                        return FadeTransition(
                                          opacity: animation,
                                          child: child,
                                        );
                                      },
                                ),
                              );
                            }
                          });
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 22,
                            vertical: 11,
                          ),
                          child: Text(
                            (i == widget.flashes.length - 1
                                ? "T A K E  A  Q U I Z"
                                : "N E X T"),
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
            ],
          ),
        ],
      ),
    );
  }
}

class FlashcardPage extends StatefulWidget {
  final List<Flashcard> flashes;
  final int i;
  FlashcardPage({super.key, required this.flashes, required this.i});
  @override
  _FlashcardPageState createState() => _FlashcardPageState();
}

class _FlashcardPageState extends State<FlashcardPage>
    with SingleTickerProviderStateMixin {
  String? keyword;
  String? explanation;

  late AnimationController _controller;
  late Animation<double> _animation;
  bool _showFront = true;

  @override
  void didUpdateWidget(covariant FlashcardPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.i != widget.i) {
      setState(() {
        keyword = widget.flashes.elementAt(widget.i).keyword;
        explanation = widget.flashes.elementAt(widget.i).explanation;
        _showFront = true;
        _controller.reset();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 600),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    keyword = widget.flashes.elementAt(widget.i).keyword;
    explanation = widget.flashes.elementAt(widget.i).explanation;
  }

  void _flipCard() {
    if (_showFront) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    _showFront = !_showFront;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: _flipCard,
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            final angle = _animation.value * pi;
            final isFront = _animation.value < 0.5;

            return Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001) // perspective
                ..rotateY(angle),
              child: isFront
                  ? FlashCardSide(
                      text: keyword!,
                      color: Colors.white,
                      weight: FontWeight.bold,
                      size: 30,
                    )
                  : Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationY(pi),
                      child: FlashCardSide(
                        text: explanation!,
                        color: const Color(0xFFFFFFFF),
                        weight: FontWeight.normal,
                        size: 18,
                      ),
                    ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class FlashCardSide extends StatelessWidget {
  final String text;
  final Color color;
  final FontWeight weight;
  final double size;
  FlashCardSide({
    required this.text,
    required this.color,
    required this.weight,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenWidth * 0.80,
      height: screenHeight * 0.26,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.grey, blurRadius: 5, offset: Offset(2, 2)),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: size,
            color: Colors.black,
            fontWeight: weight,
          ),
          maxLines: 5,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
