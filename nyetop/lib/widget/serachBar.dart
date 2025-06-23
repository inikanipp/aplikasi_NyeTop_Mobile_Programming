import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class searchBar extends StatelessWidget {
  const searchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        fillColor: Color(0xFFF1F1F1),
        filled: true,
        prefixIcon: Padding(padding: 
          EdgeInsets.only(left: 14),
          child:Icon(Icons.search, size: 24, color: Color(0xFFA1A1A1),),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
          borderSide: BorderSide(color: Color(0xFFF1F1F1))
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
          borderSide: BorderSide(color: Color(0xFFF1F1F1))
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
          borderSide: BorderSide(color: Color(0xFFF1F1F1))
        ),
        hintText: "Cari Laptop",
        hintStyle: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: Color(0xFFA1A1A1)
        )
      ),
      cursorColor:Color(0xFFA1A1A1),
    );
  }
}