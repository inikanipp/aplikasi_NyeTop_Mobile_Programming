import 'package:flutter/material.dart';
import 'package:nyetop/third_page.dart';
import 'first_page.dart';
import 'second_page.dart';
import 'home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'service/firebase_service.dart';

// import 'package:google_fonts/google_fonts.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    home: wrapper(),
    // home: HomePage(),
  ));
} 

