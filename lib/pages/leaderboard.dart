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

class LeaderboardPage extends StatefulWidget {
  @override
  _LeaderboardPageState createState() => _LeaderboardPageState();
}

ApiService auth = ApiService();

class _LeaderboardPageState extends State<LeaderboardPage> {
  List<dynamic> leaderboardData = [];
  bool isLoading = true;
  Future<void> _loadTokenAndSet() async {
    final token = await getToken();
    if (token != null) {
      auth.setToken(token);
    }
  }

  @override
  void initState() {
    super.initState();
    _loadTokenAndSet();
    fetchLeaderboardData();
  }

  Future<void> fetchLeaderboardData() async {
    try {
      List<dynamic> data = await auth.getLeaderboard();
      setState(() {
        leaderboardData = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error fetching leaderboard data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        appBar: CustomAppBar(isBangla: true, onLanguageToggle: (bool value) {}),
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
                  SpinKitChasingDots(color: Colors.blue),
                  SizedBox(height: 20),
                  Text(
                    "Loading Leaderboard...",
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

    final sortedLeaderboard = List<Map<String, dynamic>>.from(leaderboardData)
      ..sort((a, b) => b['score'].compareTo(a['score']));

    return Scaffold(
      appBar: CustomAppBar(isBangla: true, onLanguageToggle: (bool value) {}),
      drawer: CustomDrawer(),
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
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Container(
                  color: Colors.white.withOpacity(0.8),
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text("🏆 Leaderboard", textAlign: TextAlign.center, style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    )),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: sortedLeaderboard.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final user = sortedLeaderboard[index];
                    return Card(
                      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                      elevation: 2,
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: index == 0
                              ? Colors.amber
                              : (index == 1
                                    ? Colors.grey
                                    : (index == 2 ? Colors.brown : Colors.blueGrey)),
                          child: Text(
                            '${index + 1}',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        title: Text(
                          user['name']?.isNotEmpty == true
                              ? user['name']
                              : user['username'],
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text('Class: ${user['class']}'),
                        trailing: Text(
                          '${user['score']}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.deepPurple,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
