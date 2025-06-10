import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:srabon/pages/appbar.dart';
import 'package:srabon/pages/drawer.dart';
import 'package:srabon/pages/getstarted.dart';
import 'package:srabon/pages/preinfo.dart';
import 'dart:ui';
bool isLogin = false;

class Login extends StatefulWidget {
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
      resizeToAvoidBottomInset: true,
      appBar: CustomAppBar(
        isBangla: isBangla,
        onLanguageToggle: toggleLanguage,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset("assets/main.jpg", fit: BoxFit.cover),
          ),
      
          // Semi-transparent overlay (optional)
          Positioned.fill(
            child: Container(color: Color.fromARGB(3, 54, 255, 242)),
          ),
          
          SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height*0.9,
              ),
              
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20.0,
                    right: 20.0,
                    top: 25.0,
                  ),
                  child: SvgPicture.asset('assets/login_img.svg', width: 270),
                ),
      
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20.0,
                    right: 20.0,
                    top: 40.0,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () => setState(() => isLogin = true),
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          padding: EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 24,
                          ),
                          decoration: BoxDecoration(
                            gradient: (isLogin
                                ? LinearGradient(
                                    colors: [
                                      const Color.fromARGB(255, 25, 219, 193),
                                      const Color.fromARGB(255, 3, 185, 142),
                                    ],
                                  )
                                : null),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            "LOGIN",
                            style: TextStyle(
                              fontSize: 18,
                              color: isLogin ? Colors.white : Colors.black,
                              fontWeight: isLogin
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      // Padding(
                      //   padding: const EdgeInsets.only(left:10.0, right : 10.0),
                      //   child: Container(
                      //     color: Colors.black,
                      //     width: 1,
                      //     height: 50,
                      //   ),
                      // ),
                      GestureDetector(
                        onTap: () => setState(() => isLogin = false),
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          padding: EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 16,
                          ),
                          decoration: BoxDecoration(
                            gradient: (!isLogin
                                ? LinearGradient(
                                    colors: [
                                      const Color.fromARGB(255, 25, 219, 193),
                                      const Color.fromARGB(255, 3, 185, 142),
                                    ],
                                  )
                                : null),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            "SIGN UP",
                            style: TextStyle(
                              fontSize: 18,
                              color: !isLogin ? Colors.white : Colors.black,
                              fontWeight: !isLogin
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 24.0),
                  child: AnimatedSwitcher(
                    duration: Duration(milliseconds: 300),
                    // transitionBuilder: (child, animation) {
                    //   return FadeTransition(opacity: animation, child: child);
                    // },
                    child: isLogin ? LoginForm() : SignUpForm(),
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        (!isLogin
                            ? "Already have an account? "
                            : "Don't have an account? "),
                      ),
                      GestureDetector(
                        onTap: () => setState(
                          () => (isLogin ? isLogin = false : isLogin = true),
                        ),
                        child: Center(
                          child: Text(
                            (!isLogin ? "Log In" : "Sign Up"),
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
            )
          ),
          
        ],
      ),

      drawer: CustomDrawer()
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      child: Column(
        children: [
          TextField(decoration: InputDecoration(labelText: "Username")),
          SizedBox(height: 16),
          TextField(
            decoration: InputDecoration(labelText: "Password"),
            obscureText: true,
          ),
          SizedBox(height: 32),
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
                onTap: () {},
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  child: Text(
                    "L O G I N",
                    style: TextStyle(color: Colors.white, fontSize: 16),
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

// SignUp form widget
class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      child: Column(
        children: [
          TextField(decoration: InputDecoration(labelText: "Username")),
          SizedBox(height: 16),
          TextField(decoration: InputDecoration(labelText: "Email")),
          SizedBox(height: 16),
          TextField(
            decoration: InputDecoration(labelText: "Password"),
            obscureText: true,
          ),
          SizedBox(height: 32),
          // button
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
                  Navigator.of(context).pushReplacement(
                    PageRouteBuilder(
                      transitionDuration: Duration(milliseconds: 400),
                      pageBuilder: (_, __, ___) => PreInfo(),
                      transitionsBuilder: (_, animation, __, child) {
                        return FadeTransition(opacity: animation, child: child);
                      },
                    ),
                  );
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  child: Text(
                    "S I G N  U P",
                    style: TextStyle(color: Colors.white, fontSize: 16),
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
