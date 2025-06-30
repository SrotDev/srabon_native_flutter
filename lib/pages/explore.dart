import 'package:flutter/material.dart';
import 'package:srabon/pages/appbar.dart';
import 'package:srabon/pages/drawer.dart';
import 'package:srabon/pages/ApiService.dart';

class Explore extends StatefulWidget{
  @override
  _ExploreState createState() => _ExploreState();
}

class _ExploreState extends State<Explore>{
  @override
  Widget build(BuildContext context) {
    bool isBangla = false;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    void toggleLanguage(bool value) {
      setState(() {
        isBangla = value;
      });
      
    }
    return Scaffold(
      appBar: CustomAppBar(isBangla: isBangla, onLanguageToggle: toggleLanguage),
      body: Column(),
      drawer: CustomDrawer(),
    );
  }

} 