import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text('Halaman Kedua qq'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 16,
          ),
          Container(
            height: 50,
            width: double.infinity,
            // color: Colors.red,
            padding: EdgeInsets.only(left: 20.0, right: 20.0),
            child: Text("Daftar Sekarang", style: GoogleFonts.poppins(
              textStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 24)
            )),
          ),

          Container(
            height: 80,
            width: double.infinity,
            // color: Colors.green,
            padding: EdgeInsets.only(left: 20.0, right: 20.0),
            child: Text("Isi data dirimu dan temukan laptop yang kamu butuhkan dalam hitungan menit.", style: GoogleFonts.poppins(
              textStyle: TextStyle(color: Color(0xFFA9A4A4), fontWeight: FontWeight.normal, fontSize: 16)
            )),
          ),

          Container(
            height: 65,
            width: double.infinity,
            // color: Colors.yellow,
            margin: EdgeInsets.only(left: 20, right: 20),
            decoration: BoxDecoration(
                // color: Colors.yellow,
                color: Color(0xFFF0F0F0),
                border: Border.all(color: Color(0xFFF0F0F0)),
                borderRadius: BorderRadius.all(Radius.circular(26))
              ),
          ),

          Container(
            height: 65,
            width: double.infinity,
            // color: Colors.yellow,
            margin: EdgeInsets.only(left: 20, right: 20, top: 18),
            decoration: BoxDecoration(
                // color: Colors.yellow,
                color: Color(0xFFF0F0F0),
                border: Border.all(color: Color(0xFFF0F0F0)),
                borderRadius: BorderRadius.all(Radius.circular(26))
              ),
          ),

          Container(
            height: 65,
            width: double.infinity,
            // color: Colors.yellow,
            margin: EdgeInsets.only(left: 20, right: 20, top: 18),
            decoration: BoxDecoration(
                // color: Colors.yellow,
                color: Color(0xFFF0F0F0),
                border: Border.all(color: Color(0xFFF0F0F0)),
                borderRadius: BorderRadius.all(Radius.circular(26))
              ),
          ),

          Container(
            alignment: Alignment.center,
            height: 65,
            width: double.infinity,
            // color: Colors.yellow,
            margin: EdgeInsets.only(top : 18),
            child: Text("Or Continue With", style: GoogleFonts.poppins(textStyle: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w700
            )),),
          ),

          Container(
            height: 65,
            width: double.infinity,
            // color: Colors.yellow,
            margin: EdgeInsets.only(left: 20, right: 20, top: 18),
            child: ElevatedButton(onPressed: (){},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/images/google_icon.png"),
                SizedBox(width: 16,),
                Text("Continue With Google", style: GoogleFonts.poppins(
                  textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0XFFA9A4A4))
                ),)
              ],
            )
            ),
          ),

          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: 170),
            height: 30,
            width: double.infinity,
            // color: Colors.green,
            child: Text("Sudah punya akun? Masuk sekarang",
            style: GoogleFonts.poppins(
              textStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.w400)
            ),),
          ),
        ],
      )
    );
  }
}