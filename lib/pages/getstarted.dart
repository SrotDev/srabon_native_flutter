import 'package:flutter/material.dart';
import 'package:srabon/pages/appbar.dart';
import 'dart:async';
import 'package:srabon/pages/ApiService.dart';
import 'package:srabon/pages/login.dart';

///TO_DO
///make "Start learning with us now" more pretty
bool _loading = true;

ApiService auth = ApiService();


class GetStarted extends StatefulWidget {
  _GetStartedState createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted>
    with SingleTickerProviderStateMixin {
  bool isBangla = false;
  void toggleLanguage(bool value) {
    setState(() {
      isBangla = value;
    });
  }

  Future<void> ensure() async{
    bool result= false;
    while(!result){
      result = await auth.getServerInfo();
      //result2 = await auth.
      await Future.delayed(Duration(seconds: 5));
    }

    setState((){_loading = false;});
  }

  @override
  void initState(){
    super.initState();
    ensure();
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Center(
                    child: Image.asset(
                      'assets/get_started_book.png',
                      width: 300,
                    ),
                  ),
                ),
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "START LEARNING",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 40.0,
                          fontFamily: 'Sans Serif',
                          height: 1.0, // Tighter line height
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Transform.translate(
                        offset: Offset(
                          0,
                          -2,
                        ), // Move up by 10 pixels, adjust as needed
                        child: Text(
                          "WITH US NOW",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 49.6, // Slightly smaller for better fit
                            fontFamily: 'Sans Serif',
                            height: 0.95, // Tighter line height
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25,
                    vertical: 15,
                  ),
                  child: Text(
                    "An inclusive, gamified learning web app for secondary schoolers that personalizes science education through storytelling, quizzes, and AI-generated courses with multilingual and accessibility support.",
                    textAlign: TextAlign.center,
                  ),
                ),

                MainButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MainButton extends StatefulWidget {
  _MainButtonState createState() => _MainButtonState();
}

class _MainButtonState extends State<MainButton> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if(_loading){
      return Center(
        child: Column(
          children: [

            Padding(
              padding: const EdgeInsets.all(30.0),
              child: CircularProgressIndicator(
                  strokeWidth: 2.0,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                ),
            ),
            Text(
              "Checking Server Availability... Please wait...",
              style: TextStyle(
                fontWeight: FontWeight.w100
              ),
            ),
          ],
        ),
      );
    }
    return Center(
      child: Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 25.0),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [const Color(0xFF72397C), const Color(0xFFBA4098)],
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
                          transitionDuration: Duration(milliseconds: 500),
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
                      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                      child: Text(
                        "G E T  S T A R T E D",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
      
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [const Color(0xFFA698CD), const Color(0xFF8AD8F0)],
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(30),
                    onTap: () {},
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                      child: Text(
                        "L E A R N  M O R E",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
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
