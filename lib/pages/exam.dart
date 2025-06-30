import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:srabon/pages/appbar.dart';
import 'dart:async';
import 'package:srabon/pages/ApiService.dart';
import 'package:srabon/pages/course_content.dart';
import 'package:srabon/pages/dashboard.dart';
import 'package:srabon/pages/drawer.dart';
import 'package:srabon/pages/examresult.dart';
import 'package:srabon/pages/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

int score = 0;

class Exam extends StatefulWidget {
  final String id;
  final String title;
  final String Subject;
  final List<Question> queses;

  Exam({
    required this.queses,
    required this.id,
    required this.title,
    required this.Subject,
  });

  _ExamState createState() => _ExamState();
}

class _ExamState extends State<Exam> {
  int i = 0;
  @override
  Widget build(BuildContext context) {
    List<int> choiceidx = List.filled(widget.queses.length, -1);
    // TODO: implement build
    bool isBangla = false;
    void toggleLanguage(bool value) {
      setState(() {
        isBangla = value;
      });
    }

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
                          "${widget.title} - Quiz ",
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
              Expanded(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      // Padding(
                      //   padding: const EdgeInsets.all(10.0),
                      //   child: Text(
                      //     "Answer the following questions",
                      //     textAlign: TextAlign.center,
                      //     style: TextStyle(
                      //       fontSize: 25,
                        
                      //       fontWeight: FontWeight.bold,
                      //       color: const Color(0xFF183059),
                      //     ),
                      //   ),
                      // ),
                      SizedBox(height: 10),
                      QuesPage(qs: widget.queses, choiceidx: choiceidx),
                      Row(
                        mainAxisSize: MainAxisSize.max ,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.end,
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
                                    Navigator.of(context).pushReplacement(
                                      PageRouteBuilder(
                                        transitionDuration: Duration(
                                          milliseconds: 400,
                                        ),
                                        pageBuilder: (_, __, ___) => ExamResultPage(id: widget.id, title: widget.title, Subject: widget.Subject, chkidx: choiceidx, queses: widget.queses),
                                        transitionsBuilder:
                                            (_, animation, __, child) {
                                              return FadeTransition(
                                                opacity: animation,
                                                child: child,
                                              );
                                            },
                                      ),
                                    );
                                  });
                                },
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 22,
                                    vertical: 11,
                                  ),
                                  child: Text(
                                    "S U B M I T",

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
                ),
              ),
              SizedBox(height: 70),
            ],
          ),
        ],
      ),
    );
  }
}

class QuesPage extends StatefulWidget {
  final List<Question> qs;
  final List<int> choiceidx;

  QuesPage({super.key, required this.qs, required this.choiceidx});
  _QuesPageState createState() => _QuesPageState();
}

class _QuesPageState extends State<QuesPage> {
  late Question q;
  // @override
  // void didUpdateWidget(covariant QuesPage oldWidget) {
  //   // TODO: implement didUpdateWidget
  //   if (oldWidget.i != widget.i) {
  //     setState(() {
  //       q = widget.qs[widget.i];
  //     });
  //   }
  // }

  @override
  void initState() {
    super.initState();
    q = widget.qs[0];
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.builder(
      itemCount: widget.qs.length - 1,
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        final question = widget.qs[index];
        return Padding(
          padding: const EdgeInsets.only(left: 20.0,right: 20.0, top: 13),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 5,
                  offset: Offset(2, 2),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Text(
                    "Q${index+1}: ${question.question!}",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  ...[
                    question.option1,
                    question.option2,
                    question.option3,
                    question.option4,
                  ].asMap().entries.map((entry) {
                    final optIdx = entry.key;
                    final option = entry.value;
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6.0),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(8),
                        onTap: () {
                          setState(() {
                            widget.choiceidx[index] = optIdx;
                            print(widget.choiceidx);
                          });
                        },
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 12,
                          ),
                          decoration: BoxDecoration(
                            color: widget.choiceidx[index] == optIdx
                                ? Color.fromARGB(
                                    255,
                                    55,
                                    239,
                                    199,
                                  ).withOpacity(0.15)
                                : Colors.grey[100],
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: widget.choiceidx[index] == optIdx
                                  ? Color.fromARGB(255, 23, 150, 97)
                                  : Color(0xFF183059),
                              width: 2,
                            ),
                          ),
                          child: Text(
                            option ?? "",
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF183059),
                              fontWeight: widget.choiceidx[index] == optIdx
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// class QuesShow extends StatefulWidget {
//   final Question q;
//   QuesShow({Key? key, required this.q}) : super(key: key);

//   _QuesShowState createState() => _QuesShowState();
// }

// class _QuesShowState extends State<QuesShow> {
//   int? selectedIndex;

//   @override
//   Widget build(BuildContext context) {
//     final options = [
//       widget.q.option1,
//       widget.q.option2,
//       widget.q.option3,
//       widget.q.option4,
//     ];

//     return Padding(
//       padding: const EdgeInsets.all(20.0),
//       child: Container(
//         width: MediaQuery.of(context).size.width * 0.9,
//         alignment: Alignment.center,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(12),
//           boxShadow: [
//             BoxShadow(color: Colors.grey, blurRadius: 5, offset: Offset(2, 2)),
//           ],
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                 child: Text(
//                   widget.q.question!,
//                   textAlign: TextAlign.left,
//                   style: TextStyle(
//                     fontSize: 20,
//                     color: Colors.black,
//                     fontWeight: FontWeight.bold,
//                   ),
//                   //maxLines: 3,
//                   //overflow: TextOverflow.ellipsis,
//                 ),
//               ),
//               SizedBox(height: 10),
//               ...List.generate(options.length, (idx) {
//                 final option = options[idx];
//                 return Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 6.0),
//                   child: InkWell(
//                     borderRadius: BorderRadius.circular(8),
//                     onTap: () {
//                       setState(() {
//                         selectedIndex = idx;
//                       });
//                       // You can also handle answer checking here if needed
//                     },
//                     child: Container(
//                       width: double.infinity,
//                       padding: EdgeInsets.symmetric(
//                         vertical: 10,
//                         horizontal: 12,
//                       ),
//                       decoration: BoxDecoration(
//                         color: selectedIndex == idx
//                             ? Color(0xFFCB429F).withOpacity(0.15)
//                             : Colors.grey[100],
//                         borderRadius: BorderRadius.circular(8),
//                         border: Border.all(
//                           color: selectedIndex == idx
//                               ? Color(0xFFCB429F)
//                               : Color(0xFF183059),
//                           width: 2,
//                         ),
//                       ),
//                       child: Text(
//                         option ?? "",
//                         style: TextStyle(
//                           fontSize: 16,
//                           color: Color(0xFF183059),
//                           fontWeight: selectedIndex == idx
//                               ? FontWeight.bold
//                               : FontWeight.normal,
//                         ),
//                       ),
//                     ),
//                   ),
//                 );
//               }),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
