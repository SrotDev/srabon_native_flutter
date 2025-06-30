import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:srabon/pages/appbar.dart';
import 'dart:async';
import 'package:srabon/pages/ApiService.dart';
import 'package:srabon/pages/course_content.dart';
import 'package:srabon/pages/courses_page.dart';
import 'package:srabon/pages/dashboard.dart';
import 'package:srabon/pages/drawer.dart';
import 'package:srabon/pages/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExamResultPage extends StatefulWidget {
  final String id;
  final String title;
  final String Subject;
  final List<int> chkidx ;
  final List<Question> queses;

  const ExamResultPage({
    Key? key,
    required this.id,
    required this.title,
    required this.Subject,
    required this.chkidx,
    required this.queses,
  }) : super(key: key);

  @override
  _ExamResultPageState createState() => _ExamResultPageState();
}

class _ExamResultPageState extends State<ExamResultPage>{
  @override
   bool isBangla = false;
    void toggleLanguage(bool value) {
      setState(() {
        isBangla = value;
      });
    }
  List<int> right = List.empty(growable: true);
  int score = 0;
  @override
  void initState(){
    
    for(Question Q in widget.queses){
      if(Q.option1 == Q.ans){
        right.add(0);
      }else if(Q.option2 == Q.ans){
        right.add(1);
      }else if(Q.option3 == Q.ans){
        right.add(2);
      }else if(Q.option4 == Q.ans){
        right.add(3);
      }
    }

    for(int i = 0 ; i < widget.queses.length ; i++){
      if(right[i] == widget.chkidx[i]){
        score++;
      }
    }
    
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    

    return Scaffold(
      appBar: CustomAppBar(
        isBangla: isBangla,
        onLanguageToggle: toggleLanguage,
      ),
      resizeToAvoidBottomInset: true,
      drawer: CustomDrawer(),
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
                          "${widget.title} - Quiz Result ",
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
              Expanded(child: SingleChildScrollView(
                physics: BouncingScrollPhysics(), 
                child: Column(
                  children: [
                    SizedBox(height: 15),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(20),

                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
                        child: Text(
                          "You scored ${score}/${widget.queses.length}",
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                            fontWeight : FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                    QuesResultShow(chkidx: widget.chkidx, right: right, qs: widget.queses),
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
                                  pageBuilder: (_, __, ___) => CourseContent(id:widget.id),
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
                      SizedBox(height: 60)
                  ],
                )
                )
                )
            ],
          ),
        ],
      ),
    );
  }
}

class QuesResultShow extends StatefulWidget{
  final List<int> chkidx ;
  final List<int> right;
  final List<Question> qs;

  QuesResultShow({
    required this.chkidx,
    required this.right,
    required this.qs,
  });

  @override
  _QuesResultShowState createState() => _QuesResultShowState();
}

class _QuesResultShowState extends State<QuesResultShow> {
  
  @override
  Widget build(BuildContext context) {
    
    return ListView.builder(
      itemCount: widget.qs.length,
      physics: BouncingScrollPhysics(),
      shrinkWrap: true,
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
                    (widget.right[index] == widget.chkidx[index] ? "Correct Answer" : (widget.chkidx[index] == -1 ? "Not Answered" : "Wrong Answer")),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: (widget.right[index] == widget.chkidx[index] ? Colors.green : (widget.chkidx[index] == -1 ? Colors.grey : Colors.red)),
                      fontSize: 18
                    ),
                  ),
                  SizedBox(height:5),
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
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 12,
                          ),
                          decoration: BoxDecoration(
                            color: (widget.right[index] == optIdx ? Color.fromARGB(
                                    255,
                                    55,
                                    239,
                                    199,
                                  ).withOpacity(0.15): (widget.chkidx[index] == optIdx ? Color.fromARGB(255, 247, 28, 126).withOpacity(0.15): Colors.grey)),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: (widget.right[index] == optIdx ? Color.fromARGB(255, 26, 115, 96).withOpacity(0.15): (widget.chkidx[index] == optIdx ? Color.fromARGB(255, 157, 19, 81).withOpacity(0.15): Colors.grey)),
                              width: 2,
                            ),
                          ),
                          child: Text(
                            option ?? "",
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF183059),
                              fontWeight: widget.chkidx[index] == optIdx || widget.right[index] == optIdx
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                  SizedBox(height: 10,),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Text(
                            "Explanation",
                            
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                      
                            ),
                          ),
                          SizedBox(height:5),
                          Text(
                            "${question.explanation}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color.fromARGB(255, 7, 48, 82),
                              fontWeight: FontWeight.normal,
                      
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
    
  }
}