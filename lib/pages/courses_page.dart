import 'package:flutter/material.dart';
import 'package:srabon/pages/appbar.dart';
import 'package:srabon/pages/drawer.dart';

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
  @override
  Widget build(BuildContext context) {
    bool isBangla = false;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    String selectedSubject = "All";

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
                        // setState(() {
                        //   currentMessage = value;
                        //   isSendEnabled = value.trim().isNotEmpty;
                        // });
                      },
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom:10),
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
                        });
                        // Optionally filter your courses here
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: [
                      CourseContainer(
                        name: "Sustainable Farming Techniques",
                        subject: "Agriculture",
                        description: "Cultivating a Greener Future",
                      ),
                      CourseContainer(
                        name: "Exploring the World of English Literature",
                        subject: "English",
                        description:
                            "A Journey Through Stories, Poems, and Plays",
                      ),
                      // Add more CourseContainer widgets here...
                    ],
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

  CourseContainer({
    required this.name,
    required this.subject,
    required this.description,
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
        imageurl =
            "https://images.unsplash.com/photo-1633493702341-4d04841df53b?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NTQyNTN8MHwxfHNlYXJjaHwxfHxQaHlzaWNzfGVufDB8fHx8MTc0OTQ4NDk0NXww&ixlib=rb-4.1.0&q=80&w=1080";
        break;
      case "Chemistry":
        imageurl =
            "https://images.unsplash.com/photo-1532094349884-543bc11b234d?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NTQyNTN8MHwxfHNlYXJjaHwxfHxDaGVtaXN0cnl8ZW58MHx8fHwxNzQ5NDcxMzU2fDA&ixlib=rb-4.1.0&q=80&w=1080";
        break;
      case "Math":
        imageurl =
            "https://images.unsplash.com/photo-1635070041078-e363dbe005cb?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NTQyNTN8MHwxfHNlYXJjaHwxfHxNYXRofGVufDB8fHx8MTc0OTQ4NDgzOXww&ixlib=rb-4.1.0&q=80&w=1080";
        break;
      case "History":
        imageurl =
            "https://images.unsplash.com/photo-1473163928189-364b2c4e1135?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NTQyNTN8MHwxfHNlYXJjaHwxfHxIaXN0b3J5fGVufDB8fHx8MTc0OTUyNDU4M3ww&ixlib=rb-4.1.0&q=80&w=1080";
        break;
      case "Economics":
        imageurl =
            "https://images.unsplash.com/photo-1612178991541-b48cc8e92a4d?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NTQyNTN8MHwxfHNlYXJjaHwxfHxFY29ub21pY3N8ZW58MHx8fHwxNzQ5NDcxMzU2fDA&ixlib=rb-4.1.0&q=80&w=1080";
        break;
      case "Biology":
        imageurl =
            "https://images.unsplash.com/photo-1631556097152-c39479bbff93?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NTQyNTN8MHwxfHNlYXJjaHwxfHxCaW9sb2d5fGVufDB8fHx8MTc0OTU2NDcwMnww&ixlib=rb-4.1.0&q=80&w=1080";
        break;
      case "Agriculture":
        imageurl =
            "https://images.unsplash.com/photo-1560493676-04071c5f467b?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NTQyNTN8MHwxfHNlYXJjaHwxfHxBZ3JpY3VsdHVyZXxlbnwwfHx8fDE3NDk1NjUyMzF8MA&ixlib=rb-4.1.0&q=80&w=1080";
        break;
      case "English":
        imageurl =
            "https://images.unsplash.com/photo-1543109740-4bdb38fda756?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NTQyNTN8MHwxfHNlYXJjaHwxfHxFbmdsaXNofGVufDB8fHx8MTc0OTUyNTczNXww&ixlib=rb-4.1.0&q=80&w=1080";
        break;
      default:
        imageurl = "";
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
                  height: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(imageurl),
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
                "A Journey Through Stories, Poems, and Plays",
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
                          pageBuilder: (_, __, ___) => CoursesPage(),
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
                        style: TextStyle(color: Colors.white, fontSize: 14),
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
