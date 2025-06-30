import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:srabon/pages/appbar.dart';
import 'package:srabon/pages/dashboard.dart';
import 'package:srabon/pages/drawer.dart';
import 'package:srabon/pages/getstarted.dart';
import 'package:srabon/pages/preinfo.dart';
import 'package:srabon/pages/ApiService.dart';
import 'dart:ui';
import 'package:shared_preferences/shared_preferences.dart';

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

bool isLogin = false;

ApiService auth = new ApiService();

class Login extends StatefulWidget {
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _loading = true;
  bool isBangla = false;

  void toggleLanguage(bool value) {
    setState(() {
      isBangla = value;
    });
    // You can add logic to switch app language here
  }

  void checkserver() async {
    await auth.getServerInfo();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkserver();
  }

  @override
  Widget build(BuildContext context) {
    // if(_loading){
    //   return Scaffold(
    //   resizeToAvoidBottomInset: true,
    //   appBar: CustomAppBar(
    //     isBangla: isBangla,
    //     onLanguageToggle: toggleLanguage,
    //   ),
    //   body: Stack(
    //     children: [
    //       Positioned.fill(
    //         child: Image.asset("assets/main.jpg", fit: BoxFit.cover),
    //       ),

    //       // Semi-transparent overlay (optional)
    //       Positioned.fill(
    //         child: Container(color: Color.fromARGB(3, 54, 255, 242)),
    //       ),
    //       Center(
    //         child: ,
    //       )
    //       ]
    //       )
    //     );
    // }
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
                maxHeight: MediaQuery.of(context).size.height * 0.9,
              ),

              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20.0,
                      right: 20.0,
                      top: 25.0,
                    ),
                    child: SvgPicture.asset('assets/login_img.svg', width: 350),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20.0,
                      right: 20.0,
                      top: 25.0,
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
                              vertical: 10,
                              horizontal: 30,
                            ),
                            decoration: BoxDecoration(
                              gradient: (isLogin
                                  ? LinearGradient(
                                      colors: [
                                        const Color(0xFFA698CD),
                                        const Color(0xFF8AD8F0),
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
                              vertical: 10,
                              horizontal: 25,
                            ),
                            decoration: BoxDecoration(
                              gradient: (!isLogin
                                  ? LinearGradient(
                                      colors: [
                                        const Color(0xFFA698CD),
                                        const Color(0xFF8AD8F0),
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
                    padding: const EdgeInsets.only(top: 10.0),
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
            ),
          ),
        ],
      ),

      drawer: CustomDrawer(),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  String username = "";
  String password = "";
  String? token;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      child: Column(
        children: [
          SizedBox(height: 35),
          TextField(
            decoration: InputDecoration(labelText: "Username"),
            onChanged: (value) => setState(() => username = value),
          ),
          SizedBox(height: 16),
          TextField(
            decoration: InputDecoration(labelText: "Password"),
            onChanged: (value) => setState(() => password = value),
            obscureText: true,
          ),
          SizedBox(height: 32),
          Container(
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
                onTap: () async {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                      child: Center(
                        child: SpinKitChasingDots(color: Colors.blue),
                      ),
                    ),
                  );
                  var result = await auth.login(username, password);
                  Navigator.of(context).pop();

                  if (result == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Incorrect Username or Password."),
                      ),
                    );
                  } else {
                    token = result;
                    await saveToken(token!);
                    Navigator.of(context).pushReplacement(
                      PageRouteBuilder(
                        transitionDuration: Duration(milliseconds: 400),
                        pageBuilder: (_, __, ___) => Dashboard(),
                        transitionsBuilder: (_, animation, __, child) {
                          return FadeTransition(
                            opacity: animation,
                            child: child,
                          );
                        },
                      ),
                    );
                  }
                },
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
  String username = "";
  String password = "";
  String email = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(labelText: "Username"),
            onChanged: (value) => setState(() => username = value),
          ),
          SizedBox(height: 16),
          TextField(
            decoration: InputDecoration(labelText: "Email"),
            onChanged: (value2) => setState(() => email = value2),
          ),
          SizedBox(height: 16),
          TextField(
            decoration: InputDecoration(labelText: "Password"),
            onChanged: (value3) => setState(() => password = value3),
            obscureText: true,
          ),
          SizedBox(height: 32),
          // button
          Container(
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
                onTap: () async {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                      child: Center(
                        child: SpinKitChasingDots(color: Colors.blue),
                      ),
                    ),
                  );
                  var result;
                  if (username != "" && email != "" && password != "") {
                    result = await auth.register(username, password, email);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Please provide valid Credentials."),
                      ),
                    );
                    Navigator.of(context).pop();
                    return;
                  }
                  Navigator.of(context).pop();
                  if (result == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Something went wrong.")),
                    );
                  } else {
                    await saveToken(result!);

                    if (!mounted) return;
                    Navigator.of(context).pushReplacement(
                      PageRouteBuilder(
                        transitionDuration: Duration(milliseconds: 400),
                        pageBuilder: (_, __, ___) => PreInfo(),
                        transitionsBuilder: (_, animation, __, child) {
                          return FadeTransition(
                            opacity: animation,
                            child: child,
                          );
                        },
                      ),
                    );
                  }
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
