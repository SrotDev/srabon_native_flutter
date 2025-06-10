// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:srabon/pages/chat.dart';
import 'package:srabon/pages/courses_page.dart';
import 'package:srabon/pages/course_page_creation.dart';
import 'package:srabon/pages/dashboard.dart';
import 'package:srabon/pages/getstarted.dart';
import 'package:srabon/pages/login.dart';
import 'package:srabon/pages/preinfo.dart';
import 'package:srabon/pages/splashscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Srabon',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
      ),
      home: SplashScreen(),
      routes : {
        '/login' : (context) => Login(),
        '/getstarted' : (context) => GetStarted(),
        '/dashboard' : (context) => Dashboard(),
        '/chat' : (context) => Chat(),
        '/courses' : (context) => CoursesPage(),
      }
      
    );
  }
}

// class Test extends StatelessWidget{
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build

//     return MaterialApp(
//       home : Column(children: [

//       ],)
//     );
  
//   }
// }
