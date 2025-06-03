import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'regisPage.dart';
import 'mainPage.dart';
import 'homePage.dart';

class Loginpage extends StatefulWidget {
  @override
  State<Loginpage> createState() => _LoginpageState();
 
}

class _LoginpageState extends State<Loginpage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  String ? _username;
  String ? _password;
  String ? uid;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _signIn() async {
  _formKey.currentState!.validate();
  _formKey.currentState!.save();
  if (_username != null && _password != null) {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _username!,
        password: _password!,
      );

      uid = userCredential.user!.uid;
      print('UID: $uid');

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => mainPage(id_user: uid!,)),
      );
    } catch (e) {
      print('Error: $e');
    }

  } else {
    print('Username or Password is null');
  }
}


  void _handleSignIn() {
    if (_formKey.currentState!.validate()) {
      // Check if username and password match (you can replace this with your actual authentication logic)
      if (_usernameController.text == "admin" && _passwordController.text == "admin") {
        // Show success popup
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Login Berhasil"),
              content: Text("Selamat datang kembali!"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage(id_user: uid!,imageId: uid.toString(),))
                    );
                  },
                  child: Text("OK"),
                ),
              ],
            );
          },
        );
      } else {
        // Show failure popup
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Login Gagal"),
              content: Text("Username atau password tidak sesuai"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: Text("OK"),
                ),
              ],
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: SvgPicture.asset(
              'assets/images/maki_arrow.svg',
              width: 24,
              height: 24,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: LayoutBuilder(
          builder: (context, constraints){
            return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(height: 68),
                    
                    // Header Section
                    Container(
                      padding: EdgeInsets.only(left: 30, right: 30),
                      width: double.infinity,
                      height: 65,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Sign In",
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 24
                              )
                            )
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Masuk & Gaskeun!",
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(fontSize: 16)
                            )
                          )
                        ],
                      ),
                    ),

                    SizedBox(height: 24),
                    
                    // Username Input
                    Container(
                      height: 72,
                      padding: EdgeInsets.only(left: 30, right: 30),
                      child: TextFormField(
                        controller: _usernameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'username Tidak Boleh Kosong';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          label: Text(
                            "Input your Email Adress",
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Color(0XFFC8C8C8)
                              )
                            )
                          ),
                          prefixIcon: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: SvgPicture.asset(
                              'assets/images/profile.svg',
                              width: 24,
                              height: 24,
                            ),
                          ),
                          filled: true,
                          fillColor: Color(0xFFF0F0F0),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(64),
                            borderSide: const BorderSide(
                              color: Color(0xFFF0F0F0),
                              width: 2
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(64),
                            borderSide: const BorderSide(
                              color: Colors.red,
                              width: 2
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(64),
                            borderSide: const BorderSide(
                              color: Colors.red,
                              width: 2
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(64),
                            borderSide: const BorderSide(
                              color: Color(0XFF060A56),
                              width: 2
                            ),
                          ),
                        ),
                        onSaved: (value){
                          _username = value;
                        },
                      )
                    ),

                    SizedBox(height: 24),

                    // Password Input
                    Container(
                      height: 72,
                      padding: EdgeInsets.only(left: 30, right: 30),
                      child: TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'password Tidak Boleh Kosong';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          label: Text(
                            "Input your Password",
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Color(0XFFC8C8C8)
                              )
                            )
                          ),
                          prefixIcon: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: SvgPicture.asset(
                              'assets/images/lock.svg',
                              width: 24,
                              height: 24,
                            ),
                          ),
                          filled: true,
                          fillColor: Color(0xFFF0F0F0),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(64),
                            borderSide: const BorderSide(
                              color: Color(0xFFF0F0F0),
                              width: 2
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(64),
                            borderSide: const BorderSide(
                              color: Colors.red,
                              width: 2
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(64),
                            borderSide: const BorderSide(
                              color: Colors.red,
                              width: 2
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(64),
                            borderSide: const BorderSide(
                              color: Color(0XFF060A56),
                              width: 2
                            ),
                          ),
                        ),
                        onSaved: (value){
                          _password = value;
                        },
                      )
                    ),

                    // Forgot Password
                    Container(
                      padding: EdgeInsets.only(left: 30, right: 30),
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(top: 24, bottom: 24),
                      child: Text("Forgot Password ?"),
                    ),

                    // Buttons Section
                    Container(
                      width: double.infinity,
                      height: 156,
                      padding: EdgeInsets.only(left: 30, right: 30),
                      child: Column(
                        children: [
                          // Sign In Button
                          Expanded(
                            child: Container(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: (){_signIn();},
                                child: Text(
                                  "Sign In",
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600
                                    )
                                  )
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0XFF060A56),
                                  elevation: 0,
                                  shadowColor: Colors.transparent,
                                ),
                              ),
                            )
                          ),

                          // Divider with Text
                          Expanded(
                            child: Container(
                              width: double.infinity,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: 1,
                                    width: 120,
                                    color: Color.fromARGB(50, 0, 0, 0),
                                  ),
                                  Text(
                                    "Or Sign in with",
                                    style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Color.fromARGB(50, 0, 0, 0)
                                      )
                                    )
                                  ),
                                  Container(
                                    height: 1,
                                    width: 120,
                                    color: Color.fromARGB(50, 0, 0, 0),
                                  )
                                ],
                              ),
                            )
                          ),

                          // Google Sign In Button
                          Expanded(
                            child: Container(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  shadowColor: Colors.transparent,
                                  side: BorderSide(
                                    color: Color.fromARGB(50, 0, 0, 0),
                                    width: 1
                                  )
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset("assets/images/google_icon.png"),
                                    SizedBox(width: 16),
                                    Text(
                                      "Sign In With Google",
                                      style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black
                                        )
                                      )
                                    )
                                  ],
                                )
                              ),
                            )
                          ),
                        ],
                      ),
                    ),
                  
                    Spacer(),

                    // Sign Up Section
                    Container(
                      padding: EdgeInsets.only(bottom: 20),
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "don't have an account yet? ",
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 14
                              )
                            )
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => ThirdPage())
                              );
                            },
                            child: Text(
                              "Sign Up",
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14
                                )
                              )
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              )
              )
             );
          }
        )
      ),
    );
  }
}