import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'second_page.dart';

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        // start background
        body: Container(
          color: Color(0xFF060A56),
          child: Column(
          children: [
            Expanded(child: 
            Container(
              width: 500,
              child: Image.asset( 'assets/images/onBoard1.png',
                    width: 80,
                    height: 80,
                    // fit: BoxFit.cover, // Sesuaikan ukuran gambar
                    ),
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
              // color: Colors.green,
              child: Column(
                children: [
                  SizedBox(height: 73),
                  Expanded(child: 
                    Container(
                      height: 300,
                      width: 350,
                      // color:  Colors.cyanAccent,
                      child: Column(
                        children: [
                          Text("Welcome to  NyeTop", style: GoogleFonts.poppins(
                              textStyle: TextStyle(color: Colors.white, letterSpacing: .5, fontSize: 32, fontWeight: FontWeight.w600)
                            )
                              ),
                          SizedBox(height: 16,),
                          Text("Sewa laptop dari sesama mahasiswa dengan harga terjangkau dan proses cepat.",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(color: Colors.white, letterSpacing: .5, fontSize: 16, fontWeight: FontWeight.w400)),
                          ),
                          SizedBox(height: 128),
                          Container(
                            // color: Colors.red,
                            width: 350,
                            height: 58,
                            child: ElevatedButton( onPressed: () {
                                  Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => SecondPage()),
                                  );
                                }, child: Text('Continue', style: GoogleFonts.poppins(
                                    textStyle: TextStyle( color: Color(0xFF060A56), fontSize: 20, fontWeight: FontWeight.w500
                                    ) ))),
                          )
                        ],
                      ),
                    )
                  ),
                ],
              )
            )),
          ],
        ),
        )
        // end background
      )
    );
  }
}