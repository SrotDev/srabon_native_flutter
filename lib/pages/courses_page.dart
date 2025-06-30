import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:srabon/pages/appbar.dart';
import 'package:srabon/pages/course_content.dart';
import 'package:srabon/pages/drawer.dart';
import 'package:srabon/pages/ApiService.dart';

ApiService auth = ApiService();
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

List<String> subjectsList = [
  'Physics',
  'Chemistry',
  'Math',
  'History',
  'Economics',
  'Biology',
  'Agriculture',
  'English',
];

class CoursesPage extends StatefulWidget {
  @override
  _CoursesPageState createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  bool _loading = true;

  List<dynamic>? courses;
  List<dynamic>? showcourses;

  Future<void> _loadTokenAndSet() async {
    final token = await getToken();
    if (token != null) {
      auth.setToken(token);
    }
  }

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    await _loadTokenAndSet();
    courses = await auth.getCourses();
    showcourses = courses;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isBangla = false;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    String selectedSubject = "All";
    String searchText = "";

    void toggleLanguage(bool value) {
      setState(() {
        isBangla = value;
      });
    }

    if (_loading) {
      return Scaffold(
        appBar: CustomAppBar(
          isBangla: isBangla,
          onLanguageToggle: toggleLanguage,
        ),
        resizeToAvoidBottomInset: true,
        body: Stack(
          children: [
            Positioned.fill(
              child: Image.asset("assets/main.jpg", fit: BoxFit.cover),
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
                    "Loading...",
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
    return Scaffold(
      appBar: CustomAppBar(
        isBangla: isBangla,
        onLanguageToggle: toggleLanguage,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
        child: Stack(
          children: [
            Column(
              children: [
                Text(
                  "Grow Up Your Skills",
                  style: TextStyle(
                    color: Colors.teal,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  "with our courses",
                  style: TextStyle(
                    color: const Color.fromARGB(118, 2, 143, 96),

                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.grey.shade300),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          blurRadius: 5,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: TextField(
                      //controller: _controller,
                      minLines: 1,
                      maxLines: 2, // Allow multiline input
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        hintText: "Search Courses...",
                        hintStyle: TextStyle(color: Colors.grey),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 12,
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          searchText = value.trim();
                          if (searchText.isEmpty) {
                            showcourses = courses;
                          } else {
                            showcourses = courses?.where((course) {
                              final title =
                                  course['parent']['title']?.toLowerCase() ??
                                  '';
                              return title.contains(searchText.toLowerCase());
                            }).toList();
                          }
                        });
                      },
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.grey.shade300),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          blurRadius: 5,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: DropdownButtonFormField<String>(
                      value:
                          selectedSubject, // You need to define this in your State
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 12,
                        ),
                      ),
                      items: [
                        DropdownMenuItem(value: "All", child: Text("All")),
                        ...subjectsList.map(
                          (subject) => DropdownMenuItem(
                            value: subject,
                            child: Text(subject),
                          ),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          selectedSubject = value!;
                          if (selectedSubject == "All") {
                            showcourses = courses;
                          } else {
                            showcourses = courses?.where((course) {
                              final subject = course['parent']['subject'] ?? '';
                              return subject == selectedSubject;
                            }).toList();
                          }
                          // Optionally, also filter by searchText if you want both filters together:
                          if (searchText.isNotEmpty) {
                            showcourses = showcourses?.where((course) {
                              final title =
                                  course['parent']['title']?.toLowerCase() ??
                                  '';
                              return title.contains(searchText.toLowerCase());
                            }).toList();
                          }
                        });
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: showcourses?.length ?? 0,
                    itemBuilder: (context, index) {
                      final course = showcourses![index];
                      return CourseContainer(
                        name: course['parent']['title'] ?? '',
                        subject: course['parent']['subject'] ?? '',
                        description: course['parent']['subtitle'] ?? '',
                        id: course['courseID']
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      drawer: CustomDrawer(),
    );
  }
}

class CourseContainer extends StatefulWidget {
  final String name;
  final String subject;
  final String description;
  final String id;

  CourseContainer({
    required this.name,
    required this.subject,
    required this.description,
    required this.id
  });

  @override
  _CourseContainerState createState() => _CourseContainerState();
}

class _CourseContainerState extends State<CourseContainer> {
  @override
  Widget build(BuildContext context) {
    String? imageurl = "";
    switch (widget.subject) {
      case "Physics":
        imageurl = "assets/1.jfif";
        break;
      case "Chemistry":
        imageurl = "assets/2.jfif";
        break;
      case "Math":
        imageurl = "assets/3.jfif";
        break;
      case "History":
        imageurl = "assets/4.jfif";
        break;
      case "Economics":
        imageurl = "assets/5.jfif";
        break;
      case "Biology":
        imageurl = "assets/6.jfif";
        break;
      case "Agriculture":
        imageurl = "assets/7.jfif";
        break;
      case "English":
        imageurl = "assets/8.jfif";
        break;
      default:
        imageurl = "assets/other.jpg";
        break;
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 6),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: Colors.black, blurRadius: 5)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                child: Container(
                  height: 225,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(imageurl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0, left: 15, top: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 203, 243, 234),

                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(5),
                        onTap: () {},
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 9,
                            vertical: 5,
                          ),
                          child: Text(
                            widget.subject,
                            style: TextStyle(color: Colors.teal, fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                widget.name,
                textAlign: TextAlign.left,

                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 17.0),
              child: Text(
                widget.description,
                style: TextStyle(color: Colors.grey, fontSize: 16),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(height: 15),
            Center(
              child: Container(
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
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        PageRouteBuilder(
                          transitionDuration: Duration(milliseconds: 400),
                          pageBuilder: (_, __, ___) => CourseContent(id: widget.id),
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
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      child: Text(
                        "V I E W    C O U R S E",
                        style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
