import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final bool isBangla;
  final ValueChanged<bool> onLanguageToggle;

  CustomAppBar({required this.isBangla, required this.onLanguageToggle});

  @override
  _CustomAppBarState createState() => _CustomAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background image
        Container(
          width: double.infinity,
          child: Image.asset(
            'assets/main.jpg',
            fit: BoxFit.cover,
          ),
        ),
        AppBar(
          backgroundColor: Colors.transparent,
          elevation: 10,
          title: Row(
            children:[
              Padding(
              padding: const EdgeInsets.all(0.0),
              child: Image.asset(
              'assets/srabon-logo.png',
              height: 32,
                        ),
              ),
            ]),
          actions: [
            
            Padding(
              padding: const EdgeInsets.only(right:20.0),
              child: Row(
                children: [
                  Text('EN ', style: TextStyle(color: Colors.white, fontSize: 16)),
                  Switch(
                    value: widget.isBangla,
                    onChanged: widget.onLanguageToggle,
                    activeColor: Colors.green,
                    inactiveThumbColor: Colors.blue,
                  ),
                  Text(' BN', style: TextStyle(color: Colors.white, fontSize: 16)),
                ],
              ),
            ),
            
          ],
        ),
      ],
    );
  }
}
