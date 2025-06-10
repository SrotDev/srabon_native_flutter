// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:srabon/pages/appbar.dart';
import 'package:srabon/pages/drawer.dart';
import 'package:srabon/pages/getstarted.dart';
import 'package:srabon/pages/login.dart';
import 'package:srabon/pages/splashscreen.dart';
import 'dart:ui';

List<String> questions = [
  "What's Your Name?",
  "Which class do you read in?",
  "Alright! Which subjects are you studying?",
  "",
];
String? name;
int? level;
List<String> selectedSubjects = [];

class PreInfo extends StatefulWidget {
  const PreInfo({super.key});

  @override
  _PreInfoState createState() => _PreInfoState();
}

class _PreInfoState extends State<PreInfo> {
  int pos = 0;
  bool isBangla = false;

  void setPos(int newPos) {
    setState(() {
      pos = newPos;
    });
  }

  void toggleLanguage(bool value) {
    setState(() {
      isBangla = value;
    });
    // You can add logic to switch app language here
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: CustomAppBar(
        isBangla: isBangla,
        onLanguageToggle: toggleLanguage,
      ),

      body: ConstrainedBox(
        constraints: BoxConstraints(minHeight: screenHeight),
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                "assets/main.jpg", // Your background image
                fit: BoxFit.cover,
              ),
            ),
            Positioned.fill(
              child: Container(color: Color.fromARGB(3, 54, 255, 242)),
            ),

            // Scrollable main content
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Center(
                      child: Container(
                        width: screenWidth * 0.9,
                        padding: EdgeInsets.symmetric(
                          vertical: screenHeight * 0.04,
                          horizontal: screenWidth * 0.05,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color.fromARGB(255, 222, 232, 232),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 30.0,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Progress bar
                            Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: screenHeight * 0.015,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(4, (index) {
                                  return Container(
                                    width: screenWidth * 0.15,
                                    height: 2,
                                    margin: EdgeInsets.symmetric(horizontal: 4),
                                    decoration: BoxDecoration(
                                      color: pos >= index
                                          ? Colors.black
                                          : Colors.grey,
                                      boxShadow: index == 3 && pos == 3
                                          ? [
                                              BoxShadow(
                                                color: Color.fromARGB(
                                                  253,
                                                  207,
                                                  1,
                                                  1,
                                                ),
                                                blurRadius: 30.0,
                                                offset: Offset(0, 5),
                                              ),
                                            ]
                                          : [],
                                    ),
                                  );
                                }),
                              ),
                            ),

                            SizedBox(height: screenHeight * 0.03),

                            // Placeholder (dynamic question area)
                            PlaceHolder(pos: pos, setPos: setPos),

                            SizedBox(height: screenHeight * 0.03),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),

      drawer: CustomDrawer()
    );
  }
}

class PlaceHolder extends StatelessWidget {
  final int pos;
  final Function(int) setPos;

  const PlaceHolder({required this.pos, required this.setPos, super.key});

  @override
  Widget build(BuildContext context) {
    Widget currentChild;

    switch (pos) {
      case 0:
        currentChild = Ques1(setPos: setPos);
        break;
      case 1:
        currentChild = Ques2(setPos: setPos);
        break;
      case 2:
        currentChild = Ques3(setPos: setPos);
        break;
      default:
        currentChild = Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Wonderful, $name!",
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  "I’m setting up your profile as we speak…",
                  style: TextStyle(fontSize: 24),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 60),
              const CircularProgressIndicator(
                strokeWidth: 2.0,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
            ],
          ),
        );
    }

    return AnimatedSize(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300), // Faster animation
        switchInCurve: Curves.easeIn,
        switchOutCurve: Curves.easeOut,
        transitionBuilder: (child, animation) {
          final offsetAnimation = Tween<Offset>(
            begin: const Offset(0.2, 0.0), // smaller offset for subtle slide
            end: Offset.zero,
          ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut));

          final fadeAnimation = CurvedAnimation(
            parent: animation,
            curve: const Interval(
              0.0,
              0.5,
              curve: Curves.easeIn,
            ), // fade completes earlier
          );

          return SlideTransition(
            position: offsetAnimation,
            child: FadeTransition(opacity: fadeAnimation, child: child),
          );
        },
        child: KeyedSubtree(key: ValueKey(pos), child: currentChild),
      ),
    );
  }
}

class Ques1 extends StatefulWidget {
  final Function(int) setPos;
  Ques1({required this.setPos});

  @override
  _Ques1State createState() => _Ques1State();
}

class _Ques1State extends State<Ques1> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 30),
          Text(
            "Let's Get Started!",
            style: TextStyle(
              fontSize: width * 0.08,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 50),
          Text(
            "What's Your Name?",
            style: TextStyle(
              fontSize: width * 0.06,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 30),
          TextField(
            decoration: InputDecoration(
              hintText: name == null ? "Enter your name" : name,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 20),
            ),
            textAlign: TextAlign.center,
            onChanged: (value) => setState(() => name = value),
          ),
          SizedBox(height: 40),
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
                    setState(() {
                      if (name == null || name!.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Please enter your name.")),
                        );
                        return;
                      }
                      widget.setPos(1); // Move to the next question
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    child: Text(
                      "N E X T",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Ques2 extends StatefulWidget {
  final Function(int) setPos;
  Ques2({required this.setPos});

  @override
  _Ques2State createState() => _Ques2State();
}

class _Ques2State extends State<Ques2> {
  @override
  Widget build(BuildContext context) {
    final classes = [6, 7, 8, 9, 10, 11];

    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Text(
            "Hello, ${name ?? 'there'}!",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          Text(
            "Which class do you read in?",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 30),
          Wrap(
            spacing: 20,
            runSpacing: 20,
            alignment: WrapAlignment.center,
            children: classes.map((cls) {
              bool isSelected = level == cls;
              return GestureDetector(
                onTap: () => setState(() => level = cls),
                child: CircleAvatar(
                  radius: 35,
                  backgroundColor: isSelected ? Colors.teal : Colors.grey[300],
                  child: Text(
                    cls.toString(),
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color.fromARGB(255, 169, 207, 197),
                      const Color.fromARGB(255, 172, 241, 225),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(30),
                    onTap: () {
                      setState(() {
                        widget.setPos(0);
                      });
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 12,
                      ),
                      child: Text(
                        "B A C K",
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
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
                      setState(() {
                        if (level == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Please select your class."),
                            ),
                          );
                          return;
                        }
                        widget.setPos(2); // Move to the next question
                      });
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 12,
                      ),
                      child: Text(
                        "N E X T",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNavButton(String label, Color color, VoidCallback onTap) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
      onPressed: onTap,
      child: Text(label, style: TextStyle(fontSize: 16)),
    );
  }
}

class Ques3 extends StatefulWidget {
  final Function(int) setPos;
  Ques3({required this.setPos});

  @override
  _Ques3State createState() => _Ques3State();
}

class _Ques3State extends State<Ques3> {
  List<String> subjectsList = [
    'Physics',
    'Chemistry',
    'Math',
    'History',
    'Economics',
    'Biology',
    'Geography',
    'Agriculture',
    'English',
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Text(
            "Alright! Which subjects are you studying?",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 2.8,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: subjectsList.map((subject) {
              bool isSelected = selectedSubjects.contains(subject);
              return GestureDetector(
                onTap: () {
                  setState(() {
                    if (isSelected) {
                      selectedSubjects.remove(subject);
                    } else {
                      selectedSubjects.add(subject);
                    }
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: isSelected ? Colors.teal : Colors.grey[300],
                    boxShadow: isSelected
                        ? [BoxShadow(color: Colors.greenAccent, blurRadius: 5)]
                        : [],
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    subject,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
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
                      onTap: () {
                        setState(() {
                          widget.setPos(1); // Go back to the previous question
                        });
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 12,
                        ),
                        child: Text(
                          "B A C K",
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

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
                        setState(() {
                          if (selectedSubjects.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "Please select at least one subject.",
                                ),
                              ),
                            );
                            return;
                          }
                          widget.setPos(3); // Move to the next question
                        });
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 12,
                        ),
                        child: Text(
                          "N E X T",
                          style: TextStyle(color: Colors.black, fontSize: 16),
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
    );
  }

  Widget _buildNavButton(String label, Color color, VoidCallback onTap) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
      onPressed: onTap,
      child: Text(label, style: TextStyle(fontSize: 16)),
    );
  }
}
