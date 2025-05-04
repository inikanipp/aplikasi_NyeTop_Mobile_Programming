import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../first_page.dart';
import '../home_page.dart';

class wrapper extends StatefulWidget {
  const wrapper({super.key});

  @override
  State<wrapper> createState() => _wrapper();
}

class _wrapper extends State<wrapper> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            return HomePage();
          }else{
            return FirstPage();
          }
        
        }
      ),
    );
  }
}