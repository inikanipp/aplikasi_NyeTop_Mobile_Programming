import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          color: Color(0xFF060A56),
          child: Column(
          children: [
            Expanded(child: 
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(64),
                  bottomRight: Radius.circular(64)
                ),
              ),
              // child: Container(),
            )), 

            Expanded(child: Container(
              color: const Color(0xFF060A56)
            )),
          ],
        ),
        )
      )
    );
  }
}
