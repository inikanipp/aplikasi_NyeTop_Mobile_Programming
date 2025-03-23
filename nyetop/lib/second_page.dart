import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'third_page.dart';

class SecondPage extends StatelessWidget{
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

        body: Column(
          children: [
            SizedBox(
              height: 68,
            ),
            Container( //header ni boss
              padding: EdgeInsets.only(left: 30, right: 30),
              width: double.infinity,
              // color: Colors.blue,
              height: 65,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Sign In", style: GoogleFonts.poppins(
                  textStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24)
                  )),
                  SizedBox(
                    height: 8,
                  ),
                  Text("Masuk & Gaskeun!", style: GoogleFonts.poppins(textStyle: TextStyle(
                    fontSize: 16
                  )))
                ],
              ),
            ),

            SizedBox(
              height: 24,
            ),
            
            Container(
              height: 52,
              padding: EdgeInsets.only(left: 30, right: 30),
              child: TextField(
              decoration: InputDecoration(
              label: Text("Input your Username", style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Color(0XFFC8C8C8)))),
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
              )
            ))
            ),

            SizedBox(
              height: 24,
            ),

            Container(
              height: 52,
              padding: EdgeInsets.only(left: 30, right: 30),
              child: TextField(
              decoration: InputDecoration(
              label: Text("Input your Password", style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Color(0XFFC8C8C8)))),
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
              )
            ))
            ),

            Container(
              padding: EdgeInsets.only(left: 30, right: 30),
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(top: 24, bottom: 24),
              child: Text( "Forgot Password ?"),
            ),

            Container(
              width: double.infinity,
              height: 156,
              padding: EdgeInsets.only(left: 30, right: 30),
              // color: Colors.red,
              child: Column(
          
                children: [
                  Expanded(child: 
                    Container(
                      width: double.infinity,
                      // color: Colors.amber,
                      child: ElevatedButton(onPressed: (){},
                            child: Text("Sign In",
                            style: GoogleFonts.poppins(
                            textStyle: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600))),
                            style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0XFF060A56),
                            elevation: 0,
                            shadowColor: Colors.transparent,
                            ),
                            
                            ),        
                    )
                  ),

                  Expanded(child: 
                    Container(
                      width: double.infinity,
                      // color: Colors.lightGreen,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 1,
                            width: 120,
                            color: Color.fromARGB(50, 0, 0, 0),
                          ),
                          Text("Or Sign in with", style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color.fromARGB(50, 0, 0, 0)))),
                          Container(
                            height: 1,
                            width: 120,
                            color: Color.fromARGB(50, 0, 0, 0),
                          )
                        ],
                      ),
                    )
                  ),

                  Expanded(child: 
                    Container(
                      width: double.infinity,
                      // color: Colors.amber,
                      child: ElevatedButton(onPressed: (){},
                            style: ElevatedButton.styleFrom(
                            elevation: 0,
                            shadowColor: Colors.transparent,
                            side: BorderSide(color: Color.fromARGB(50, 0,0,0), width: 1)
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset("assets/images/google_icon.png"),
                                SizedBox(width: 16,),
                                Text("Sign In With Google", style: GoogleFonts.poppins(
                                    textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black)
                                ))
                              ],
                            )
                            ),
                    )
                  ),
                ],
              ),
            ),
          
            Spacer(),
            Container(
              padding: EdgeInsets.only(bottom: 20),
              width: double.infinity,
              // color: Colors.green,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("don't have an account yet? ", style: GoogleFonts.poppins(
                    textStyle: TextStyle(color: Colors.black, fontSize: 14)
                      ),),
                  InkWell(
                    onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> ThirdPage()));
                    },
                    child: Text("Sign Up", style: GoogleFonts.poppins(
                    textStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 14)
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

}