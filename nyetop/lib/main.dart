import 'package:flutter/material.dart';
import 'package:nyetop/screen/homePage.dart';
import 'package:nyetop/screen/profilPage.dart';

// import 'package:nyetop/screen/profil_page.dart';
// import 'package:nyetop/screen/profile_page.dart';
import 'screen/onboarding.dart';
import 'screen/yourItems.dart';
import 'screen/addItems.dart';
import 'package:nyetop/screen/detailPage.dart';
import 'screen/mainPage.dart';
import 'service/wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky); // Fullscreen
  runApp(MainApp());
}


class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: wrapper(),
      routes: {
        '/profile': (context) => const ProfilPage(),
      },
    );
  }
}
