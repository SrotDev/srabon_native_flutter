import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';


class ApiService {
  final String baseUrl = "https://srabonbackend3.onrender.com/api";
  final String baseurl2 = "https://srabonbackend1.onrender.com/";
  String? _jwtToken;

  //ApiService({required this.baseUrl});

  void setToken(String token) {
    _jwtToken = token;
  }

  Map<String, String> get _authHeaders => {
    'Content-Type': 'application/json',
    if (_jwtToken != null) 'Authorization': 'Bearer $_jwtToken',
  };

  // 1. Server info
  Future<bool> getServerInfo() async {
    final j = await http.get(
      Uri.parse(
        '$baseurl2/?nocache=${DateTime.now().millisecondsSinceEpoch}',
      ),
      headers: {
        "User-Agent":
            "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 Chrome/122.0.0.0 Safari/537.36",
      },
    );
    
    final res = await http.get(
      Uri.parse(
        '$baseUrl/getserverinfo/?nocache=${DateTime.now().millisecondsSinceEpoch}',
      ),
      headers: {
        "User-Agent":
            "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 Chrome/122.0.0.0 Safari/537.36",
      },
    );
    return jsonDecode(res.body)['ready'] == 'True';
  }

  // 2. Login
  Future<String?> login(String username, String password) async {
    final res = await http.post(
      Uri.parse('$baseUrl/login/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}),
    );
    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      setToken(data['token']);
      return data['token'];
    }
    return null;
  }

  // 3. Register
  Future<String?> register(
    String username,
    String password,
    String email,
  ) async {
    final res = await http.post(
      Uri.parse('$baseUrl/register/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'password': password,
        'email': email,
      }),
    );
    if (res.statusCode == 201) {
      final data = jsonDecode(res.body);
      setToken(data['token']);
      return data['token'];
    }
    return null;
  }

  // 4. Get student info
  Future<Map<String, dynamic>?> getStudentInfo() async {
    final res = await http.get(
      Uri.parse('$baseUrl/studentinfo/'),
      headers: _authHeaders,
    );
    //print(res.body);
    if (res.statusCode == 200) return jsonDecode(res.body);
    return null;
  }

  // 5. Update student info
  Future<bool> updateStudentInfo(
    String name,
    int classLevel,
    List<String> subjects,
  ) async {
    final res = await http.post(
      Uri.parse('$baseUrl/studentinfo/'),
      headers: _authHeaders,
      body: jsonEncode({
        'name': name,
        'class': classLevel,
        'subjects': subjects,
      }),
    );
    return res.statusCode == 200;
  }

  // 6. Add course without file
  Future<bool> addCourseJson(String title, String subject) async {
    final res = await http.post(
      Uri.parse('$baseUrl/addcourses/'),
      headers: _authHeaders,
      body: jsonEncode({'title': title, 'subject': subject}),
    );
    return res.statusCode == 200;
  }

  // 7. Get all courses
  Future<List<dynamic>> getCourses() async {
    final res = await http.get(
      Uri.parse('$baseUrl/courses/'),
      headers: _authHeaders,
    );
    return jsonDecode(res.body);
  }

  // 8. Get specific course
  Future<Map<String, dynamic>?> getCourse(String id) async {
    final res = await http.get(
      Uri.parse('$baseUrl/courses/$id/'),
      headers: _authHeaders,
    );
    //print(res.body);
    if (res.statusCode == 200) return jsonDecode(res.body);
    return null;
  }

  // 9. Download course content
  Future<http.Response> downloadCourseContent(String courseId, String lang) async {
    return await http.get(
      Uri.parse('$baseUrl/coursecontent/$courseId/$lang/'),
      headers: _authHeaders,
    );
  }

  Future<void> downloadAndOpenPdf(String courseId, String lang) async {
  final response = await downloadCourseContent(courseId, lang);
  if (response.statusCode == 200) {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/course_${courseId}_$lang.pdf');
    await file.writeAsBytes(response.bodyBytes);
    await OpenFile.open(file.path);
  } else {
    print('Failed to download PDF');
  }
}

  // 10. Create custom course
  Future<bool> createCustomCourse(
    String title,
    String subject,
    int level,
  ) async {
    final res = await http.post(
      Uri.parse('$baseUrl/course/custom/new'),
      headers: _authHeaders,
      body: jsonEncode({'title': title, 'subject': subject, 'level': level}),
    );
    return res.statusCode == 200;
  }

  // 11. Simple chat
  Future<String?> chat(String message) async {
    final res = await http.post(
      Uri.parse('$baseUrl/chat'),
      headers: _authHeaders,
      body: jsonEncode({'message': message}),
    );
    if (res.statusCode == 200) return jsonDecode(res.body)['response'];
    return null;
  }

  // 12. Chat with history
  Future<String?> chatWithHistory(String message, {bool limit = true}) async {
    final res = await http.post(
      Uri.parse('$baseUrl/chats/'),
      headers: _authHeaders,
      body: jsonEncode({'message': message, 'limit': limit.toString()}),
    );
    if (res.statusCode == 200) return jsonDecode(res.body)['message'];
    return null;
  }

  // 13. Add to score
  Future<bool> updateScore(int delta) async {
    final res = await http.post(
      Uri.parse('$baseUrl/score/'),
      headers: _authHeaders,
      body: jsonEncode({'delta_score': delta}),
    );
    return res.statusCode == 200;
  }

  // 14. Get score
  Future<int?> getScore() async {
    final res = await http.get(
      Uri.parse('$baseUrl/score/'),
      headers: _authHeaders,
    );
    if (res.statusCode == 200) return jsonDecode(res.body)['score'];
    return null;
  }

  // 15. Leaderboard
  Future<List<dynamic>> getLeaderboard() async {
    final res = await http.get(
      Uri.parse('$baseUrl/leaderboard/'),
      headers: _authHeaders,
    );
    return jsonDecode(res.body);
  }
}
