import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:srabon/pages/appbar.dart';
import 'package:srabon/pages/drawer.dart';
///import 'package:file_picker/file_picker.dart';

class CourseCreatePage extends StatefulWidget {
  CourseCreatePage({super.key});

  @override
  _CourseCreatePageState createState() => _CourseCreatePageState();
}

class _CourseCreatePageState extends State<CourseCreatePage> {
  @override
  Widget build(BuildContext context) {
    bool isBangla = false;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    void toggleLanguage(bool value) {
      setState(() {
        isBangla = value;
      });
      // You can add logic to switch app language here
    }

    return Scaffold(
      appBar: CustomAppBar(
        isBangla: isBangla,
        onLanguageToggle: toggleLanguage,
      ),

      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/main.jpg", // Your background image
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 7,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Create AI Generated Course",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30),
                    Expanded(
                      child: InputThings(
                        screenHeight: screenHeight,
                        screenWidth: screenWidth,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 50.0),
                      child: Center(
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
                              onTap: () {},
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 36,
                                  vertical: 14,
                                ),
                                child: Text(
                                  "G E N E R A T E   C O U R S E",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),

      drawer: CustomDrawer(),
    );
  }
}

class InputThings extends StatelessWidget {
  final screenHeight;
  final screenWidth;
  InputThings({required this.screenHeight, required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SingleChildScrollView(
      child: Column(
        children: [
          Text(
            "Course Details",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 76, 76, 76),
            ),
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
                  hintText: 'Enter Course Subject',
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
                  hintText: 'Enter Course Title',
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
            padding: const EdgeInsets.only(bottom: 20, top: 40),
            child: Text(
              "Optional PDF",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 76, 76, 76),
              ),
            ),
          ),

          PdfPickerField(),
        ],
      ),
    );
  }
}

class PdfPickerField extends StatefulWidget {
  const PdfPickerField({super.key});

  @override
  State<PdfPickerField> createState() => _PdfPickerFieldState();
}

class _PdfPickerFieldState extends State<PdfPickerField> {
  String? _fileName;

  // Future<void> _pickPDF() async {
  //   FilePickerResult? result = await FilePicker.platform.pickFiles(
  //     type: FileType.custom,
  //     allowedExtensions: ['pdf'],
  //   );

  //   if (result != null) {
  //     setState(() {
  //       _fileName = result.files.single.name;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color.fromARGB(255, 218, 241, 238),
                      const Color.fromARGB(255, 147, 248, 225),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(30),
                    //onTap: _pickPDF,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 22,
                        vertical: 10,
                      ),
                      child: Text(
                        "Choose File",
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  _fileName ?? 'No file chosen',
                  style: TextStyle(color: Colors.grey[700]),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
