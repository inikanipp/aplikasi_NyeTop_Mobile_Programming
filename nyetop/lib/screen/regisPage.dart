import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'loginPage.dart';
import 'homePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../service/apiService.dart';
import 'mainPage.dart';

class ThirdPage extends StatefulWidget {
  @override
  State<ThirdPage> createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final ApiService iniApi = ApiService();
  String ? _username;
  String ? _password;

  @override
  void dispose(){
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _signUp() async {
    _formKey.currentState!.validate();
    _formKey.currentState!.save();
    if (_username != null && _password != null) {
        try {
          UserCredential userCredential = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(email: _username!, password: _password!);

          print("User registered: ${userCredential.user!.email}");
          String uid = userCredential.user!.uid;

          await iniApi.createUser(uid);

          print('UID: $uid');
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => mainPage(id_user: uid,)),
          );
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            print('Password terlalu lemah.');
          } else if (e.code == 'email-already-in-use') {
            print('Email sudah digunakan.');
          } else {
            print('Error: ${e.message}');
          }
        } catch (e) {
          print(e);
        }
  }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus(); // Unfocus semua TextField
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
                child: Column(
                  children: [
                    SizedBox(height: 68),
                    // Header Container
                    Container(
                      padding: EdgeInsets.only(left: 30, right: 30),
                      width: double.infinity,
                      height: 65,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Sign Up",
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
                            "Bikin Akun, Langsung Sewa!",
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(fontSize: 16)
                            )
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 24),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          // Username TextField
                          Container(
                            height: 72,
                            padding: EdgeInsets.only(left: 30, right: 30),
                            child: TextFormField(
                              controller: _usernameController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Username tidak boleh kosong';
                                }
                                return null;  
                              },

                              decoration: InputDecoration(
                                label: Text(
                                  "Input your Username",
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
                                  borderSide: const BorderSide(color: Color(0xFFF0F0F0), width: 2),
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
                          // Password TextField
                          Container(
                            height: 72,
                            padding: EdgeInsets.only(left: 30, right: 30),
                            child: TextFormField(
                              controller: _passwordController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Password tidak boleh kosong';
                                }
                                if (value.length < 8) {
                                  return 'Password harus memiliki minimal 8 karakter';
                                }
                                if(!RegExp(r'[A-Z]').hasMatch(value)) {
                                  return 'Password harus mengandung huruf besar';
                                }
                                if(!RegExp(r'[0-9]').hasMatch(value)) {
                                  return 'Password harus mengandung angka';
                                }
                                if(!RegExp(r'[a-z]').hasMatch(value)) {
                                  return 'Password harus mengandung huruf kecil';
                                }
                                return null;
                              },
                              
                              obscureText: true,
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
                                  borderSide: const BorderSide(color: Color(0xFFF0F0F0), width: 2),
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
                          SizedBox(height: 24),
                          // Confirm Password TextField
                          Container(
                            height: 72,
                            padding: EdgeInsets.only(left: 30, right: 30),
                            child: TextFormField(
                              controller: _confirmPasswordController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Confirm Password tidak boleh kosong';
                                }
                                if (value != _passwordController.text) {
                                  return 'Password tidak sama';
                                }
                                return null;
                              },
                              obscureText: true,
                              decoration: InputDecoration(
                                label: Text(
                                  "Input your confirm Password",
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
                                  borderSide: const BorderSide(color: Color(0xFFF0F0F0), width: 2),
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
                              )
                            )
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24),
                    // Buttons Container
                    Container(
                      width: double.infinity,
                      height: 156,
                      padding: EdgeInsets.only(left: 30, right: 30),
                      child: Column(
                        children: [
                          Expanded(
                            child: Container(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {_signUp();},
                                child: Text(
                                  "Sign Up",
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
                          Expanded(
                            child: Container(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  shadowColor: Colors.transparent,
                                  side: BorderSide(color: Color.fromARGB(50, 0, 0, 0), width: 1)
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset("assets/images/google_icon.png"),
                                    SizedBox(width: 16),
                                    Text(
                                      "Sign Up With Google",
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
                    // Footer Container
                    Container(
                      padding: EdgeInsets.only(bottom: 20),
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account? ",
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 14
                              )
                            )
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Login now",
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
              )
              )
            );
          }
        )
      ),
    );
  }
}
