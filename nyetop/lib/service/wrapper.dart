import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nyetop/screen/mainPage.dart';
import '../screen/loginPage.dart';
import '../screen/homePage.dart';

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
            final user = snapshot.data as User;
            final uid = user.uid;
            print('User ID: $uid');
            return mainPage(id_user: uid);
          }else{
            return Loginpage();
          }
        }
      ),
    );
  }
}